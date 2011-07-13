module Vidibus
  module VersionScheduler
    module Mongoid
      extend ActiveSupport::Concern

      included do
        has_many :scheduled_versions, :as => :scheduled, :class_name => "Vidibus::VersionScheduler::ScheduledVersion", :dependent => :destroy
      end
    end
  end
end
