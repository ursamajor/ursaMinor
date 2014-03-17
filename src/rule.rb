class Rule
  attr_accessor :name, :source

  @@source = :raw
  @@rules = {}

  def initialize(name=nil)
    @name = name
    raise 'abstract' if abstract?
  end

  def abstract?
    self.class == Rule
  end

  def inspect
    if name then "Rule.get(#{name.inspect})"
    else super
    end
  end
  alias_method :to_s, :inspect

  def self.check_type(desc, obj, expected_class)
    unless obj.is_a? expected_class
      raise TypeError.new \
        "#{desc}: expected #{expected_class} but got #{obj.class} #{obj.inspect}"
    end
  end

  def self.get(name)
    name = name.downcase.to_sym if name.is_a? String
    check_type 'name', name, Symbol
    raise "rule #{name.inspect} does not exist" if not @@rules.include? name
    @@rules[name]
  end

  def self.add(rule)
    check_type 'rule', rule, Rule
    check_type 'rule.name', rule.name, Symbol
    @@rules[rule.name] = rule
  end

  def self.all
    @@rules
  end

  def self.parse_entry(entry, allow_implicit=true)
    if entry.is_a? String
      rule = entry
      args = nil
    elsif entry.include? 'rule'
      rule = entry['rule']
      args = entry.include?('args') ? entry['args'] : nil
    elsif allow_implicit and entry.length == 1
      rule = entry.keys[0]
      args = entry.values[0]
    else
      raise ArgumentError.new "invalid rule entry: #{entry}"
    end
    f = get rule
    return f, args
  end

  def self.parse_entries(entries)
    entries.map { |entry| parse_entry entry }
  end

  def check(plan, args)
    raise NotImplementedError.new "<Rule '#{name}'>.check"
  end

  def check_print(plan, args)
    result = check plan, args
    puts "The plan #{result ? 'PASSES' : 'FAILS'} rule #{name}."
  end
  
end
