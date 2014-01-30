require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'

spec = eval(File.read('delve.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList[
    'test/*_test.rb',
    'test/scheduler/*_test.rb',
    'test/display/*_test.rb',
    'test/widgets/*_test.rb',
    'test/generator/*_test.rb'
  ]
end

task :default => [:test]
