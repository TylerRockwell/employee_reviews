class Employee

  attr_reader :name
  attr_accessor :salary, :reviews, :satisfaction
  def initialize(name: "", email: "", phone: "", salary: 0)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @satisfaction = 0
  end

  def give_raise(amount: 0)
    @salary += amount
  end

  def give_review(review)
    @reviews << review
  end

  def assess_performance
    good_terms = [/positive/i, /good/i, /\b(en)?courag(e[sd]?|ing)\b/i, /ease/i, /improvement/i, /quick(ly)?/i, /incredibl[ey]/i, /\bimpress[edving]?{2,3}/i]
    bad_terms = [/\broom\bfor\bimprovement/i, /\boccur(ed)?\b/i, /not/i, /\bnegative\b/i, /less/i, /\bun[a-z]?{4,9}\b/i, /\b((inter)|e|(dis))?rupt[ivnge]{0,3}\b/i]
    good_terms = Regexp.union(good_terms)
    bad_terms = Regexp.union(bad_terms)
    total_good_terms = []
    total_bad_terms = []

    total_good_terms = @reviews[-1].scan(good_terms)
    total_bad_terms = @reviews[-1].scan(bad_terms)

    @satisfaction = total_good_terms.length - total_bad_terms.length
  end

  def save_to_file
    output = File.open("./employee_output.txt", "a")
    output << "#{@name},#{@email},#{@phone},#{@salary},#{@reviews},#{@satisfaction}\n"

    output.close
  end

  def open(file_name)
    input = File.open("./#{file_name}", "r")
    fields = input.readline.split(",")
    @name = fields[0]
    @email = fields[1]
    @phone = fields[2]
    @salary = fields[3].to_i
    @reviews = fields[4]
    @satisfaction = fields[5].to_i
  end
end
