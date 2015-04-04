require 'robut'
module NRB; module Ester
  class BJCPStyle

    include ::Robut::Plugin

    def handle(time, sender, message)
      return unless sent_to_me?(message) && without_nick(message) =~ /^style /
      self.message = message
reply "style #{beer_style} subsection #{subsection}"
    end

  private

    attr_accessor :message
    attr_writer :beer_style, :subsection


    def beer_style
      return @beer_style if @beer_style
      return unless message
    end


    def subsection
      return @subsection if @subsection
      return unless message
      candidate = message.split.last.downcase
      self.subsection = candidate if subsections.include?(candidate)
    end


    def subsections
      %w( 
          abv
          appearance
          aroma
          color
          comments
          examples
          fg
          flavor
          ingredients
          ibu
          mouthfeel
          og
          overall
          srm
          stats
        )
    end

  end
end; end
