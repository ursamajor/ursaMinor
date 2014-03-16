

class Rule
	attr_reader :name, :source
	
	source 'raw'

	@@rules = {}
	def self.get(name)
		raise "rule #{name} does not exist" if not @@rules.include?(name)
		@@rules[name]
	end
	def self.add(rule)
		@@rules[name] = rule.name
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


	def check(plan, args=nil)
		raise NotImplementedError.new("<Rule '#{name}'>.check")
	end

	def check_print(plan, args=nil)
		result = check(plan, args)
		puts "The plan #{result ? 'PASSES' : 'FAILS'} rule #{name}."
	end

end