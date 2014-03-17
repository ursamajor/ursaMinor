

class Course
  attr_reader :name, :number, :pnp
  alias_method :pnp?, :pnp

  def initialize(name, number = nil, pnp = false)
    @name = name
    @number = number
    @pnp = pnp
  end

  # Returns an array with the course as the only item.
  # This is so that a course can be used as a plan for rules.
  def courses
    [self]
  end
end
