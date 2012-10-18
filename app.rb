require 'sinatra'

get '/' do
  erb :index
end

get '/:name' do |n|
  "this is a user profile page for #{n}"
end

run Sinatra::Application
