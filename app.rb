require 'sinatra'

get '/' do
  @students = Student.all

  erb :index
end

get '/students/:id' do
  @student = Student.find(params[:id])
  
  erb :profile
end


get '/students/:id/edit' do
  @student = Student.find(params[:id])

  erb :edit
end

post '/students/:id/edit' do
  @student = Student.find(params[:id]).first

  @attributes = params[:student]
  puts @attributes
  @student.update(@attributes)
end

class Student
  require 'sqlite3'
  attr_accessor :id, :name, :tagline, :image_url, :bio, :email, :blog, :linkedin, :twitter, :fav_apps_one, :fav_apps_two, :fav_apps_three,
                :codeschool, :github, :coderwall, :stack, :treehouse

  def initialize(args)
    @id = args[:id]
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
  end

  def update(args)
    @@db.execute("UPDATE students WHERE id =1
    SET name='nikhil'")
  end

  def self.all
    students = []
    rows = @@db.execute('SELECT * FROM students;')
    rows.each do |row|
      students << Student.new(:id => row[0], :name => row[1])
    end
    return students
  end

  def save
    DATABASE.execute('INSERT INTO students (id, name, tagline, image_url, bio, email, blog, linkedin, twitter, fav_apps_one, 
                      fav_apps_two, fav_apps_three, codeschool, github, coderwall, stack, treehouse) 
                      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);' [self.id, self.name, self.tagline, self.image_url, self.bio, self.email, self.blog, self.linkedin, self.twitter,
                      self.fav_apps_one, self.fav_apps_two, self.fav_apps_three, self.codeschool, self.github, self.coderwall,
                      self.stack, self.treehouse])
  end

  def self.find(id)
    id = id.to_i    
    data = @@db.execute('SELECT * FROM students WHERE id = (?)', [id]).first
    student = Student.new(:id => data[0], :name => data[1])
    return student
  end

  def self.create_database
    # unless File.exists?('student_database.db')
      @@db = SQLite3::Database.new "student_database.db"
      rows = @@db.execute <<-SQL
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
  # end
end
