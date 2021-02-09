# frozen_string_literal: true

require 'spec_helper'

class Calculator
  include SoapWs::Client

  wsdl 'http://www.dneonline.com/calculator.asmx'
end

RSpec.describe SoapWs::Client do
  subject(:web_service) { Calculator.new }

  describe '.wsdl' do
    it 'appends wsdl if the url provided does not have one' do
      location = Class.new do
        include SoapWs::Client

        wsdl 'http://www.dneonline.com/calculator.asmx'
      end

      expect(location.wsdl_url).to eq 'http://www.dneonline.com/calculator.asmx?wsdl'
    end

    it 'does not append ?wsdl if the url provided does have one' do
      location = Class.new do
        include SoapWs::Client

        wsdl 'http://www.dneonline.com/calculator.asmx?wsdl'
      end

      expect(location.wsdl_url).to eq 'http://www.dneonline.com/calculator.asmx?wsdl'
    end

    it 'raise an error if the wsdl is not over http or https' do
      expect do
        location = Class.new do
          include SoapWs::Client

          wsdl 'test.wsdl'
        end
      end.to raise_error(SoapWs::InvalidWebServiceURI)
    end
  end

  describe '#operations' do
    it 'list operations from web service' do
      expect(web_service.operations).to eq %i[Add Subtract Multiply Divide]
    end
  end
end
