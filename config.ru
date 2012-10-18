
# config.ru

require './app'

Student.create_database
run Sinatra::Application

$stdout.sync = true
