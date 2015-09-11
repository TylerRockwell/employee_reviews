class Employee

  attr_reader :name
  attr_accessor :salary, :reviews, :satisfactory
  def initialize(name, email, phone, salary)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @satisfactory = true
  end

  def give_raise(amount)
    @salary += amount
  end
end
