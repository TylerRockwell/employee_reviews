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
end
