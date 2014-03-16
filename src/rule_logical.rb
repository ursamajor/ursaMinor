require './rule'

class AndRule < Rule

	def check(plan, entries)
		ret_val = true
		Rule.parse_entries(entries) { |f, args| 
			if not f.call(plan, args) 
				ret_val = false
				break
			end
		ret_val
	end
end
Rule.add(AndRule, "AND")

class OrRule < Rule

	def check(plan, entries)
	ret_val = false
	Rule.parse_entries(entries) { |f, args|
		if f.call(plan, args)
			ret_val = true
			break
		end
	}
	ret_val
}
Rule.add(OrRule, "OR")

class NotRule < Rule

	def check(plan, entry)
		check, args = Rule.parse_entry(entry)
		not rule.check(plan, args)
	end
}
Rule.add(NotRule, "NOT")

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SamecourseRule < Rule

	def check(plan, course, entries)
	ret_val = true
	Rule.parse_entries(entries) { |f, args| 
		if not f.call(course, args)
			ret_val = false
			break
		end
	}
	ret_val
}
Rule.add_course_filter(same_course, "same_course")