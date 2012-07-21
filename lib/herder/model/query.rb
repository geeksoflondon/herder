class Herder
  class Model
    class Query
      attr_accessor :model, :params

      def initialize model
        self.model = model
        self.params = {}
      end

      def where *prms
        params.merge!(hashify(prms))
        self
      end

      def each
        yield query
      end

      def to_s
        query
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

      def query
        @query ||= model.find(:all, params: params)
      end

      def hashify params
        return params if params.is_a?(Hash)
        return hashify(stringify(params)) if params.is_a?(Array) && !params.first.is_a?(Hash)
        return params.first unless params.is_a?(String)

        subqueries = params.split(/and/i)
        return subqueries.inject(Hash.new) do |results, subquery|
          tokens = subquery.strip.split(" ", 3)
          tokens[2].gsub!(/\A"|'/m, "")
          tokens[2].gsub!(/"|'\Z/m, "")
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