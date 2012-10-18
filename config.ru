require 'sinatra'

get '/' do 
  erb :index
end

get '/:name' do |n|
  "This is #{n}'s profile page."
end

run Sinatra::Application

