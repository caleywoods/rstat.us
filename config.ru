require 'rubygems'
require 'bundler/setup'
require 'rack/mount'
require "sprockets"
require 'uglifier'
require 'sass'

require File.dirname(__FILE__) + '/rstatus'

ENV['RACK_ENV'] ||= "development"

unless ENV['RACK_ENV'] == "production"
  config = YAML.load_file(File.join(File.dirname(__FILE__) + '/config/config.yml'))[ENV['RACK_ENV']]

  config.each do |key, value|
    ENV[key] = value
  end
else
  require 'exceptional'
  use Rack::Exceptional, ENV['EXCEPTIONAL_KEY']
end

env = Sprockets::Environment.new(Rstatus.root.to_s)
env.static_root = File.join(Rstatus.root, "public", "assets")
env.paths.concat [File.join(Rstatus.root, "assets")]
env.logger = Rstatus.log
env.js_compressor = Uglifier.new
compressor = Object.new
def compressor.compress(source)
  Sass::Engine.new(source,
                   :syntax => :sass, :style => :compressed
                  ).render
end
env.css_compressor = compressor

env.precompile("assets")

Routes = Rack::Mount::RouteSet.new do |set|
  # add_route takes a rack application and conditions to match with
  #
  # valid conditions methods are any method on Rack::Request
  # the values to match against may be strings or regexps
  #
  # See Rack::Mount::RouteSet#add_route for more options.
  set.add_route Rstatus

  set.add_route env
end

# The route set itself is a simple rack app you mount
run Routes
