module SetupHelpers
  def test_configs
    Payline.configure do |config|
      config.api_token = 'adxcv-zzadq-polkjsad-opp13opoz-1sdf455aadzmck1244567'
      config.charge_uri = '/payment-test/gateway-send'
      config.confirmation_uri = '/payment-test/gateway-result-second'
      config.base_gateway = 'http://payline.ir/payment-test/gateway-'
    end
  end
end
