require './rule_coursefilter'

class CourseRegexRule < CourseFilter
	name 'course_regex'

	def check(plan, course, regex)
		Regexp.new(regex, "i").match(course.name)
	end

end
Rule.add(CourseRegexRule)

class CourseRule < CourseFilter
	name 'course'

	def check(plan, course, name)
		course.name.lower() == name.lower()
	end

end
Rule.add(CourseRule)

class PnpRule < CourseFilter
	name 'pnp'

	def check(plan, course, name)
		course.ispnp
	end

end
Rule.add(PnpRule)

class CourseNumberRangeRule < CourseFilter
	name 'course_number_range'

	def check(plan, course, range)
		min = range[0]
		max = range.length > 1 ? range[1] : Float::INFINITY
		course.number >= min and course.number <= max
	end

end
Rule.add(CourseNumberRangeRule)
