require './rule'

class AndRule < Rule
  name 'AND'

  def check(plan, entries)
    ret_val = true
    parse_entries(entries).each do |rule, args|
      if not rule.check(plan, args)
        ret_val = false
        break
      end
    end
    ret_val
  end
end
Rule.add(AndRule)

class OrRule < Rule
  name 'AND'

  def check(plan, entries)
    ret_val = false
    parse_entries(entries).each do |rule, args|
      if rule.check(plan, args)
        ret_val = true
        break
      end
    end
    ret_val
  end
end
Rule.add(OrRule)

class NotRule < Rule
  name 'NOT'

  def check(plan, entry)
    rule, args = parse_entry(entry)
    not rule.check(plan, args)
  end
end
Rule.add(NotRule)

# This is ANDcourse. We do not need ORcourse because ANDcourse will change
# all of its children's plan arguments to a single course.
class SamecourseRule < Rule

  def check(plan, course, entries)
    ret_val = true
    Rule.parse_entries(entries) { |f, args|
      if not f.call(course, args)
        ret_val = false
        break
      end
    }
    ret_val
    }
    Rule.add_course_filter(same_course, "same_course")
