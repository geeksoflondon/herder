require_relative "interactable/query"

class Herder
  module Interactable
    def interactions
      Interactable::Query.new(type: klass, id: id)
    end

    def self.interactions
      Interactable::Query.new(type: klass)
    end

    def klass
      @klass ||= self.class.name.split("::").last.downcase
    end
  end
end