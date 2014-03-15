require 'yaml'
require './plan'
require './course'
require './rule'
require './rule_coursefilter'

and_proc = Proc.new { |plan, entries|
	ret_val = true
	Rule.parse_entries(entries) { |f, args| 
		if not f.call(plan, args) 
			ret_val = false
			break
		end
	}
	ret_val
}
Rule.add(and_proc, "AND")

or_proc = Proc.new { |plan, entries|
	ret_val = false
	Rule.parse_entries(entries) { |f, args|
		if f.call(plan, args)
			ret_val = true
			break
		end
	}
	ret_val
}
Rule.add(or_proc, "OR")

not_proc = Proc.new { |plan, entry|
	f, args = Rule.parse_entry(entry)
	not f.call(plan, args)
}
Rule.add(not_proc, "NOT")

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
same_course = Proc.new { |plan, course, entries|
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

course_regex = Proc.new { |plan, course, regex|
	Regexp.new(regex, "i").match(course.name)
}
Rule.add_course_filter(course_regex, "course_regex")

course = Proc.new { |plan, course, name|
	course.name.lower() == name.lower()
}
Rule.add_course_filter(course, "course")

pnp = Proc.new { |plan, course, name|
	course.ispnp
}
Rule.add_course_filter(pnp, "pnp")

course_number_range = Proc.new { |plan, course, range|
	min = range[0]
	max = range.length > 1 ? range[1] : Float::INFINITY
	course.number >= min and course.number <= max
}
Rule.add_course_filter(course_number_range, "course_number_range")

# data = YAML.load_file("Planner-reqs-draft3.yaml")
# data['rules'].keys.each do |rule|
#  	Rule.add_yaml_rule(rule, data['rules'][rule])
# end

# my_plan = Plan.new([
# 	Course.new('SOMETHING SOMETHING AC', number=50),
# 	Course.new('CS.61C', number=61),
# 	Course.new('CS.188', number=188),
# 	Course.new('CS.170', number=170),
# 	Course.new('GERMAN.R5A', number=5),
# 	Course.new('MCELLB.61', number=61, ispnp=true),
# ])

# Rule.check(my_plan, 'ac')
# Rule.check(my_plan, 'dumb_way_to_match_ac')
# Rule.check(my_plan, 'rcb')
# Rule.check(my_plan, 'upperdiv')
# Rule.check(my_plan, 'pnp_lowerdiv')
