require 'sinatra'

get '/' do
  @students = Student.all

  erb :index
end

get '/:id' do |n|
  @student = Student.find(n)
  
  erb :profile
end

class Student
  def self.all
    [{:id => 1, :name => "kevin", :bio => "this is a bio" } , {:id => 2, :name => "nikhil", :bio => "nikhil's bio"}, {:id => 3, :name => "brad", :bio => "brad's bio"}]
  end

  def self.find(id)
    students_list = [{:id => 1, :name => "kevin", :bio => "this is a bio" } , {:id => 2, :name => "nikhil", :bio => "nikhil's bio"}, {:id => 3, :name => "brad", :bio => "brad's bio"}]
    students_list.each_with_index do |student, i|
      #fill in logic later
    end
  end
end

