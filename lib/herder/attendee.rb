class Herder
  class Attendee < Herder::Interactable
    has_many :emails
    has_many :tickets
  end
end