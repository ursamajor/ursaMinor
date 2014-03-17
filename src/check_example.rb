

# $ ruby check_example.rb
# The plan PASSES rule ac.
# The plan PASSES rule dumb_way_to_match_ac.
# The plan FAILS rule rcb.
# The plan PASSES rule upperdiv.
# The plan PASSES rule pnp_lowerdiv.

require './ursarule'
require 'yaml'

data = YAML.load_file('rule_test.yaml')
data['rules'].keys.each do |rule|
  Rule.add YamlRule.new rule, data['rules'][rule]
end

my_plan = Plan.new([
  Course.new('SOMETHING SOMETHING AC', 50),
  Course.new('CS.61C', 61),
  Course.new('CS.188', 188),
  Course.new('CS.170', 170),
  Course.new('GERMAN.R5A', 5),
  Course.new('MCELLB.61', 61, true)
])

Rule.get(:ac).check_print(my_plan, nil)
# puts Rule.get(:ac).source
Rule.get(:pnp).check_print(my_plan, nil)
Rule.get(:dumb_way_to_match_ac).check_print(my_plan, nil)
Rule.get(:rcb).check_print(my_plan, nil)
Rule.get(:upperdiv).check_print(my_plan, nil)
Rule.get(:pnp_lowerdiv).check_print(my_plan, nil)
