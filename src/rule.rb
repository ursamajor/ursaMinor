

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

	def check(plan, args=nil)
		raise NotImplementedError.new("<Rule '#{name}'>.check")
	end

	def check_print(plan, args=nil)
		result = check(plan, args)
		puts "The plan #{result ? 'PASSES' : 'FAILS'} rule #{name}."
	end

end