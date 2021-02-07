# frozen_string_literal: true

require 'faraday'

require_relative '../errors'
require_relative 'parser'

module SoapWs
  module WSDL
    ##
    # This class represents the WSDL document
    class Document
      extend Forwardable

      CONTENT_TYPE = {
        V1: 'text/xml;charset=UTF-8',
        V2: 'application/soap+xml;charset=UTF-8'
      }.freeze

      def_delegators :parser, :operations

      def initialize(wsdl_url)
        @wsdl_url = wsdl_url

        build
      end

      private

      attr_reader :wsdl_url, :response

      def parser
        @parser ||= Parser.new(response)
      end

      def build
        response = connection.get

        if response.status != 200
          raise(
            SoapWs::ParserError,
            "Error trying to parse the wsdl document provided through #{@wsdl_url}: " \
            "  HTTP status: #{response.status}" \
            "  Response body: #{response.body}"
          )
        end

        @response = response.body
      end

      def connection
        @connection ||= Faraday.new(
          url: @wsdl_url,
          headers: request_headers,
          request: { timeout: 10 }
        )
      end

      def request_headers
        {
          'User-Agent' => "SoapWs #{SoapWs::VERSION}",
          'Content-Type' => CONTENT_TYPE[:V1],
          'Accept' => CONTENT_TYPE[:V1]
        }
      end
    end
  end
end
