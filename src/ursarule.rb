# TRANSLATED BUT COULD USE IMPROVEMENT
# TO DO
# .__name__
# decorators (AND, OR, NOT)/(same_course, course_regex, course, pnp, course_number_regex)
# will move rules to module/class and decorate
# general cleaning up

# a simple framework for plan and courses that illustrates how rules work
require 'yaml'

class Plan
	attr_accessor :courses

	def initialize(courses)
		@courses = courses
	end
end

class Course
	attr_accessor :name, :number, :ispnp

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

class Rule

	@@rules = {}

	def self.get_rule(name)
		raise "rule #{name} does not exist" if not @@rules.include?(name)
		@@rules[name]
	end

	# A decorator that adds a function to the list of rules.
	# A rule is a function that either matches or doesn't match a plan.
	def self.add_rule(f, f_name, custom_name=nil)
		name = custom_name ? custom_name : f_name
		@@rules[name] = f
	end

	# This is a special thing because most of our rules are course filters.
	# We need to be able to check whether the course exists in the plan.
	# A decorator that adds a course filter rule to the list of rules. This
	# rule is simply whether any course in the plan matches the course filter.
	def self.add_course_filter(f, f_name, custom_name=nil)
		name = custom_name ? custom_name : f_name # get the function's name
		course_filter_rule = Proc.new do |plan, args|
			ret_val = false
			plan.courses.each do |course|
			  if f.call(plan, course, args)
			  	ret_val = true
			  	break
			  end
			end
			ret_val
		end
		add_rule(course_filter_rule, "course_filter_rule", name)
	end

	def self.add_yaml_rule(name, entry)
		f, args = parse_entry(entry)
		yaml_rule = Proc.new { |plan, dummy_args|
			raise ArgumentError.new("YAML rules should not take arguments, got #{args}") if dummy_args
			f.call(plan, args)
		}
		add_rule(yaml_rule, 'yaml', name)
	end

	def self.parse_entry(entry)
		if entry.instance_of?(String)
			rule = entry
			args = nil
		elsif entry.include?('rule')
			rule = entry['rule']
			args = entry.include?('args') ? entry['args'] : nil
		elsif entry.length == 1
			rule = entry.keys[0]
			args = entry.values[0]
		else
			raise ArgumentError.new("invalid rule entry: #{entry}")
		end
		f = get_rule(rule)
		return f, args
	end

	def self.parse_entries(entries)
		entries.each do |entry|
			yield parse_entry(entry)
		end
	end

	def self.check(plan, rule, args=nil)
		result = get_rule(rule).call(plan, args)
		puts "The plan #{result ? 'PASSES' : 'FAILS'} rule #{rule}."
	end

end

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
Rule.add_rule(and_proc, "AND")

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
Rule.add_rule(or_proc, "OR")

not_proc = Proc.new { |plan, entry|
	f, args = Rule.parse_entry(entry)
	not f.call(plan, args)
}
Rule.add_rule(not_proc, "NOT")

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

data = YAML.load_file("Planner-reqs-draft3.yaml")
data['rules'].keys.each do |rule|
 	Rule.add_yaml_rule(rule, data['rules'][rule])
end

my_plan = Plan.new([
	Course.new('SOMETHING SOMETHING AC', number=50),
	Course.new('CS.61C', number=61),
	Course.new('CS.188', number=188),
	Course.new('CS.170', number=170),
	Course.new('GERMAN.R5A', number=5),
	Course.new('MCELLB.61', number=61, ispnp=true),
])

Rule.check(my_plan, 'ac')
Rule.check(my_plan, 'dumb_way_to_match_ac')
Rule.check(my_plan, 'rcb')
Rule.check(my_plan, 'upperdiv')
Rule.check(my_plan, 'pnp_lowerdiv')
