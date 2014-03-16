require './rule_coursefilter'

class CourseRegexRule < CourseFilter
  set_name :course_regex

  def check(plan, course, regex)
    Regexp.new(regex, "i").match(course.name)
  end

end
CourseRegexRule.new
Rule.add(CourseRegexRule.new)

class CourseRule < CourseFilter
  set_name :course

  def check(plan, course, name)
    course.name.lower() == name.lower()
  end

end
Rule.add(CourseRule.new)

class PnpRule < CourseFilter
  set_name :pnp

  def check(plan, course, name)
    course.ispnp
  end

end
Rule.add(PnpRule.new)

class CourseNumberRangeRule < CourseFilter
  set_name :course_number_range

  def check(plan, course, range)
    min = range[0]
    max = range.length > 1 ? range[1] : Float::INFINITY
    course.number >= min and course.number <= max
  end

end
Rule.add(CourseNumberRangeRule.new)
