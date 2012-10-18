require 'sinatra'

get '/' do
  @students = Student.all

  erb :index
end


get '/students/:id' do
  @student = Student.find(params[:id])
  
  erb :profile
end

class Student
  
  def initialize(args)
    @name = args[:name]
    @tagline = args[:tagline]
    @image_url = args[:image_url]
    @bio = args[:bio]
    @email = args[:email]
    @blog = args[:blog]
    @linkedin = args[:linkedin]
    @twitter = args[:twitter]
    @fav_apps_one = args[:fav_apps_one]
    @fav_apps_two = args[:fav_apps_two]
    @fav_apps_three = args[:fav_apps_three]
    @codeschool = args[:codeschool]
    @github = args[:github]
    @coderwall = args[:coderwall]
    @stack = args[:stack]
    @treehouse = args[:treehouse]

  def self.all
    DATABASE.execute('SELECT * from students')


    #[{:id => 1, :name => "kevin", :bio => "this is a bio" }, {:id => 2, :name => "brad", :bio => "this is brads bio"}]
  end

  def self.find(id)
    id = id.to_i
    DATABASE.execute("SELECT * FROM students WHERE id = #{id}")


    # student_list = [{:id => 1, :name => "kevin", :bio => "this is a bio" }, {:id => 2, :name => "brad", :bio => "this is brads bio"}]
    # student_list.select do |student|
    #   student[:id] == id.to_i
    end
  end

  def self.create_database
    unless File.exist?('student_database.db')

        DATABASE = SQLite3::Database.new "student_database.db"
          rows = DATABASE.execute <<-SQL
                CREATE TABLE students (
                id INTEGER PRIMARY KEY,
                name VARCHAR(255),
                tagline VARCHAR(255),
                image_url VARCHAR(255),
                bio TEXT,
                email VARCHAR(255),
                blog VARCHAR(255),
                linkedin VARCHAR(255),
                twitter VARCHAR(255),
                fav_apps_one TEXT,
                fav_apps_two TEXT,
                fav_apps_three TEXT,
                codeschool VARCHAR(255),
                github VARCHAR(255),
                coderwall VARCHAR(255),
                stack VARCHAR(255),
                treehouse VARCHAR(255)
        );
        SQL

        end
end
