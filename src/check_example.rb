# run in command line with 'ruby Planner-reqs-draft3.rb'

data = YAML.load_file("Planner-reqs-draft3.yaml")
data['rules'].keys.each do |rule|
 	add_yaml_rule(rule, data['rules'][rule])
end

my_plan = Plan.new([
	Course.new('SOMETHING SOMETHING AC', number=50),
	Course.new('CS.61C', number=61),
	Course.new('CS.188', number=188),
	Course.new('CS.170', number=170),
	Course.new('GERMAN.R5A', number=5),
	Course.new('MCELLB.61', number=61, ispnp=true),
])

check_rule(my_plan, 'ac')
check_rule(my_plan, 'dumb_way_to_match_ac')
check_rule(my_plan, 'rcb')
check_rule(my_plan, 'upperdiv')
check_rule(my_plan, 'pnp_lowerdiv')