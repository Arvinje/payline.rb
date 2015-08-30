$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'payline'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include SetupHelpers
end
