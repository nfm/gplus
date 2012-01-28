#!/usr/bin/env rake

require "bundler/gem_tasks"

# Define a task to make sure the gem's files are world readable.
task :set_permissions do
  system("find . -type f -exec chmod 644 {} \\;")
  system("find . -type d -exec chmod 755 {} \\;")
end

# Add :set_permissions as a dependency for the :build, :install, and :release
# tasks that bundler provides, so that the correct permissions are always set.
task :build => :set_permissions
task :install => :set_permissions
task :release => :set_permissions

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new(:yard)
rescue LoadError
  puts "You need to install YARD. Run `bundle install`."
end
