require './rule'

class YamlRule < Rule

	def check(plan, dummy_args)
		raise ArgumentError.new("YAML rules should not take arguments, got #{args}") if dummy_args
		rule, args = parse_entry(entry)
		rule.check(plan, args)
	end

end
