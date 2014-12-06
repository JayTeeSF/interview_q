
# irb -r "./sequence_producer.rb"
# fib = Fib.new
# fib_producer = fib.by_amount
# fib_producer.produce
#
# fac = Factorial.new
# fac_producer = fac.by_amount
# fac_producer.produce

class Sequence
  def by_tries(options={})
    ByTries.new(options.merge(Producer::CALCULATOR_KEY => @calculator))
  end

  def by_amount(options={})
    ByAmount.new(options.merge(Producer::CALCULATOR_KEY => @calculator))
  end
end

class Factorial < Sequence # B0rked!
  def initialize
    @calculator = lambda {|start, current, tries|
      puts "-> #{start}, #{current}, #{tries}"
      return_value = 1
      tries.downto(1) do |count|
        return_value *= count
      end
      try_count = tries + 1
      puts "<= [#{start}, #{return_value}, #{try_count}]"
      return [start, return_value, try_count]
    }
  end
end

class Fib < Sequence
  def initialize
    @calculator = lambda {|start, current, tries|
      previous_start = start
      start = current
      current = previous_start + current
      tries = tries + 1
      return [start, current, tries]
    }
  end
end

class Producer
  START_AMOUNT_KEY = "start_amount"
  AMOUNT_KEY = "by_amount"
  TRIES_KEY = "by_tries"
  MAX_VALUE_KEY = "max_value_key"
  DEFAULT_MAX_VALUE = 10
  CALCULATOR_KEY = "calculator_key"

  attr_reader :amount, :tries
  def initialize(options={})
    @options = options # this could be bad
    set
  end

  def reset
    set
  end

  def produce(_max_value=DEFAULT_MAX_VALUE)
    @max_value = _max_value
    each do |_start_amount, _amount, _tries|
      puts "produced: #{_amount} after #{_tries} tries"
    end
  end

  def each
    return enum_for(:each) unless block_given?

    while(@max_value >= current_value)
      result_array = @calculator.call(@start_amount, @amount, @tries)

      yield(*result_array)
      @start_amount = result_array[0]
      @amount = result_array[1]
      @tries = result_array[2]
    end
  end

  private

  def set
    @max_value = @options[MAX_VALUE_KEY] || DEFAULT_MAX_VALUE
    @start_amount = @options[START_AMOUNT_KEY] || 1
    @amount = @options[AMOUNT_KEY] || 1
    @tries = @options[TRIES_KEY] || 1
    @calculator = @options[CALCULATOR_KEY]
    fail("missing calculator") unless @calculator
  end
end

class ByAmount < Producer
  private
  def current_value
    @amount
  end
end

class ByTries < Producer
  private
  def current_value
    @tries
  end
end
