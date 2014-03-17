require './rule'

class CourseFilter < Rule
  @@source = :course_filter

  def abstract?
    self.class == CourseFilter
  end

  def check(plan, args)
    for course in plan.courses.each
      return true if check_course(plan, course, args)
    end
    false
  end

  def check_course(plan, course, args)
    raise NotImplementedError.new "<Rule '#{name}'>.check_course"
  end

end
