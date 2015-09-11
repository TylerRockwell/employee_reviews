class Employee

  attr_reader :name, :salary
  attr_accessor :reviews, :satisfactory
  def initialize(name, email, phone, salary)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @satisfactory = true
  end


end
