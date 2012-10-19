require "sinatra"
require "sinatra/reloader" if development?
require 'nokogiri'
require 'open-uri'

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

    Student.create_database

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
    @@db.execute('INSERT INTO students (id, name, tagline, image_url, bio, email, blog, linkedin, twitter, fav_apps_one, 
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
    @@db = SQLite3::Database.new "student_database.db"
    unless File.exists?('student_database.db')
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

      Student.populate_database
    end
  end
  create_database

    def self.populate_database
      index_url = 'http://students.flatironschool.com/index.html'
      index_doc = Nokogiri::HTML(open(index_url))

      profile_urls = index_doc.css('div.one_third a').map {|link| "http://students.flatironschool.com/#{link['href']}" }


      profile_urls.each_with_index do |profile_url, index|
        id = index + 1
        profile_doc = Nokogiri::HTML(open(profile_url))

        @id = id
        @name = "#{profile_doc.css('div.two_third h1').text}"
        @tagline = "#{profile_doc.css('div.two_third h2:first').text}"
        @image_url =  "image should go here"
        @bio = "#{profile_doc.css('.two_third p').text}"
        @email = "#{profile_doc.xpath("//li[@class='mail']//a/@href")}"
        @blog = "#{profile_doc.xpath("//li[@class='blog']//a/@href")}"
        @linkedin = "#{profile_doc.xpath("//li[@class='linkedin']//a/@href")}"
        @twitter = "#{profile_doc.xpath("//li[@class='twitter']//a/@href")}"
        @fav_apps_one = "#{profile_doc.css('div.two_third div.one_third:nth-of-type(1)').text}"
        @fav_apps_two   = "#{profile_doc.css('div.two_third div.one_third:nth-of-type(2)').text}"
        @fav_apps_three = "#{profile_doc.css('div.two_third div.one_third:nth-of-type(3)').text}"
        @codeschool = "#{profile_doc.xpath("//div[@class='one_fifth'][2]//a/@href")}"
        @github = "#{profile_doc.xpath("//div[@class='one_fifth'][1]//a/@href")}"
        @coderwall = "#{profile_doc.xpath("//div[@class='one_fifth'][3]//a/@href")}"
        @stack = "#{profile_doc.xpath("//div[@class='one_fifth'][4]//a/@href")}"
        @treehouse = "#{profile_doc.xpath("//div[@class='one_fifth last']//a/@href")}"

        sql = ("INSERT INTO students(id, name, tagline, image_url, bio, email, blog, linkedin, twitter, fav_apps_one, fav_apps_two, fav_apps_three, codeschool, github, coderwall, stack, treehouse) 
                  VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"[@id, @name,@tagline,@image_url,@bio,@email,@blog,@linkedin,@twitter,@fav_apps_one,
                                  @fav_apps_two,@fav_apps_three,@codeschool,@github,@coderwall,@stack,@treehouse])

        puts sql
        @@db.execute(sql)
    end
  end     
end
