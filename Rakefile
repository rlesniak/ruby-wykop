require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
  require 'pry'
  require 'wykop'

  def reload!
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/wykop\// }
    files.each { |file| load file }
  end

  pry.start
end
