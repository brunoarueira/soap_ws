# frozen_string_literal: true

require 'forwardable'

require_relative 'wsdl/document'

module SoapWs
  ##
  # This is the client to include in your class and work with the desired web
  # service via SOAP
  module Client
    def self.included(base)
      base.extend(ClassMethods)
      base.include(InstanceMethods)
    end

    # :nodoc
    module ClassMethods
      attr_reader :wsdl_url

      def wsdl(wsdl_url)
        @wsdl_url = if wsdl_url.end_with?('?wsdl')
                      wsdl_url
                    else
                      "#{wsdl_url}?wsdl"
                    end
      end
    end

    # :nodoc
    module InstanceMethods
      extend Forwardable

      def_delegators :@wsdl_document, :operations

      def initialize
        @wsdl_document = WSDL::Document.new(self.class.wsdl_url)
      end

      private

      attr_reader :wsdl_document
    end
  end
end
