
# config.ru

require './app'


run Sinatra::Application

$stdout.sync = true
