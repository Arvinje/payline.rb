module Payline
  class Response
    attr_accessor :body
    attr_reader :valid, :gateway, :id_get

    def initialize
      @valid = false
    end

    def validate_request      # Respective to Payline::Charge
      case @body
      when '-1'
        raise BadAPIToken, 'The API token is invalid'
      when '-2'
        raise BadAmount, 'The requested amount is invalid'
      when '-3'
        raise BadRedirectURI, 'Redirect URI is invalid (probably nil)'
      when '-4'
        raise NotFoundError, 'The requested gateway was not found'
      else
        raise InvalidResponse, 'Response is not valid' unless is_integer? @body   # If the response was a float
        if @body.to_i > 0
          @id_get = @body.to_i
          generate_gateway
          @valid = true
        else
          raise InvalidResponse, 'Response is not valid'
        end
      end
      self
    end

    def validate_confirmation     # Respective to Payline::Confirmation
      case @body
      when '-1'
        raise BadAPIToken, 'The API token is invalid'
      when '-2'
        raise BadTransId, 'The trans_id is invalid'
      when '-3'
        raise BadIdGet, 'The id_get is invalid'
      when '-4'
        raise FailedTransaction, 'The transaction has failed'
      when '1'
        @valid = true
      else
        raise InvalidResponse, 'Response is not valid'
      end
      self
    end

    def valid?    # To see if the request is valid or not
      @valid
    end

    private
    def generate_gateway  # To generate a gateway based on a valid id_get
      @gateway = Payline.configuration.base_gateway + @id_get.to_s
    end

    def is_integer? string
      true if Integer(string) rescue false
    end

  end
end
