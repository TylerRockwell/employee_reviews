class Employee

  attr_reader :name, :salary
  attr_accessor :reviews
  def initialize(name, email, phone, salary)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
  end


end
