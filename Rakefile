require 'yard'
require 'yard/rake/yardoc_task'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

YARD::Rake::YardocTask.new

RSpec::Core::RakeTask.new

task :test => [:spec]
task :default => [:test, :yard]
