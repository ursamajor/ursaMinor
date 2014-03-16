

class Course
	attr_reader :name, :number, :ispnp

	def initialize(name, number=nil, ispnp=false)
		@name = name
		@number = number
		@ispnp = ispnp
	end

	# Returns an array with the course as the only item.
	# This is so that a course can be used as a plan for rules.
	def courses
		[self]
	end
end
