class Herder
  module Interactable
    def interactions
      Interactable::Query.new(type: klass, id: id)
    end

    protected

    def klass
      @klass ||= self.class.name.split("::").last
    end
  end
end

require_relative "interactable/query"
