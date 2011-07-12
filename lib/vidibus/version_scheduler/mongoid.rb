module Vidibus
  module VersionScheduler
    module Mongoid
      extend ActiveSupport::Concern

      included do
        embeds_many :scheduled_versions, :as => :scheduled, :class_name => "Vidibus::VersionScheduler::ScheduledVersion"
      end

      def sync_scheduled_versions!
        future_versions = versions.where(:created_at.gt => Time.now)
        if future_versions.any?
          for version in future_versions
            scheduled = scheduled_versions.where(:version_uuid => version.uuid)
            future = version.created_at > Time.now
            if future and scheduled.empty?
              scheduled_versions.create(:version_uuid => version.uuid)
            elsif !future and scheduled.any?
              scheduled.destroy_all
            end
          end
        elsif scheduled_versions.any?
          scheduled_versions.destroy_all
        end
        true
      end
    end
  end
end
