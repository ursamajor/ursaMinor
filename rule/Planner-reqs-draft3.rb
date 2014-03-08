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

$rules = {}

def get_rule(name)
	raise "rule #{name} does not exist" if not $rules.include?(name)
	$rules[name]
end

# A decorator that adds a function to the list of rules.
# A rule is a function that either matches or doesn't match a plan.
def add_rule(f, f_name, custom_name=nil)
	name = custom_name ? custom_name : f_name
	$rules[name] = f
end

# This is a special thing because most of our rules are course filters.
# We need to be able to check whether the course exists in the plan.

# A decorator that adds a course filter rule to the list of rules. This
# rule is simply whether any course in the plan matches the course filter.
def add_course_filter(f, f_name, custom_name=nil)
	name = custom_name ? custom_name : f_name # get the function's name
	course_filter_rule = Proc.new { |plan, args|
		ret_val = false
		plan.courses.each do |course|
		  if f.call(plan, course, args)
		  	ret_val = true
		  	break
		  end
		end
		ret_val
	}
	add_rule(course_filter_rule, "course_filter_rule", name)
end

# To use the course filter directly (i.e., for ANDcourse), we should
# make sure that all rules can take in a single course as well as a plan.
# We do this by making Course.courses return an iterable of courses.


## FORMATTING ##
# @add_rule
# def some_rule(plan, args): pass
# @add_course_filter
# def some_course_filter(plan, course, args): pass

def parse_rule_entry(entry)
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

def parse_rule_entries(entries)
	entries.each do |entry|
		yield parse_rule_entry(entry)
	end
end

and_proc = Proc.new { |plan, entries|
	ret_val = true
	parse_rule_entries(entries) { |f, args| 
		if not f.call(plan, args) 
			ret_val = false
			break
		end
	}
	ret_val
}
add_rule(and_proc, "AND")

or_proc = Proc.new { |plan, entries|
	ret_val = false
	parse_rule_entries(entries) { |f, args|
		if f.call(plan, args)
			ret_val = true
			break
		end
	}
	ret_val
}
add_rule(or_proc, "OR")

not_proc = Proc.new { |plan, entry|
	f, args = parse_rule_entry(entry)
	not f.call(plan, args)
}
add_rule(not_proc, "NOT")

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
same_course = Proc.new { |plan, course, entries|
	ret_val = true
	parse_rule_entries(entries) { |f, args| 
		if not f.call(course, args)
			ret_val = false
			break
		end
	}
	ret_val
}
add_course_filter(same_course, "same_course")

course_regex = Proc.new { |plan, course, regex|
	Regexp.new(regex, "i").match(course.name)
}
add_course_filter(course_regex, "course_regex")

course = Proc.new { |plan, course, name|
	course.name.lower() == name.lower()
}
add_course_filter(course, "course")

pnp = Proc.new { |plan, course, name|
	course.ispnp
}
add_course_filter(pnp, "pnp")

course_number_range = Proc.new { |plan, course, range|
	min = range[0]
	max = range.length > 1 ? range[1] : Float::INFINITY
	course.number >= min and course.number <= max
}
add_course_filter(course_number_range, "course_number_range")

def add_yaml_rule(name, entry)
	f, args = parse_rule_entry(entry)
	yaml_rule = Proc.new { |plan, dummy_args|
		raise ArgumentError.new("YAML rules should not take arguments, got #{args}") if dummy_args
		f.call(plan, args)
	}
	add_rule(yaml_rule, "yaml_rule", name)
end

def check_rule(plan, rule, args=nil)
	result = get_rule(rule).call(plan, args)
	puts "The plan #{result ? 'PASSES' : 'FAILS'} rule #{rule}."
end

