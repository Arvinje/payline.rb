require 'spec_helper'

describe Payline::Confirmation do

  before do
    test_configs
  end

  describe '#request' do
    context "when it's a valid request" do
      let(:confirmation) { Payline::Confirmation.new(id_get: 79968, trans_id: 72085) }
      before do
        @response = confirmation.request
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
        let(:invalid_confirmation) { Payline::Confirmation.new(id_get: 79968, trans_id: 72085) }

        it 'rises a BadAPIToken exception' do
          expect{ invalid_confirmation.request }.to raise_error(Payline::BadAPIToken)
        end
      end

      context 'when trans_id is invalid for this id_get' do
        let(:invalid_confirmation) { Payline::Confirmation.new(id_get: 79968, trans_id: 1000) }

        it 'rises a FailedTransaction exception' do
          expect{ invalid_confirmation.request }.to raise_error(Payline::FailedTransaction)
        end
      end

      context 'when id_get is nil' do
        let(:invalid_confirmation) { Payline::Confirmation.new(trans_id: 72085) }

        it 'rises a BadIdGet exception' do
          expect{ invalid_confirmation.request }.to raise_error(Payline::BadIdGet)
        end
      end

      context 'when trans_id is nil' do
        let(:invalid_confirmation) { Payline::Confirmation.new(id_get: 79968) }

        it 'rises a BadTransId exception' do
          expect{ invalid_confirmation.request }.to raise_error(Payline::BadTransId)
        end
      end

    end
  end

end
