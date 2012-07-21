class Herder
  class Interactable < Herder::Model

    COMPARATORS = {
      "=" => "=",
      "!=" => "!=",
      "~" => "~",
      "!~" => "!~",
      "is" => "=",
      "isnt" => "!=",
      "was" => "~",
      "wasnt" => "!~"
    }.freeze

    def interactions
      Interactable::Query.new(type: klass, id: id)
    end

    def klass
      @klass ||= self.class.name.split("::").last
    end

    def self.insert_token results, tokens
      if tokens[0].starts_with? "interactions."
        comparator = COMPARATORS[tokens[1]]
        results["#{tokens[0]} #{comparator}"] = tokens[2]
      else
        results[tokens[0]] = tokens[2]
      end
    end
  end
end

require_relative "interactable/query"
