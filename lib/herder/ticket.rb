class Herder
  class Ticket < Herder::Interactable
    belongs_to :attendee
  end
end