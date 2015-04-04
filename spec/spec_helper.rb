$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'nrb/ester'

RSpec.configure do |config|
  config.order = :random
end
