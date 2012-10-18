require 'sinatra'

get '/' do
  erb :index
end

get '/:name' do |n|
  @students = Student.all
  erb :profile
end


class Student
  def self.all
    { :name => "brad", :bio => "this is my bio page"}
  end
end
