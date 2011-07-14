module Vidibus
  module VersionScheduler
    module Mongoid
      extend ActiveSupport::Concern

      included do
        has_many :scheduled_versions, :as => :scheduled, :class_name => "Vidibus::VersionScheduler::ScheduledVersion", :dependent => :destroy
      end

      def next_scheduled_version
        @next_scheduled_version ||= scheduled_versions.where(:run_at.gt => Time.now).asc(:run_at).limit(1).first
      end
    end
  end
end
