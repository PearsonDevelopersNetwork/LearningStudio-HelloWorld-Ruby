require_relative 'lib/hello_world'

APP_ROOT = "/helloworld".freeze
OAUTH2_ASSERTION_ROOT = APP_ROOT + '/oauth2'.freeze
OAUTH1_SIGNATURE_ROOT = APP_ROOT + '/oauth1'.freeze

map "/" do
  run HelloWorld::IndexHandler
end

map OAUTH1_SIGNATURE_ROOT do
  run HelloWorld::OAuth1Handler
end

map OAUTH2_ASSERTION_ROOT do
  run HelloWorld::OAuth2Handler
end

