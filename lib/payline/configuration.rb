module Payline

  # Start by setting the basic configurations
  # You should get a valid api_token by signing up on Payline.ir
  # There are other options to configure if you need, see below for more information.
  #
  # @example
  #   Payline.configure do |config|
  #     config.api_token = 'adxcv-zzadq-polkjsad-opp13opoz-1sdf455aadzmck1244567'
  #   end

  class Configuration
    attr_accessor :main_uri, :charge_uri, :confirmation_uri, :api_token, :base_gateway
    attr_reader :connection

    def initialize
      @main_uri = 'http://payline.ir'
      @charge_uri = '/payment/gateway-send'
      @confirmation_uri = '/payment/gateway-result-second'
      @base_gateway = 'http://payline.ir/payment/gateway-'
      @connection = initialize_faraday
    end

    private
    def initialize_faraday
      connection = Faraday.new(:url => @main_uri) do |config|
        config.request  :url_encoded             # form-encode POST params
        config.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        config.headers['User-Agent'] = 'Payline.rb v0.1.1'
      end
      connection
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure      # Accepts a block for configurations
    self.configuration = Configuration.new
    yield configuration
  end

end
