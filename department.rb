class Department

  def initialize(name)
    @name = name
    @employees = []
  end

  def <<(employee)
    @employees << employee
  end
end
