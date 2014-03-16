require './rule'

class AndRule < Rule
	set_name :AND

	def check(plan, entries)
		ret_val = true
		parse_entries(entries).each do |rule, args|
			unless rule.check(plan, args) 
				ret_val = false
				break
			end
		end
		ret_val
	end
end
Rule.add(AndRule.new)

class OrRule < Rule
	set_name :OR

	def check(plan, entries)
		ret_val = false
		parse_entries(entries).each do |rule, args|
			if rule.check(plan, args) 
				ret_val = true
				break
			end
		end
		ret_val
	end
end
Rule.add(OrRule.new)

class NotRule < Rule
	set_name :NOT

	def check(plan, entry)
		rule, args = parse_entry(entry)
		not rule.check(plan, args)
	end
end
Rule.add(NotRule.new)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SameCourseRule < Rule
	set_name :same_course

	def check(plan, course, entries)
		ret_val = true
		parse_entries(entries).each do |rule, args|
			unless rule.check(course, args)
				ret_val = false
				break
			end
		end
		ret_val
	end
end
Rule.add(SameCourseRule.new)
