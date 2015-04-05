require 'nrb/ester/version'
module NRB
  module Ester

    autoload :BeerStyle, 'nrb/ester/beer_style'
    autoload :Robut,     'nrb/ester/robut'
    autoload :Web,       'nrb/ester/web'

    class << self

      def configdir
        File.join gemdir, 'config'
      end

      def gemdir
        File.expand_path File.join( File.dirname(__FILE__), '..', '..')
      end


      def quips
        [
          "Ask the head brewer.",
          "Is it time for a beer yet?"
        ]
      end

    end

  end
end
