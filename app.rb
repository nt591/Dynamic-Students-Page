require 'sinatra'
require_relative 'student_database.rb'

get '/' do
  @students = Student.all

  erb :index
end


get '/students/:id' do
  @student = Student.find(params[:id])
  
  erb :profile
end

class Student
  def self.all


    [{:id => 1, :name => "kevin", :bio => "this is a bio" }, {:id => 2, :name => "brad", :bio => "this is brads bio"}]
  end

  def self.find(id)
    student_list = [{:id => 1, :name => "kevin", :bio => "this is a bio" }, {:id => 2, :name => "brad", :bio => "this is brads bio"}]
    student_list.select do |student|
      student[:id] == id.to_i
    end
  end
end

