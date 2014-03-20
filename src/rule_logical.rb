require './rule'

class AndRule < Rule
  def check(plan, entries)
    Rule.parse_entries(entries).each do |rule, args|
      return false unless rule.check plan, args
    end
    true
  end
end
Rule.add(AndRule.new :and)

class OrRule < Rule
  def check(plan, entries)
    Rule.parse_entries(entries).each do |rule, args|
      return true if rule.check plan, args
    end
    false
  end
end
Rule.add(OrRule.new :or)

class NotRule < Rule
  def check(plan, entry)
    rule, args = Rule.parse_entry entry
    !rule.check plan, args
  end
end
Rule.add(NotRule.new :not)

class UnitsRule < Rule
  def check(plan, entry)
    total = 0
    numunits = entry[0]['numunits']
    rule = entry[1]
    rule, args = Rule.parse_entry rule
    plan.courses.each { |course| total += course.units if rule.check course, args }
    total >= numunits
  end
end
Rule.add(UnitsRule.new :units)

class CoursesRule < Rule
  def check(plan, entry)
    total = 0
    numcourses = entry[0]['numcourses']
    rule = entry[1]
    rule, args = Rule.parse_entry rule
    plan.courses.each { |course| total += 1 if rule.check course, args }
    total >= numcourses
  end
end
Rule.add(CoursesRule.new :courses)

class SeriesRule < Rule
  def check(plan, entry)
    rule = entry[0]
    rule, args = Rule.parse_entry rule
    plan.courses.each do |course| 
      courses = Plan.new
      department = course.name.match(/^([^.]+)/)[0]
      plan.courses.each { |course| courses.add course if course.name.match(/^([^.]+)/)[0] == department }
      return true if rule.check courses, args
    end
    false
  end
end
Rule.add(SeriesRule.new :series)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SameCourseRule < CourseFilter
  def check_course(plan, course, entries)
    Rule.parse_entries(entries).each do |rule, args|
      return false unless rule.check course, args
    end
    true
  end
end
Rule.add(SameCourseRule.new :same_course)
