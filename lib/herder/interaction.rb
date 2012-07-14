class Herder
  class Interaction < Herder::Model
    def toggle
      val = value != "true"
      query.set(key).to(val)
    end

    def undo!
      destroy
    end

    private

    def query
      @query ||= Interactable::Query.new(type: interactable_type, id: interactable_id)
    end
  end
end