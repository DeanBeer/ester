lib = File.expand_path(File.join('..','lib'), __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'
Bundler.require :default
require 'robut'
require 'ostruct'
require 'logger'
require 'nrb/ester'

load './Chatfile'
Robut::Web.set :connection, Robut::Connection.new.connect
run NRB::Ester::Web
