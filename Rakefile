require 'rubygems'
require 'rake'
require 'lib/ipodcastly/version'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ipodcastly"
    gem.version = Ipodcastly::Version::STRING
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "barushev@gmail.com"
    gem.homepage = "http://github.com/denis/ipodcastly"
    gem.authors = ["Denis Barushev"]
    gem.add_dependency "rb-appscript", ">= 0.5.3"
    gem.add_dependency "httparty", ">= 0.4.5"
    gem.add_dependency "choice", ">= 0.1.4"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "mocha", ">= 0.9.8"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = Ipodcastly::Version::STRING

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ipodcastly #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
