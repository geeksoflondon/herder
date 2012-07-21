class Herder
  class Interactable < Herder::Model
    def interactions
      Interactable::Query.new(type: klass, id: id)
    end

    def klass
      @klass ||= self.class.name.split("::").last
    end
  end
end

require_relative "interactable/query"
