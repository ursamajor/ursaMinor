require './rule'

class YamlRule < Rule
  @@source = :yaml

  def initialize(name, entry)
    @name = name.to_sym
    @entry = entry
    @rule, @args = Rule.parse_entry @entry
  end

  def check(plan, args)
    raise ArgumentError.new "YAML rules should not take arguments, got #{args}" unless args.nil?
    @rule.check plan, @args
  end

end
