require 'robut/web'
module NRB; module Ester
  class Web < ::Robut::Web

    get '/' do
      say 'llama', ['@dean']
    end

  end
end; end
