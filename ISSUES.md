# Issues

## Adding an embedded collection to versioned_attributes

This may cause an error which puts DelayedJob into an endless loop! Backtrace:

```
undefined method `_index=' for #<BSON::OrderedHash:0x1047987e0>
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:371:in `reindex'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/bson-1.3.1/lib/../lib/bson/types/object_id.rb:129:in `each_with_index'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:370:in `each'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:370:in `each_with_index'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:370:in `reindex'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:407:in `rebind'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:252
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/atomic.rb:58:in `call'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/atomic.rb:58
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/atomic.rb:79:in `call'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/atomic.rb:79:in `count_executions'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/atomic.rb:57:in `atomically'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:252:in `substitute'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:249:in `tap'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/embedded/many.rb:249:in `substitute'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/accessors.rb:104:in `substitute'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/accessors.rb:161:in `scheduled_versions='
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes/processing.rb:138:in `send'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes/processing.rb:138:in `process_relations'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes/processing.rb:133:in `each_pair'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes/processing.rb:133:in `process_relations'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes/processing.rb:121:in `process_pending'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes/processing.rb:28:in `process'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/attributes.rb:115:in `attributes='
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/vidibus-versioning-0.1.0/lib/vidibus/versioning/mongoid.rb:85:in `migrate!'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/proxy.rb:111:in `send'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/mongoid-2.0.2/lib/mongoid/relations/proxy.rb:111:in `method_missing'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/vidibus-version_scheduler-0.1.0/lib/vidibus/version_scheduler/migration_job.rb:11:in `perform'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/backend/base.rb:87:in `invoke_job'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:120:in `run'
/Users/punkrats/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/timeout.rb:62:in `timeout'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:120:in `run'
/Users/punkrats/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/benchmark.rb:308:in `realtime'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:119:in `run'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:191:in `reserve_and_run_one_job'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:104:in `work_off'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:103:in `times'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:103:in `work_off'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:78:in `start'
/Users/punkrats/.rvm/rubies/ruby-1.8.7-p249/lib/ruby/1.8/benchmark.rb:308:in `realtime'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:77:in `start'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:74:in `loop'
/Users/punkrats/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.1.4/lib/delayed/worker.rb:74:in `start'
```
