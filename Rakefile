require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.test_files = FileList['test/*_test.rb']
  test.verbose = true
end

Rake::TestTask.new(:test_rails) do |test|
  test.libs << 'test'
  test.test_files = FileList['test/rails/*_test.rb']
  test.verbose = true
end

Rake::TestTask.new(:rep_test) do |test|
  test.libs << 'rep_test'
  test.test_files = FileList['rep_test/*_test.rb']
  test.verbose = true
end

task :default => [:test, :rep_test]
