require './ursarule'
require 'yaml'

data = YAML.load_file("test-rules.yaml")
data['rules'].keys.each do |rule|
	Rule.add YamlRule.new rule, data['rules'][rule]
end

my_plan = Plan.new([
  Course.new('SOMETHING SOMETHING AC', number=50, false, units=4),
  Course.new('CS.61A', number=61, false, units=4),
  Course.new('CS.61B', number=61, false, units=4),
  Course.new('CS.61C', number=61, false, units=4),
  Course.new('EL ENG.20', number=20, false, units=4),
  Course.new('EL ENG.40', number=40, false, units=4),
  Course.new('CS.188', number=188),
  Course.new('CS.170', number=170),
  Course.new('GERMAN.R5A', number=5),
  Course.new('MCELLB.61', number=61, pnp=true)
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
  Course.new('ENG.R1A', number=0, false, units=4),
  Course.new('ENG.R1B', number=0, false, units=4),
  Course.new('MATH.16A', number=0, false, units=4),
  Course.new('MATH.16B', number=0, false, units=4),
  Course.new('STATS.2', number=0, false, units=4),
  Course.new('MATH.10A', number=0, false, units=4),
  Course.new('STATS.2', number=0, false, units=4),
  Course.new('MATH.10A', number=0, false, units=4),
  Course.new('MATH.10B', number=0, false, units=4),
  Course.new('CHEM.1A', number=0, false, units=4),
  Course.new('CHEM.3A', number=0, false, units=4),
  Course.new('CHEM.1AL', number=0, false, units=4),
  Course.new('CHEM.3AL', number=0, false, units=4),
  Course.new('CHEM.1B', number=0, false, units=4),
  Course.new('CHEM.3BL', number=0, false, units=4),
  Course.new('PHYSICS.8A', number=0, false, units=4),
  Course.new('NST.11', number=0, false, units=4),
  Course.new('MCB.32', number=0, false, units=4),
  Course.new('MCB.32L', number=0, false, units=4),
  Course.new('BIO.1AL', number=0, false, units=4),
  Course.new('MCB.102', number=0, false, units=4),
  Course.new('MCB.104', number=0, false, units=4),
  Course.new('IB.141', number=0, false, units=4),
  Course.new('PMB.C112', number=0, false, units=4),
  Course.new('MCB.C112', number=0, false, units=4),
  Course.new('PH.162A', number=0, false, units=4),
  Course.new('PMB.C112', number=0, false, units=4),
  Course.new('MCB.C112L', number=0, false, units=4),
  Course.new('PH.162L', number=0, false, units=4),
  Course.new('NST.110', number=0, false, units=4),
  Course.new('NST.121', number=0, false, units=4),
  Course.new('NST.171', number=0, false, units=4),
  Course.new('NST.193', number=0, false, units=4),
  Course.new('CIVENG.114', number=0, false, units=4),
  Course.new('CIVENG.115', number=0, false, units=4),
  Course.new('ESPM.100', number=0, false, units=4),
  Course.new('ESPM.119', number=0, false, units=4),
  Course.new('ESPM.126', number=0, false, units=4),
  Course.new('ESPM.162', number=0, false, units=4),
  Course.new('ESPM.C180', number=0, false, units=4),
  Course.new('IB.117', number=0, false, units=4),
  Course.new('IB.131', number=0, false, units=4),
  Course.new('IB.152', number=0, false, units=4),
  Course.new('NST.103', number=0, false, units=4),
  Course.new('NST.C114', number=0, false, units=4),
  Course.new('ESPM.C148', number=0, false, units=4),
  Course.new('NST.C115', number=0, false, units=4),
  Course.new('NST.160', number=0, false, units=4),
  Course.new('NST.C196', number=0, false, units=4),
  Course.new('NST.199', number=0, false, units=4),
  Course.new('PH.150A', number=0, false, units=4),
  Course.new('PH.150B', number=0, false, units=4),
  Course.new('PH.170B', number=0, false, units=4),
  Course.new('UGIS.192C', number=0, false, units=4)
])

Rule.get(:molecular_toxicology_major).check_print(other_plan, nil)

other_other_plan = Plan.new([
  Course.new('UGBA.10', number=0, false, units=4),
  Course.new('ECON.1', number=0, false, units=4),
  Course.new('ECON.2', number=0, false, units=4),
  Course.new('STAT.20', number=0, false, units=4),
  Course.new('STAT.21', number=0, false, units=4),
  Course.new('STAT.25', number=0, false, units=4),
  Course.new('MATH.1A', number=0, false, units=4),
  Course.new('MATH.16A', number=0, false, units=4),
  Course.new('MATH.1B', number=0, false, units=4),
  Course.new('MATH.16B', number=0, false, units=4),
  Course.new('MATH.1B', number=0, false, units=4),
  Course.new('MATH.16B', number=0, false, units=4),
  Course.new('MATH.53', number=0, false, units=4),
  Course.new('MATH.54', number=0, false, units=4),
  Course.new('UGBA.100', number=0, false, units=4),
  Course.new('UGBA.101A', number=0, false, units=4),
  Course.new('ECON.100A', number=0, false, units=4),
  Course.new('ECON.101A', number=0, false, units=4),
  Course.new('IAS.106', number=0, false, units=4),
  Course.new('UGBA.101B', number=0, false, units=4),
  Course.new('ECON.100B', number=0, false, units=4),
  Course.new('ECON.101B', number=0, false, units=4),
  Course.new('IAS.107', number=0, false, units=4),
  Course.new('UGBA.102A', number=0, false, units=4),
  Course.new('UGBA.102B', number=0, false, units=4),
  Course.new('UGBA.103', number=0, false, units=4),
  Course.new('UGBA.104', number=0, false, units=4),
  Course.new('UGBA.104', number=0, false, units=4),
  Course.new('UGBA.105', number=0, false, units=4),
  Course.new('UGBA.106', number=0, false, units=4),
  Course.new('UGBA.107', number=0, false, units=4)
])

Rule.get(:haas_business_administration_major).check_print(other_other_plan, nil)

my_other_plan = Plan.new([
  Course.new('HIST.10', number=10, false, units=4),
  Course.new('HIST.101', number=101, false, units=4)
])

Rule.get(:series).check_print(my_other_plan, nil)