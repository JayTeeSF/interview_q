class Bridge
  MAX_TRAVEL_TIME = 17

  def self.simulate options = {}
    travelers = options[ :travelers ] ||= []
    parties = options[ :in ] ||= []
    new(travelers).crossing(parties)
  end

  attr_reader :travelers, :traveled, :travel_time
  def initialize travelers = nil
    @travelers = travelers || []
    @traveled = []
    @travel_time = 0
  end

  def to_s
    "the bridge"
  end

  alias_method :say, :puts

  def remaining_traveler_count
    travelers.empty? ? "no" : travelers.count
  end

  def remaining_travelers
    travelers.empty? ? "..." : "#{Party.new(travelers)}"
  end

  def crossing( parties )
    say "There are #{remaining_traveler_count} travelers needing to cross #{self} in #{MAX_TRAVEL_TIME} minutes: #{remaining_travelers}"
    parties.each_with_index do |party, index|
      self.travel_time += party.max_time
      raise ArgumentError, "Too much time would elapse for #{party} to cross" if travel_time > MAX_TRAVEL_TIME
      send(method_name(index),party)
      say "#{remaining_traveler_count} travelers remain, #{MAX_TRAVEL_TIME - travel_time} minutes left: #{remaining_travelers}"
      break if done?
      ###
      #return_across(party)
      #say "#{remaining_traveler_count} travelers remain, #{MAX_TRAVEL_TIME - travel_time} minutes left: #{remaining_travelers}"
    end
    say success? ? "\nCongrats!!\n" : "\nTry again...\n"
    return success?
  end

  def success?
    done? && travel_time <= MAX_TRAVEL_TIME
  end

  def done?
    travelers.empty?
  end

  protected

  attr_writer :travelers, :traveled, :travel_time

  def return_across party
    raise ArgumentError, "unknown party member(s)" unless party.to_a.all?{|member| traveled.include?(member) }
    self.traveled = traveled - party.to_a
    self.travelers |= party.to_a
    say "#{party} returned across #{self} in #{party.max_time} minutes"
  end

  def go_across party
    raise ArgumentError, "unknown party member(s)" unless party.to_a.all?{|member| travelers.include?(member) }
    self.travelers = travelers - party.to_a
    self.traveled |= party.to_a
    say "#{party} cross #{self} in #{party.max_time} minutes"
  end

  def method_name(index)
    if 0 == (index % 2)
      :go_across
    else
      :return_across
    end
  end
end
