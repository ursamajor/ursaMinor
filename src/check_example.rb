
# $ ruby check_example.rb
# The plan PASSES rule ac.
# The plan PASSES rule dumb_way_to_match_ac.
# The plan FAILS rule rcb.
# The plan PASSES rule upperdiv.
# The plan PASSES rule pnp_lowerdiv.

require './ursarule'
require 'yaml'

data = YAML.load_file("Planner-reqs-draft3.yaml")
for rule in data['rules'].keys.each
	Rule.add YamlRule.new rule, data['rules'][rule]
end

my_plan = Plan.new([
	Course.new('SOMETHING SOMETHING AC', number=50),
	Course.new('CS.61C', number=61),
	Course.new('CS.188', number=188),
	Course.new('CS.170', number=170),
	Course.new('GERMAN.R5A', number=5),
	Course.new('MCELLB.61', number=61, pnp=true),
])

Rule.get(:ac).check_print(my_plan, nil)
Rule.get(:pnp).check_print(my_plan, nil)
Rule.get(:dumb_way_to_match_ac).check_print(my_plan, nil)
Rule.get(:rcb).check_print(my_plan, nil)
Rule.get(:upperdiv).check_print(my_plan, nil)
Rule.get(:pnp_lowerdiv).check_print(my_plan, nil)
