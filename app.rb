require 'sinatra'

get '/' do
  @students = Student.all

  erb :index
end

get '/:id' do |id|
  @student = Student.find(id)
  
  erb :profile
end

class Student
  def self.all
    [{:id => 1, :name => "kevin", :bio => "this is a bio" }, {:id => 2, :name => "brad", :bio => "this is brads bio"}]
  end

  def self.find(id)
    [{:id => 1, :name => "kevin", :bio => "this is a bio" }, {:id => 2, :name => "brad", :bio => "this is brads bio"}]
  end
end