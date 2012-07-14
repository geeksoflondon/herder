class Herder
  class Ticket < Herder::Model
    include Herder::Interactable

    belongs_to :attendee
  end
end