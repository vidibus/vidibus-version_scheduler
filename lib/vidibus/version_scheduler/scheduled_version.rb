module Vidibus
  module VersionScheduler
    class ScheduledVersion
      include ::Mongoid::Document

      embedded_in :scheduled, :polymorphic => true

      field :run_at, :type => Time
      field :version_uuid, :type => String
      field :job_id, :type => String

      before_validation :set_run_at
      validates :version_uuid, :version, :presence => true

      before_create :ensure_job
      before_destroy :remove_job

      def version
        @version ||= Vidibus::Versioning::Version.where(:uuid => version_uuid).first
      end

      def job
        @job ||= begin
          Delayed::Backend::Mongoid::Job.find(job_id) if job_id
        rescue ::Mongoid::Errors::DocumentNotFound
        end
      end

      protected

      def set_run_at
        return unless version
        self.run_at ||= version.created_at
      end

      def ensure_job
        return if job
        if version and Time.now < run_at
          @job = Delayed::Job.enqueue(MigrationJob.new(version_uuid), :priority => 1, :run_at => run_at)
          self.job_id = @job.id
        end
      end

      def remove_job
        job.destroy if job
      end
    end
  end
end
