require './rule'

class CourseFilter < Rule
	source 'course_filter'

	def check_course(plan, args)
		raise NotImplementedError.new("<Rule '#{name}'>.check_course")
	end

	def check(plan, dummy_args)
		raise ArgumentError.new("YAML rules should not take arguments, got #{args}") if dummy_args
		rule, args = parse_entry(entry)
		rule.check(plan, args)
	end

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
		add(course_filter_rule, "course_filter_rule", name)
	end



end