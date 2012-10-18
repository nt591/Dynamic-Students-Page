require 'sinatra'
require 'student_database'

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
    # :name => "Kevin", :bio => "text"
    INSERT INTO students VALUES (?,?,?...), []
  end
  def self.all
    rows = DATABASE.execute('SELECT * FROM students;')
    return rows
  end

  def self.find(id)
    id = id.to_i    
    DATABASE.execute('SELECT * FROM students WHERE id = (?)', [id])
  end

  def self.create_database
    unless File.exists?('student_database.db')
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
end