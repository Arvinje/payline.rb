require 'spec_helper'

describe Payline::Configuration do
  describe 'SetupHelpers.test_configs' do
    before do
      test_configs
    end

    it 'sets charge_uri for testing purposes' do
      expect(Payline.configuration.charge_uri).to eql '/payment-test/gateway-send'
    end

    it 'sets charge_uri for testing purposes' do
      expect(Payline.configuration.confirmation_uri).to eql '/payment-test/gateway-result-second'
    end

    it 'sets base_gateway for testing purposes' do
      expect(Payline.configuration.base_gateway).to eql 'http://payline.ir/payment-test/gateway-'
    end
  end

  describe '.configure' do
    context 'sets the default values' do
      before do
        Payline.configure do |config|
          config.api_token = 'Asgr3th3bt34hd45'
        end
      end

      it 'sets default main_uri' do
        expect(Payline.configuration.main_uri).to eql 'http://payline.ir'
      end
      it 'sets default charge_uri' do
        expect(Payline.configuration.charge_uri).to eql '/payment/gateway-send'
      end
      it 'sets default confirmation_uri' do
        expect(Payline.configuration.confirmation_uri).to eql '/payment/gateway-result-second'
      end
      it 'sets default base_gateway' do
        expect(Payline.configuration.base_gateway).to eql 'http://payline.ir/payment/gateway-'
      end
    end

    context 'sets the user-requested values' do
      before do
        Payline.configure do |config|
          config.api_token = 'Asgr3th3bt34hd45'
          config.main_uri = 'http://github.com'
          config.charge_uri = '/payment-test/gateway-send'
          config.confirmation_uri = '/payment-test/gateway-result-second'
          config.base_gateway = 'http://payline.ir/payment-test/gateway-'
        end
      end

      it 'sets default main_uri' do
        expect(Payline.configuration.main_uri).to eql 'http://github.com'
      end
      it 'sets default charge_uri' do
        expect(Payline.configuration.charge_uri).to eql '/payment-test/gateway-send'
      end
      it 'sets default confirmation_uri' do
        expect(Payline.configuration.confirmation_uri).to eql '/payment-test/gateway-result-second'
      end
      it 'sets default base_gateway' do
        expect(Payline.configuration.base_gateway).to eql 'http://payline.ir/payment-test/gateway-'
      end
    end
  end
end
