PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger

PayPal::SDK::REST.set_config(
  :mode => ENV['PAYPAL_MODE'],
  :client_id => ENV['PAYPAL_CLIENTID'],
  :client_secret => ENV['PAYPAL_SECRET'])

