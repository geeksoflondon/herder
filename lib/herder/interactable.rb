require_relative "interactable/query"

class Herder
  module Interactable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def interactions
        Interactable::Query.new(type: klass)
      end

      def klass
        @klass ||= self.class.name.split("::").last
      end
    end

    def interactions
      Interactable::Query.new(type: klass, id: id)
    end

    def klass
      @klass ||= self.class.name.split("::").last
    end
  end
end