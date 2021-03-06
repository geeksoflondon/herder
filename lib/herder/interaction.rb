class Herder
  class Interaction < Herder::Model
    def toggle
      val = !["true", true].include?(value)
      query.set(key).to(val)
    end

    def undo!
      destroy
    end

    def to_s
      value
    end

    def ==(other)
      value == other
    end

    private

    def query
      @query ||= Interactable::Query.new(type: interactable_type, id: interactable_id)
    end
  end
end