class Herder
  class Attendee < Herder::Model
    include Herder::Interactable

    has_many :emails
    has_many :tickets
  end
end