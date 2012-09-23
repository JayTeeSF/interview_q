class Party
  attr_reader :travelers
  def initialize(*travelers)
    @travelers = travelers || []
  end

  def max_time
    travelers.map(&:travel_time).max
  end

  def last_traveler
    travelers.last
  end

  def first_traveler
    travelers.first
  end

  def last_travelers
    travelers.dup - [ first_traveler ]
  end

  def first_travelers
    travelers.dup - [ last_traveler ]
  end

  def to_s
    return "" if travelers.empty?
    return first_traveler.to_s if [first_traveler] == travelers

    [ first_travelers.join(","), last_traveler ].join(" and ")
  end

  def to_a
    travelers
  end
  alias_method :to_ary, :to_a
end
