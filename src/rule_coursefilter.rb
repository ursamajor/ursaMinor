require './rule'

class CourseFilter < Rule
  @@source = :course_filter

  def abstract?
    self.class == CourseFilter
  end

  def check(plan, args)
    raise ArgumentError.
      new("YAML rules should not take arguments, got #{args}") if dummy_args

    ret_val = false
    plan.courses.each do |course|
      if rule.check_course(plan, course, args)
        ret_val = true
        break
      end
    end
    ret_val
  end

  def check_course(plan, course, args)
    raise NotImplementedError.new("<Rule '#{name}'>.check_course")
  end

end
