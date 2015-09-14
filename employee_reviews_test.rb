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
      assert employee.satisfaction
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
      employee.satisfaction += 1

      development.give_raise(10000) do |employee|
        employee.satisfaction > 0
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

    def test_employees_can_be_reviewed
      employee = Employee.new( name: "Zeke" )
      review = "Zeke is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Zeke has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
      Second, when discussing new requirements with project managers, less of the information is retained by Zeke long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further."
      employee.give_review(review)

      assert_equal review, employee.reviews[-1]
    end

    def test_reviews_can_be_scanned_and_classified
      employee = Employee.new( name: "Zeke" )
      z_review = "Zeke is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Zeke has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
      Second, when discussing new requirements with project managers, less of the information is retained by Zeke long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further."
      employee2 = Employee.new( name: "Xavier" )
      x_review = "Xavier is a huge asset to SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited, and is always willing to help others despite his heavy workload.  When Xavier leaves on vacation, everyone wishes he didn't have to go
      Last year, the only concerns with Xavier performance were around ownership.  In the past twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.  Aside from some false starts with estimates on Acme, clients are happy with his work and responsiveness, which is everything that his managers could ask for."
      employee3 = Employee.new( name: "Yvonne" )
      y_review = "Thus far, there have been two concerns over Yvonne's performance, and both have been discussed with her in internal meetings.  First, in some cases, Yvonne takes longer to complete tasks than would normally be expected.  This most commonly manifests during development on existing applications, but can sometimes occur during development on new projects, often during tasks shared with Andrew.  In order to accommodate for these preferences, Yvonne has been putting more time into fewer projects, which has gone well.
      Second, while in conversation, Yvonne has a tendency to interrupt, talk over others, and increase her volume when in disagreement.  In client meetings, she also can dwell on potential issues even if the client or other attendees have clearly ruled the issue out, and can sometimes get off topic."
      employee4 = Employee.new( name: "Wanda" )
      w_review = "Wanda has been an incredibly consistent and effective developer.  Clients are always satisfied with her work, developers are impressed with her productivity, and she's more than willing to help others even when she has a substantial workload of her own.  She is a great asset to Awesome Company, and everyone enjoys working with her.  During the past year, she has largely been devoted to work with the Cement Company, and she is the perfect woman for the job.  We know that work on a single project can become monotonous, however, so over the next few months, we hope to spread some of the Cement Company work to others.  This will also allow Wanda to pair more with others and spread her effectiveness to other projects."

      employee.give_review(z_review)
      employee2.give_review(x_review)
      employee3.give_review(y_review)
      employee4.give_review(w_review)

      employee.assess_performance
      employee2.assess_performance
      employee3.assess_performance
      employee4.assess_performance

      assert employee.satisfaction < 0
      assert employee2.satisfaction > 0
      assert employee3.satisfaction < 0
      assert employee4.satisfaction > 0

    end
    def test_employees_can_be_saved
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      employee2 = Employee.new( name: "Lunk", email: "lunk@example.com", phone: "882-329-3843", salary: 150000)

      employee.save_to_file
      employee2.save_to_file
      refute File.zero?("employee_output.txt")
    end

    def test_department_can_be_saved
      employee = Employee.new( name: "Joanna", email: "jdark@example.com", phone: "515-888-4821", salary: 80000)
      employee2 = Employee.new( name: "Lunk", email: "lunk@example.com", phone: "882-329-3843", salary: 150000)
      development = Department.new("Development")
      development << employee
      development << employee2

      development.save_to_file
      refute File.zero?("department_output.txt")
    end

end
