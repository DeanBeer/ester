require 'active_support/configurable'
require 'ostruct'
require 'robut'
require 'yaml'

module NRB; module Ester
  class BeerStyle < Robut

    include ActiveSupport::Configurable

    class << self
    private
      def load_styles
        config_reader.load(File.open(config.style_path))
      end
    end


    config_accessor(:config_reader, instance_accessor: false) { YAML }

    config_accessor :style_path, instance_accessor: false do
      File.join Ester.configdir, '2008_bjcp_styles.yml'
    end

    config_accessor :bjcp_styles, instance_accessor: false do
      load_styles
    end


    def initialize(*args)
      super
      self.commands = %w(bjcp style styles)
    end

  private

    attr_accessor :message
    attr_writer :beer_style, :subsection

    def beer_style
      return @beer_style if @beer_style
      return unless message
      @beer_style = without_command.sub(/\s+#{subsection}$/i,'').downcase
    end


    def bjcp_styles
      self.class.bjcp_styles
    end


    def format_apearance(appearance)
      format_generic "Appearance", appearance
    end


    def format_aroma(aroma)
      format_generic "Aroma", aroma
    end


    def format_comments(comments)
      format_generic "Comments", comments
    end


    def format_expamples(expamples)
      format_generic "Commercial Examples", expamples
    end


    def format_flavor(flavor)
      format_generic "Flavor", flavor
    end


    def format_ingredients(ingredients)
      format_generic "Typical Ingredients", ingredients
    end


    def format_mouthfeel(mouthfeel)
      format_generic "Mouthfeel", mouthfeel
    end


    def format_overall(overall)
      format_generic "Oveall Impression", overall
    end


    def format_generic(header, vitals)
      return '' if vitals.nil?
      "#{header}: #{vitals}"
    end


    def format_stats(vitals)
      response = []
      return response if vitals.nil?
      stats_order.each do |stat|
        response << format_generic(stat.upcase, vitals[stat])
      end
      response.join(", ")
    end


    def handle_style(*args)
      data = bjcp_styles[beer_style]
      if data
        response = ["Style #{data[:display]}"]
        sections.each do |section|
          meth = "format_#{section}"
          respond_to?(meth,true) && response << send(meth, data[section])
        end
        reply response.join("\n")
      else
        reply_404
      end
    end
    alias_method :handle_bjcp, :handle_style


    def handle_styles(*args)
      reply styles
    end


    def i_should_handle?(message: message)
      sent_to_me?(message)
    end


    def message_handler(time: time, sender: sender, message: message)
      self.message = message
      super
    end


    def quips
      Ester.quips + [
        "Bring me one.",
        "I doubt I'd like it.",
        "I think you made it up.",
        "Sounds tasty."
      ]
    end

    def random_quip
      quips[rand(quips.length)]
    end


    def reply_404
      reply "Never heard of a #{beer_style}.\n#{random_quip}"
    end


    def sections
      subsection? ? [subsection] : subsection_order
    end


    def stats
      %w( abv color fg ibu og )
    end


    def stats_order
      %i( og fg ibu abv color )
    end


    def styles
      bjcp_styles.keys.inject("") { |m,s| m += "#{s}\n" }
    end


    def subsection
      return @subsection if @subsection
      return unless message
      candidate = message.split(/\s+/).last
      self.subsection = candidate if subsections.include?(candidate)
    end


    def subsection?
      ! subsection.nil?
    end


    def subsection_order
      %i( stats aroma appearance flavor mouthfeel overall comments ingredients examples )
    end


    def subsections
      %w( 
          abv
          appearance
          aroma
          category
          color
          comments
          examples
          fg
          flavor
          ibu
          ingredients
          mouthfeel
          og
          overall
          stats
        )
    end

  end
end; end
