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
    getting_raise = []
    @employees.each  do |employee|
      getting_raise << employee if yield(employee)
    end
    ind_amount = total_amount / getting_raise.length
    getting_raise.each {|employee| employee.salary += ind_amount}
  end

  def save_to_file
    output = File.open("./department_output.txt", "a")
    output << "#{@name} #{@employees}\n"
    output.close
  end
end
