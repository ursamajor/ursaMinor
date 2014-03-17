class Plan
  attr_accessor :courses

	def initialize(courses = [])
		@courses = courses
	end

  def add(course)
    @courses << course unless @courses.include? course
  end

end