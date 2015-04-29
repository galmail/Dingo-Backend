PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger

PayPal::SDK::REST.set_config(
  :mode => ENV['PAYPAL_MODE'],
  :client_id => ENV['PAYPAL_CLIENTID'],
  :client_secret => ENV['PAYPAL_SECRET']
)
  
PayPal::SDK.configure(
  :mode      => ENV['PAYPAL_MODE'],
  :app_id    => ENV['PAYPAL_APP_ID'],
  :username  => ENV['PAYPAL_USERNAME'],
  :password  => ENV['PAYPAL_PASSWORD'],
  :signature => ENV['PAYPAL_SIGNATURE'],
  # OpenID Config
  :openid_client_id     => ENV['PAYPAL_CLIENTID'],
  :openid_client_secret => ENV['PAYPAL_SECRET'],
  :openid_redirect_uri  => "http://dingoapp.co.uk"  
)

