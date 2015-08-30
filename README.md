[![Gem Version](https://badge.fury.io/rb/payline.rb.svg)](http://badge.fury.io/rb/payline.rb)
# Payline

Payline is an API client for handling payments with Payline.ir. You can easily integrate this gem to your ruby app - whether it's based on Rails or other frameworks - and make and verify your IRR payments.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payline.rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payline.rb

## Usage

### Configuration

You must configure the gem as below before using it, with a valid API token:
```ruby
Payline.configure |config|
  config.api_token = 'XXXXX-XXXXX-XXXXXXXX-XXXXXXXXX-XXXXXXXXXXXXXXXXXXXXX'
end
```
You can get a valid api_token by signing up on Payline.ir.
There are other options to configure if you need, see `lib/payline/configuration.rb` for more information.

### Request to make a payment

Initialize a payment request with a valid amount (must be bigger than 1000 IRR) and redirect_uri and then make the request by calling `request` on the object:

```ruby
payment = Payline::Charge.new(amount: 250000, redirect_uri: 'http://localhost:3000/payment')

# Connects to the server to get an id_get.
# Returns a Payline::Response if everything goes well or rises respective error for the situation.
# See Errors Section for more information.
response = payment.request

# If the transaction was successful, you can get the address for the generated gateway:
gateway = response.gateway

# You can always check if the response is valid or not:
response.valid?
# => true
```

### Get the Confirmation for a payment

You can request for a confirmation of a payment like below:

```ruby
confirmation = Payline::Confirmation.new(id_get: 34687545, trans_id: 5463466)

# Connects to the server to validate a transaction.
# Returns a Payline::Response if everything goes well or rises respective error for the situation.
# See Errors Section for more information.
response = confirmation.request

# You can always check if the response is valid or not:
response.valid?
# => true
```

### Client Errors

When a request fails, it raises a particular exception with a description.
There are several exceptions that may show up:

| Exception | Description |
| --------- | ----------- |
| PaylineError | Represents all Payline errors, catch this to catch all following exceptions . |
| BadAPIToken | If the provided token was wrong or no api_token was provided |
| BadAmount | If the requested amount was invalid or was not provided |
| BadRedirectURI | If redirect_uri was not provided |
| BadTransId | If provided trans_id was invalid |
| BadIdGet | If provided id_get was wrong |
| FailedTransaction |  If the transaction has failed |
| InvalidResponse | If somehow it receives a bad/invalid response |
| NotFoundError | If the requested gateway was not found |

All errors inherit from ```Payline::PaylineError```, if you wish to catch all kinds of exceptions - and you should! - , try catching ```Payline::PaylineError``` and you'll be fine!

#### Handling Errors

The following piece of code should give you an idea of how to handle errors:

```ruby
begin
  confirmation = Payline::Confirmation.new(id_get: 34687545, trans_id: 5463466)
  response = confirmation.request
rescue Payline::BadIdGet
  # Invalid id_get was supplied to Payline's API
  puts "Invalid id_get"
rescue Payline::BadTransId
  # Invalid trans_id was supplied to Payline's API
  puts "Invalid trans_id"
rescue Payline::FailedTransaction
  # User failed to pay
  puts "You've failed to pay the bill!"
rescue Payline::PaylineError => e
  # Handles all other kinds of errors
  puts "System: #{e}"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Arvinje/payline.

Always write tests and make sure they're all green and remember:
> In TDD we trust!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
