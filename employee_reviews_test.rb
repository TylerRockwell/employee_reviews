require 'minitest/autorun'
require 'minitest/pride'
require './employee_reviews'

class EmployeeReviewsTest < Minitest::Test

  def test_create_new_department
    assert Department.new("Development")
    assert_raises(ArgumentError) do
      Department.new()
    end
    assert_raises(ArgumentError) do
      Department.new(1,2)
    end
  end

  def test_create_new_employee
    assert Employee.new("Joanna", "jdark@example.com", "515-888-4821", 85000)
    assert_raises (ArgumentError) do
      Employee.new
    end
    assert_raises(ArgumentError) do
      Employee.new(1,2,3,4,5)
    end
    assert_raises(ArgumentError) do
      Employee.new(1,2,3)
    end
  end

  def test_add_employee_to_department
    assert Department.new("Development") << Employee.new("Joanna", "jdark@example.com", "515-888-4821", 85000)
  end

  def test_get_employee_name
    employee = Employee.new("Joanna", "jdark@example.com", "515-888-4821", 85000)
    assert_equal "Joanna", employee.name
  end

  def test_get_employee_salary
    employee = Employee.new("Joanna", "jdark@example.com", "515-888-4821", 85000)
    assert_equal 85000, employee.salary
  end
end
