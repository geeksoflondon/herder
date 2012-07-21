class Herder
  class Model
    class Query
      attr_accessor :params

      def initialize params
        self.params = params
      end

      def convert
        hashify params
      end

      protected

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

      def hashify params
        return hashify(stringify(params)) if params.is_a?(Array) && !params.first.is_a?(Hash)
        params = params.first
        return params unless params.is_a?(String)

        subqueries = params.split(/and/i)
        return subqueries.inject(Hash.new) do |results, subquery|
          tokens = subquery.strip.split(" ", 3)
          tokens[2].gsub!(/\A"|'/m, "")
          tokens[2].gsub(/"|'\Z/m, "")
          insert_token results, tokens
          results
        end
      end

      def stringify params
        return params unless params.is_a?(Array)
        params[0].gsub(/ \?/, " %s") % params[1..-1]
      end

      def insert_token results, tokens
        if tokens[0].starts_with? "interactions."
          comparator = COMPARATORS[tokens[1]]
          results["#{tokens[0]} #{comparator}"] = tokens[2]
        else
          results[tokens[0]] = tokens[2]
        end
      end
    end
  end
end