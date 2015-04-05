$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'nrb/ester'

robut_lib = $LOAD_PATH.grep(/robut/).first
if robut_lib
  robut_mocks = File.expand_path(File.join('..', 'test', 'mocks'), robut_lib)
  robut_mocks && $LOAD_PATH.unshift(robut_mocks) unless $LOAD_PATH.include?(robut_mocks)
end

RSpec.configure do |config|
  config.order = :random
end
