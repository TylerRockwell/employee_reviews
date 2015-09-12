require 'minitest/autorun'
require 'minitest/pride'
require './employee_reviews'
require 'byebug'
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
    assert Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 85000)
    assert_raises(ArgumentError) do
      Employee.new(1,2,3,4,5)
    end
    assert_raises(ArgumentError) do
      Employee.new(1,2,3)
    end
  end

  def test_add_employee_to_department
    assert Department.new("Development") << Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 85000)
  end

  def test_get_employee_name
    employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 85000)
    assert_equal "Joanna", employee.name
  end

  def test_get_employee_salary
    employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 85000)
    assert_equal 85000, employee.salary
  end

  def test_get_department_salary
    employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
    employee2 = Employee.new(name: "Lunk", email: "lunk@example.com", phone: "882-329-3843", salary: 150000)
    development = Department.new("Development")
    development << employee
    development << employee2
    assert_equal 230000, development.total_salary
  end

    def test_employees_can_be_reviewed
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      assert employee.reviews << "This employee started off great. Not as impressed with her recent performance."
    end

    def test_employees_should_have_performance_metric
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      assert employee.satisfactory
    end

    def test_employees_can_get_raises
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      employee.give_raise(amount: 5000)
      assert_equal 85000, employee.salary
    end

    def test_whole_departments_can_get_raises
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      employee2 = Employee.new( name: "Lunk", email: "lunk@example.com", phone: "882-329-3843", salary: 150000)
      employee3 = Employee.new( name: "Sanic", email: "sanic@example.com", phone: "333-444-5555", salary: 20000)
      development = Department.new("Development")
      development << employee
      development << employee2
      development.give_raise(30000) do |employee|
        true
      end
      assert_equal 95000, employee.salary
      assert_equal 165000, employee2.salary
      assert_equal 20000, employee3.salary
    end

    def test_only_satisfactory_employees_get_raises
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      employee2 = Employee.new( name: "Lunk", email: "lunk@example.com", phone: "882-329-3843", salary: 150000)
      development = Department.new("Development")
      development << employee
      development << employee2
      employee2.satisfactory = false

      development.give_raise(10000) do |employee|
        employee.satisfactory == true
      end
      assert_equal 90000, employee.salary
      assert_equal 150000, employee2.salary
    end

    def test_set_criteria_for_employee_raises
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      employee2 = Employee.new( name: "Lunk", email: "lunk@example.com", phone: "882-329-3843", salary: 150000)
      development = Department.new("Development")
      development << employee
      development << employee2
      development.give_raise(20000) do |employee|
        employee.salary < 100000
      end
      assert_equal 100000, employee.salary
      assert_equal 150000, employee2.salary
    end
end
