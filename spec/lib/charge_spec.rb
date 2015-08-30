require 'spec_helper'

describe Payline::Charge do

  before do
    test_configs
  end

  describe '#request' do
    context "when it's a valid request" do
      let(:charge) { Payline::Charge.new(amount: 20000, redirect_uri: 'localhost:4567/api/v1/') }
      before do
        @response = charge.request
      end

      it 'retruns an instance of Payline::Response' do
        expect(@response.class).to be(Payline::Response)
      end

      it 'returns a valid object' do
        expect(@response.valid?).to be true
      end
    end

    context "when it's an invalid request" do
      context 'when api_token is invalid' do
        before do
          Payline.configure do |config|
            config.api_token = 'BAD_API_TOKEN'
            config.charge_uri = '/payment-test/gateway-send'
            config.confirmation_uri = '/payment-test/gateway-result-second'
            config.base_gateway = 'http://payline.ir/payment-test/gateway-'
          end
        end
        let(:invalid_charge) { Payline::Charge.new(amount: 20000, redirect_uri: 'localhost:4567/api/v1/') }

        it 'rises a BadAPIToken exception' do
          expect{ invalid_charge.request }.to raise_error(Payline::BadAPIToken)
        end
      end

      context 'when the requested amount is invalid' do
        let(:invalid_charge) { Payline::Charge.new(amount: 200, redirect_uri: 'localhost:4567/api/v1/') }

        it 'rises a BadAmount exception' do
          expect{ invalid_charge.request }.to raise_error(Payline::BadAmount)
        end
      end

      context 'when redirect_uri is nil' do
        let(:invalid_charge) { Payline::Charge.new(amount: 20000) }

        it 'rises a BadIdGet exception' do
          expect{ invalid_charge.request }.to raise_error(Payline::BadRedirectURI)
        end
      end
    end
    
  end

end
