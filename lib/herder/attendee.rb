class Herder
  class Attendee < Herder::Model
    has_many :emails
    has_many :tickets
  end
end