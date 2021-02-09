# frozen_string_literal: true

module SoapWs
  class Error < StandardError; end

  class ParserError < Error; end

  class InvalidWebServiceURI < Error; end
end
