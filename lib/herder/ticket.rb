class Herder
  class Ticket < Herder::Model
    include Herder::Interactable

    belongs_to :attendee
    belongs_to :event
  end
end