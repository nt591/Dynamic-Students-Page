require 'sinatra'

get '/' do
  @students = Student.all

  erb :index
end

get '/:name' do |n|
  @student = Student.find(n)
  
  erb :profile
end

class Student
  def self.all
    :students => {:name => "kevin", :bio => "this is a bio" } 
  end

  def self.find(id)
    
  end
end