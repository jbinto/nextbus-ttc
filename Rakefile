# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "nextbus-ttc"
  gem.homepage = "http://github.com/jbinto/nextbus-ttc"
  gem.license = "MIT"
  gem.summary = %Q{NextBus API client for TTC}
  gem.description = %Q{NextBus API client for TTC}
  gem.email = "hello@jessebuchanan.ca"
  gem.authors = ["Jesse Buchanan", "Greg Sterndale"]
  # dependencies defined in Gemfile
  gem.add_dependency "httparty", "= 0.13.3"
  gem.add_dependency "hashie", "= 0.5.2"
  gem.add_development_dependency "mocha", "= 1.1.0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "nextbus-ttc #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
