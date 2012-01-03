#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')
task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new(:yard)
rescue LoadError
  puts "You need to install YARD. Run `bundle install`."
end
