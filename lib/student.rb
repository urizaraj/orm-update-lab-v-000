require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade, id=nil)
    self.name = name
    self.grade = grade
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = new(name, grade)
    student.save
    student
  end

  def self.new_from_db(row)
    new(*row)
  end

  def self.find_by_name(name)
    sql = <<-SQL
    SELECT *
    FROM students
    WHERE name = ?
    SQL

    row = DB[:conn].execute(sql, name).first
    new_from_db(row)
  end
end
