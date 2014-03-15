require './rule'

class YamlRule < Rule
	source 'yaml'

	def check(plan, dummy_args)
		raise ArgumentError.new("YAML rules should not take arguments, got #{args}") if dummy_args
		rule, args = parse_entry(entry)
		rule.check(plan, args)
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
		f = get(rule)
		return f, args
	end

	def self.parse_entries(entries)
		entries.each do |entry|
			yield parse_entry(entry)
		end
	end

end