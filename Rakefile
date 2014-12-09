require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "nextbus"
    gem.summary = %Q{NextBus API client for TTC}
    gem.description = %Q{NextBus API client for TTC}
    gem.email = "hello@jessebuchanan.ca"
    gem.homepage = "http://github.com/neweryankee/nextbus"
    gem.authors = ["Jesse Buchanan", "Greg Sterndale"]
    gem.add_dependency "httparty", "= 0.5.2"
    gem.add_dependency "hashie", "= 0.1.8"
    gem.add_development_dependency "mocha", ">= 0.9.7"
    #gem.add_development_dependency "ruby-debug", ">= 0.10.3"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

#task :test => :check_dependencies

task :default => :test

# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""

#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "nextbus #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
