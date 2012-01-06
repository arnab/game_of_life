require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new do |t|
  t.options = ["--output-dir", "doc"]
end

task :default => [:yard]
