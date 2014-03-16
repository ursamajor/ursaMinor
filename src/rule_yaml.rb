require './rule'

class YamlRule < Rule
  @@source = :yaml
  attr_reader :name

  def initialize name, entry
    @name = name
    @entry = entry
  end

  def check(plan, args)
    raise ArgumentError.new("YAML rules should not take arguments, got #{args}") if args
    rule, args = parse_entry(@entry)
    rule.check(plan, args)
  end

end
