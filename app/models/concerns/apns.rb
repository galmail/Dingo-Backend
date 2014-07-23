module APNS

  APNS.host = ENV["APN_HOST"]
  # gateway.sandbox.push.apple.com is default and only for development
  # gateway.push.apple.com is only for production

  APNS.port = ENV["APN_PORT"]
  # this is also the default. Shouldn't ever have to set this, but just in case Apple goes crazy, you can.

  APNS.pem  = ENV["APN_PEM_FILE"]
  # this is the file you just created

  APNS.pass = ENV["APN_PASSWORD"]
  # Just in case your pem need a password

end