require "vidibus/version_scheduler/mongoid"
require "vidibus/version_scheduler/scheduled_version"
require "vidibus/version_scheduler/migration_job"
require "vidibus/version_scheduler/version_observer"

Mongoid.observers = Vidibus::VersionScheduler::VersionObserver
Mongoid.instantiate_observers
