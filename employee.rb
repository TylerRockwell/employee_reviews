class Employee

  attr_reader :name
  attr_accessor :salary, :reviews, :satisfactory
  def initialize(name: "", email: "", phone: "", salary: 0)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @satisfactory = true
  end

  def give_raise(amount: 0)
    @salary += amount
  end

  def give_review(review)
    @reviews << review
  end

  def assess_performance
    # @satisfactory = false unless @reviews[-1].scan(/Zeke/) == []
    # @satisfactory = true unless @reviews[-1].scan(/Xavier/) == []
    good_terms = [/positive/i, /good/i, /\b(en)?courag(e[sd]?|ing)\b/i, /ease/i, /improvement/i, /quick(ly)?/i, /incredibl[ey]/i, /\bimpress[edving]?{2,3}/i]
    bad_terms = [/\broom\bfor\bimprovement/i, /not/i, /less/i, /\bun[a-z]?{4,9}\b/i, /\b((inter)|e|(dis))?rupt[ivnge]{0,3}\b/i]
    good_terms = Regexp.union(good_terms)
    bad_terms = Regexp.union(bad_terms)
    total_good_terms = []
    total_bad_terms = []

    total_good_terms = @reviews[-1].scan(good_terms)
    total_bad_terms = @reviews[-1].scan(bad_terms)

    total_good_terms.length > total_bad_terms.length ? (@satisfactory = true) : (@satisfactory = false)
  end
end
