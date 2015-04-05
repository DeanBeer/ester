require 'robut'
module NRB; module Ester
  class Robut

    include ::Robut::Plugin

    attr_accessor :commands

    def handle(time, sender, message)
      return unless i_should_handle?(message: message)
      message_handler(time: time, sender: sender, message: message)
      return handler_response
    end


    def initialize(reply_to, private_sender=nil)
      super
      self.commands = []
      self.handler_response = nil
    end

  private

    attr_accessor :handler_response

    def i_should_handle?(message: message)
      true
    end


    def message_handler(time: time, sender: sender, message: message)
      command = sent_command(message: message)
      handler = "handle_#{command}"
      respond_to?(handler, true) && send(handler, time: time, sender: sender, message: message)
    end


    def sent_command(message: message)
      message.split.select { |word| commands.include?(word.downcase) }.first
    end


    def without_command(message: message)
      words(message, sent_command).join(' ')
    end

  end
end; end
