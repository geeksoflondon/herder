class Herder
  class Event < Herder::Model
    include Herder::Interactable

    has_many :tickets
    belongs_to :venue
  end
end