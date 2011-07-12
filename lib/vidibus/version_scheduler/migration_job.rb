module Vidibus
  module VersionScheduler
    class MigrationJob < Struct.new(:version_uuid)
      def initialize(uuid)
        self.version_uuid = uuid or raise(ArgumentError)
      end

      def perform
        return unless version = Vidibus::Versioning::Version.where(:uuid => version_uuid).first
        return unless versioned = version.versioned
        versioned.migrate!(version.number)
      end
    end
  end
end
