class Department

  def initialize(name)
    @name = name
    @employees = []
  end

  def <<(employee)
    @employees << employee
  end

  def total_salary
    @employees.reduce(0){|sum, employee| sum + employee.salary}
  end

  def give_raise(total_amount)
    getting_raise = @employees.select{|employee| employee.satisfactory == true}
    ind_amount = total_amount / getting_raise.length

    getting_raise.each {|employee| employee.salary += ind_amount}
  end
end
