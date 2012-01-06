require 'yard'
require 'yard/rake/yardoc_task'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

YARD::Rake::YardocTask.new
RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new

task :test => [:spec, :cucumber]
task :default => [:test, :yard]
