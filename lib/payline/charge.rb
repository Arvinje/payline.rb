module Payline

  # Initialize a payment request:
  # Payline::Charge.new(amount: AMOUNT, redirect_uri: 'REDIRECT_URI')
  #
  # Make the request by calling 'request' on the object:
  # response = charge_instance.request
  #
  # If the request was successful, it returns an instance of Payline::Response with a true value for 'valid?'.
  # Beware that in case of an error in payment, it'll rise a respective error based on the received response.
  #
  # You can generate the requested payment gateway address by calling 'gateway' on the object:
  # response.gateway
  #
  # @example
  #   payment = Payline::Charge.new(amount: 250000, redirect_uri: 'http://localhost:3000/payment')
  #   response = payment.request
  #   response.valid?
  # => true
  #   response.gateway
  # => 'http://payline.ir/payment/gateway-79968'
  #

  class Charge
    attr_accessor :amount, :redirect_uri

    def initialize(options = {})
      @connection = Payline.configuration.connection
      @amount = options[:amount]
      @redirect_uri = options[:redirect_uri]
      @response = Response.new
    end

    def request
      response = @connection.post Payline.configuration.charge_uri, { api: Payline.configuration.api_token, amount: @amount, redirect: @redirect_uri }
      @response.body = response.body
      @response.validate_request
    end

  end
end
