# Vidibus::VersionScheduler [![Build Status](https://travis-ci.org/vidibus/vidibus-version_scheduler.png)](https://travis-ci.org/vidibus/vidibus-version_scheduler) [![Code Climate](https://codeclimate.com/github/vidibus/vidibus-version_scheduler.png)](https://codeclimate.com/github/vidibus/vidibus-version_scheduler)

Schedules migration to future versions created by Vidibus::Versioning.

This gem is part of [Vidibus](http://vidibus.org), an open source toolset for building distributed (video) applications.


## Installation

Add `gem "vidibus-version_scheduler"` to your Gemfile. Then call `bundle install` on your console.


## Usage

To use scheduling on a versioned model, just include the lib and you're done:

```ruby
class Book
  include Mongoid::Document
  include Vidibus::Versioning::Mongoid
  include Vidibus::VersionScheduler::Mongoid
end
```

Whenever a version gets created that has a future `created_at` timestamp, a 
`DelayedJob` will be created to migrate your model to that version at the 
specified time. The job will be added to a queue named "versioning".


## TODO

* Solve the serious bug with DelayedJob and Mongoid. See ISSUES.md


## Copyright

&copy; 2011-2013 Andre Pankratz. See LICENSE for details.
