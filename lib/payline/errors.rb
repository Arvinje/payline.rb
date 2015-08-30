module Payline
  # All Payline errors, catch this to catch all following exceptions
  class PaylineError < StandardError; end

  # If the provided token was wrong or no api_token was provided
  class BadAPIToken < PaylineError; end

  # If the requested amount was invalid or was not provided
  class BadAmount < PaylineError; end

  # If redirect_uri was not provided
  class BadRedirectURI < PaylineError; end

  # If provided trans_id was invalid
  class BadTransId < PaylineError; end

  # If provided id_get was wrong
  class BadIdGet < PaylineError; end

  # If the transaction has failed
  class FailedTransaction < PaylineError; end

  # If somehow it receives a bad/invalid response
  class InvalidResponse < PaylineError; end

  # If the requested gateway was not found
  class NotFoundError < PaylineError; end

end
