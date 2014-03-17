require './rule'

class YamlRule < Rule
  @source = :yaml

  def source
    self.class.source
  end

  def initialize(name, entry)
    @name = name.to_sym
    @entry = entry
    @rule, @args = Rule.parse_entry @entry
  end

  def check(plan, args)
    fail ArgumentError,
      "YAML rules should not take arguments, got #{args.inspect}" unless args.nil?
    @rule.check plan, @args
  end
end
