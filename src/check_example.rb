require './ursarule'
require 'yaml'

data = YAML.load_file("test-rules.yaml")
data['rules'].keys.each do |rule|
	Rule.add YamlRule.new rule, data['rules'][rule]
end

my_plan = Plan.new([
  Course.new('SOMETHING SOMETHING AC', 50, false, 4),
  Course.new('CS.61A', 61, false, 4),
  Course.new('CS.61B', 61, false, 4),
  Course.new('CS.61C', 61, false, 4),
  Course.new('EL ENG.20', 20, false, 4),
  Course.new('EL ENG.40', 40, false, 4),
  Course.new('CS.188', 188),
  Course.new('CS.170', 170),
  Course.new('GERMAN.R5A', 5),
  Course.new('MCELLB.61', 61, pnp=true)
])

Rule.get(:ac).check_print(my_plan, nil)
Rule.get(:pnp).check_print(my_plan, nil)
Rule.get(:dumb_way_to_match_ac).check_print(my_plan, nil)
Rule.get(:rcb).check_print(my_plan, nil)
Rule.get(:upperdiv).check_print(my_plan, nil)
Rule.get(:pnp_lowerdiv).check_print(my_plan, nil)
Rule.get(:lowerdiv_units).check_print(my_plan, nil)
Rule.get(:four_units_ac).check_print(my_plan, nil)
Rule.get(:four_cs_courses).check_print(my_plan, nil)

other_plan = Plan.new([
  Course.new('ENG.R1A', 0, false, 4),
  Course.new('ENG.R1B', 0, false, 4),
  Course.new('MATH.16A', 0, false, 4),
  Course.new('MATH.16B', 0, false, 4),
  Course.new('STATS.2', 0, false, 4),
  Course.new('MATH.10A', 0, false, 4),
  Course.new('STATS.2', 0, false, 4),
  Course.new('MATH.10A', 0, false, 4),
  Course.new('MATH.10B', 0, false, 4),
  Course.new('CHEM.1A', 0, false, 4),
  Course.new('CHEM.3A', 0, false, 4),
  Course.new('CHEM.1AL', 0, false, 4),
  Course.new('CHEM.3AL', 0, false, 4),
  Course.new('CHEM.1B', 0, false, 4),
  Course.new('CHEM.3BL', 0, false, 4),
  Course.new('PHYSICS.8A', 0, false, 4),
  Course.new('NST.11', 0, false, 4),
  Course.new('MCB.32', 0, false, 4),
  Course.new('MCB.32L', 0, false, 4),
  Course.new('BIO.1AL', 0, false, 4),
  Course.new('MCB.102', 0, false, 4),
  Course.new('MCB.104', 0, false, 4),
  Course.new('IB.141', 0, false, 4),
  Course.new('PMB.C112', 0, false, 4),
  Course.new('MCB.C112', 0, false, 4),
  Course.new('PH.162A', 0, false, 4),
  Course.new('PMB.C112', 0, false, 4),
  Course.new('MCB.C112L', 0, false, 4),
  Course.new('PH.162L', 0, false, 4),
  Course.new('NST.110', 0, false, 4),
  Course.new('NST.121', 0, false, 4),
  Course.new('NST.171', 0, false, 4),
  Course.new('NST.193', 0, false, 4),
  Course.new('CIVENG.114', 0, false, 4),
  Course.new('CIVENG.115', 0, false, 4),
  Course.new('ESPM.100', 0, false, 4),
  Course.new('ESPM.119', 0, false, 4),
  Course.new('ESPM.126', 0, false, 4),
  Course.new('ESPM.162', 0, false, 4),
  Course.new('ESPM.C180', 0, false, 4),
  Course.new('IB.117', 0, false, 4),
  Course.new('IB.131', 0, false, 4),
  Course.new('IB.152', 0, false, 4),
  Course.new('NST.103', 0, false, 4),
  Course.new('NST.C114', 0, false, 4),
  Course.new('ESPM.C148', 0, false, 4),
  Course.new('NST.C115', 0, false, 4),
  Course.new('NST.160', 0, false, 4),
  Course.new('NST.C196', 0, false, 4),
  Course.new('NST.199', 0, false, 4),
  Course.new('PH.150A', 0, false, 4),
  Course.new('PH.150B', 0, false, 4),
  Course.new('PH.170B', 0, false, 4),
  Course.new('UGIS.192C', 0, false, 4)
])

Rule.get(:molecular_toxicology_major).check_print(other_plan, nil)

other_other_plan = Plan.new([
  Course.new('UGBA.10', 0, false, 4),
  Course.new('ECON.1', 0, false, 4),
  Course.new('ECON.2', 0, false, 4),
  Course.new('STAT.20', 0, false, 4),
  Course.new('STAT.21', 0, false, 4),
  Course.new('STAT.25', 0, false, 4),
  Course.new('MATH.1A', 0, false, 4),
  Course.new('MATH.16A', 0, false, 4),
  Course.new('MATH.1B', 0, false, 4),
  Course.new('MATH.16B', 0, false, 4),
  Course.new('MATH.1B', 0, false, 4),
  Course.new('MATH.16B', 0, false, 4),
  Course.new('MATH.53', 0, false, 4),
  Course.new('MATH.54', 0, false, 4),
  Course.new('UGBA.100', 0, false, 4),
  Course.new('UGBA.101A', 0, false, 4),
  Course.new('ECON.100A', 0, false, 4),
  Course.new('ECON.101A', 0, false, 4),
  Course.new('IAS.106', 0, false, 4),
  Course.new('UGBA.101B', 0, false, 4),
  Course.new('ECON.100B', 0, false, 4),
  Course.new('ECON.101B', 0, false, 4),
  Course.new('IAS.107', 0, false, 4),
  Course.new('UGBA.102A', 0, false, 4),
  Course.new('UGBA.102B', 0, false, 4),
  Course.new('UGBA.103', 0, false, 4),
  Course.new('UGBA.104', 0, false, 4),
  Course.new('UGBA.104', 0, false, 4),
  Course.new('UGBA.105', 0, false, 4),
  Course.new('UGBA.106', 0, false, 4),
  Course.new('UGBA.107', 0, false, 4)
])

Rule.get(:haas_business_administration_major).check_print(other_other_plan, nil)

my_other_plan = Plan.new([
  Course.new('HIST.10', 10, false, 4),
  Course.new('HIST.101', 101, false, 4)
])

Rule.get(:series).check_print(my_other_plan, nil)
