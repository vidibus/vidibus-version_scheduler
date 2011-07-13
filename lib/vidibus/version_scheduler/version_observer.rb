module Vidibus
  module VersionScheduler
    class VersionObserver < ::Mongoid::Observer
      observe Vidibus::Versioning::Version

      def after_save(version)
        schedule(version) if scheduled?(version)
      end

      protected

      def scheduled?(version)
        version.versioned_type.constantize.ancestors.include?(Vidibus::VersionScheduler::Mongoid)
      end

      def schedule(version)
        scheduled = ScheduledVersion.where(:version_uuid => version.uuid)
        if version.created_at > Time.now
          different = scheduled.where(:run_at.ne => version.created_at)
          different.destroy_all if different.any?
          ScheduledVersion.create!(:version_uuid => version.uuid, :scheduled => version.versioned) unless scheduled.any?
        elsif scheduled.any?
          scheduled.destroy_all
        end
      end
    end
  end
end
