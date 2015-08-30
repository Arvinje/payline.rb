module Payline

  # Initialize a confirmation request:
  # Payline::Confirmation.new(id_get: ID_GET, trans_id: TRANS_ID)
  #
  # Make the request by calling 'request' on the object:
  # confirmation_instance.request
  #
  # If the request was successful, it returns an instance of Payline::Response with a true value for 'valid?'.
  # Beware that in case of an error in payment, it'll rise a respective error based on the received response.
  #
  # @example
  #   confirmation = Payline::Confirmation.new(id_get: 34687545, trans_id: 5463466)
  #   response = confirmation.request
  #   response.valid?
  # => true
  #

  class Confirmation
    attr_accessor :id_get, :trans_id

    def initialize(options = {})
      @connection = Payline.configuration.connection
      @id_get = options[:id_get]
      @trans_id = options[:trans_id]
      @response = Response.new
    end

    def request
      response = @connection.post Payline.configuration.confirmation_uri, { api: Payline.configuration.api_token, id_get: @id_get, trans_id: @trans_id }
      @response.body = response.body
      @response.validate_confirmation
    end

  end
end
