

class Rule
  attr_accessor :name, :source

  @@source = :raw

  def initialize
    super
    raise 'abstract' if abstract?
  end

  def abstract?
    self.class == Rule
  end

  def self.set_name name
    @@name = name
  end

  def name
    @name or @@name
  end

  @@rules = {}
  def self.get(name)
    raise TypeError.new "name must be string" if not name.is_a? String
    raise "rule #{name} does not exist" if not @@rules.include? name
    @@rules[name]
  end
  def self.add(rule)
    raise TypeError.new "rule of wrong type" unless rule.is_a? Rule
    puts "#{rule.name}\n"
    puts "#{rule.name.class}\n"
    puts
    STDOUT.flush
    raise TypeError.new "name must be symbol" unless rule.name.is_a? Symbol
    @@rules[name] = rule.name
  end

  def self.parse_entry(entry)
    if entry.is_a?(String)
      rule = entry
      args = nil
    elsif entry.include?(:rule)
      rule = entry[:rule]
      args = entry.include?(:args) ? entry[:args] : nil
    elsif entry.length == 1
      rule = entry.keys[0]
      args = entry.values[0]
    else
      raise ArgumentError.new("invalid rule entry: #{entry}")
    end
    f = get(rule)
    return f, args
  end

  def self.parse_entries(entries)
    entries.each do |entry|
      yield parse_entry(entry)
    end
  end


  def check(plan, args)
    raise NotImplementedError.new("<Rule '#{name}'>.check")
  end

  def check_print(plan, args)
    result = check(plan, args)
    puts "The plan #{result ? 'PASSES' : 'FAILS'} rule #{name}."
  end

end
