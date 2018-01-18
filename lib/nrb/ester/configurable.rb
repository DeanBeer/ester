module NRB; module Ester
  module Configurable

    module ClassMethods

      attr_accessor :config

      def configure
        self.config = default_config
        yield config if block_given?
      end

    private

      def config_reader
        config.config_reader
      end


      def default_config
        OpenStruct.new config_reader: YAML
      end

    end


    def self.included(base)
      base.send :extend, ClassMethods 
    end


  end
end; end
