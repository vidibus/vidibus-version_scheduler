module Vidibus
  module VersionScheduler
    module Mongoid
      extend ActiveSupport::Concern

      included do
        embeds_many :scheduled_versions, :as => :scheduled, :class_name => "Vidibus::VersionScheduler::ScheduledVersion"
      end
    end
  end
end
