require_relative "../config/environment.rb"

class Student
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
end
