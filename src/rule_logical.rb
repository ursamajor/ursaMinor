require './rule'

class AndRule < Rule
  def check(plan, entries)
    Rule.parse_entries(entries).each do |rule, args|
      return false unless rule.check(plan, args)
    end
    true
  end
end
Rule.add(AndRule.new :and)

class OrRule < Rule
  def check(plan, entries)
    Rule.parse_entries(entries).each do |rule, args|
      return true if rule.check(plan, args)
    end
    false
  end
end
Rule.add(OrRule.new :or)

class NotRule < Rule
  def check(plan, entry)
    rule, args = parse_entry(entry)
    !rule.check(plan, args)
  end
end
Rule.add(NotRule.new :not)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SameCourseRule < CourseFilter
  def check_course(plan, course, entries)
    Rule.parse_entries(entries).each do |rule, args|
      return false unless rule.check(course, args)
    end
    true
  end
end
Rule.add(SameCourseRule.new :same_course)
