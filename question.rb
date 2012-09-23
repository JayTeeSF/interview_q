# irb -r "./question.rb"
# Question.try_with(Question::GUESS_PARTIES)
# Question.try_with(Question::BETTER_GUESS_PARTIES)
# Question.try_with(Question::BEST_GUESS_PARTIES)

require_relative 'traveler.rb'
require_relative 'bridge.rb'
require_relative 'party.rb'

module Question
  extend self

  TRAVELER_1 = Traveler.new(:travel_time => 1, :name => :cheetah1)
  TRAVELER_2 = Traveler.new(:travel_time => 2, :name => :person2)
  TRAVELER_3 = Traveler.new(:travel_time => 5, :name => :turtle3)
  TRAVELER_4 = Traveler.new(:travel_time => 10, :name => :snail4)

  DEFAULT_PARTIES = [
    CROSSING_PARTY_1 = Party.new(TRAVELER_1, TRAVELER_4),
    RETURN_PARTY_1 = Party.new(TRAVELER_4),
  ]

  BEST_GUESS_PARTIES = [
    Party.new(Question::TRAVELER_1, Question::TRAVELER_2),
    Party.new(Question::TRAVELER_1),
    Party.new(Question::TRAVELER_3, Question::TRAVELER_4),
    Party.new(Question::TRAVELER_2),
    Party.new(Question::TRAVELER_1, Question::TRAVELER_2),
  ]

  BETTER_GUESS_PARTIES = [
    Party.new(Question::TRAVELER_2, Question::TRAVELER_4),
    Party.new(Question::TRAVELER_2),
    Party.new(Question::TRAVELER_1, Question::TRAVELER_3),
    Party.new(Question::TRAVELER_1),
    Party.new(Question::TRAVELER_1, Question::TRAVELER_2),
  ]

  GUESS_PARTIES = [
    Party.new(Question::TRAVELER_1, Question::TRAVELER_4),
    Party.new(Question::TRAVELER_1),
    Party.new(Question::TRAVELER_1, Question::TRAVELER_3),
    Party.new(Question::TRAVELER_1),
    Party.new(Question::TRAVELER_1, Question::TRAVELER_4),
  ]


  def try_with(parties = nil)
    parties ||= DEFAULT_PARTIES
    # FIXME: constraints are being assumed:
    # e.g. max of 1 - 2 travelers per party
    #      other constraints might be: traveler-1 will eat traveler-3, etc...
    Bridge.simulate :travelers => travelers, :in => parties
  end

  def travelers
    [ TRAVELER_1, TRAVELER_2, TRAVELER_3, TRAVELER_4 ]
  end
end
