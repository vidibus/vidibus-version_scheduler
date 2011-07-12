module Vidibus
  module VersionScheduler
    class VersionObserver < ::Mongoid::Observer
      observe Vidibus::Versioning::Version

      def after_save(version)
        schedule(version) if scheduled?(version)
      end

      protected

      def scheduled?(version)
        version.versioned.respond_to?(:scheduled_versions)
      end

      def schedule(version)
        versioned = version.versioned
        scheduled = versioned.scheduled_versions.where(:version_uuid => version.uuid)
        if version.created_at > Time.now
          different = scheduled.where(:run_at.ne => version.created_at)
          different.destroy_all if different.any?
          versioned.scheduled_versions.create!(:version_uuid => version.uuid) unless scheduled.any?
        elsif scheduled.any?
          scheduled.destroy_all
        end
      end
    end
  end
end
