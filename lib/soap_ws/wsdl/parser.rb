# frozen_string_literal: true

require 'ox'

module SoapWs
  module WSDL
    ##
    # This class parses the content into WSDL parts to be called from the
    # client
    class Parser
      def initialize(content)
        @content = content
      end

      def operations
        port_types
          .select { |item| item.key?(:'wsdl:operation') }
          .map { |item| item[:'wsdl:operation'] }
          .flatten
          .select { |item| item[:name] }
          .map { |item| item[:name].to_sym }
          .flatten
      end

      private

      attr_reader :content

      def parsed_content
        @parsed_content ||= Ox.load(content, mode: :hash)
      end

      def port_types
        definitions
          .select { |item| item.key?(:'wsdl:portType') }
          .map { |item| item[:'wsdl:portType'] }
          .flatten
      end

      def definitions
        @definitions ||= parsed_content[:'wsdl:definitions']
      end
    end
  end
end
