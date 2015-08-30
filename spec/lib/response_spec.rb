require 'spec_helper'

describe Payline::Response do

  before :all do
    test_configs
  end

  describe '#validate_request' do
    before do
      @response = Payline::Response.new
    end

    context 'when API token is invalid' do
      before do
        @response.body = '-1'
      end
      it 'raises BadAPIToken' do
        expect{ @response.validate_request }.to raise_error Payline::BadAPIToken
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when the requested amount is invalid' do
      before do
        @response.body = '-2'
      end
      it 'raises BadAmount' do
        expect{ @response.validate_request }.to raise_error Payline::BadAmount
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when redirect URI is invalid (probably nil)' do
      before do
        @response.body = '-3'
      end
      it 'raises BadRedirectURI' do
        expect{ @response.validate_request }.to raise_error Payline::BadRedirectURI
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when the requested gateway was not found' do
      before do
        @response.body = '-4'
      end
      it 'raises NotFoundError' do
        expect{ @response.validate_request }.to raise_error Payline::NotFoundError
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when the gateway was found' do
      before do
        @response.body = rand(100000).to_i.to_s
        @response.validate_request
      end

      it 'generates gateway url' do
        expect(@response.gateway).to eql (Payline.configuration.base_gateway + @response.body)
      end

      it 'sets @valid to true' do
        expect(@response.valid).to eql true
      end
    end

    context 'when the response is invalid' do
      before do
        @response.body = '234234235736.324234'
      end

      it 'raises InvalidResponse' do
        expect{ @response.validate_request }.to raise_error(Payline::InvalidResponse)
      end

      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end
  end

  describe '#validate_confirmation' do
    before do
      @response = Payline::Response.new
    end

    context 'when API token is invalid' do
      before do
        @response.body = '-1'
      end
      it 'raises BadAPIToken' do
        expect{ @response.validate_confirmation }.to raise_error Payline::BadAPIToken
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when the trans_id is invalid' do
      before do
        @response.body = '-2'
      end
      it 'raises BadTransId' do
        expect{ @response.validate_confirmation }.to raise_error Payline::BadTransId
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when id_get is invalid' do
      before do
        @response.body = '-3'
      end
      it 'raises BadIdGet' do
        expect{ @response.validate_confirmation }.to raise_error Payline::BadIdGet
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when the transaction has failed' do
      before do
        @response.body = '-4'
      end
      it 'raises FailedTransaction' do
        expect{ @response.validate_confirmation }.to raise_error Payline::FailedTransaction
      end
      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end

    context 'when the transaction was successful' do
      before do
        @response.body = '1'
        @response.validate_confirmation
      end

      it 'sets @valid to true' do
        expect(@response.valid).to eql true
      end
    end

    context 'when the response is invalid' do
      before do
        @response.body = '234234235736.324234'
      end

      it 'raises InvalidResponse' do
        expect{ @response.validate_confirmation }.to raise_error(Payline::InvalidResponse)
      end

      it 'sets @valid to false' do
        expect(@response.valid).to eql false
      end
    end
  end

end
