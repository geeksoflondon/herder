class Herder
  class Model
    class Query
      attr_accessor :model, :params

      def initialize model
        self.model = model
        self.params = {}
      end

      def where *prms
        params.merge!(sanitize prms)
        self
      end

      def each &block
        query.each &block
      end

      def to_s
        query.to_s
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

      def sanitize params
        case params.class.name
        when "Hash"
          return params.stringify_keys
        when "String"
          return hashify params
        when "Array"
          if params.first.is_a?(Hash)
            return params.first.stringify_keys
          else
            return hashify(parameterize params)
          end
        end
      end

      def hashify params
        subqueries = params.split(/and/i)
        return subqueries.inject(Hash.new) do |results, subquery|
          tokens = subquery.strip.split(" ", 3)
          tokens[2].gsub!(/\A"|'/m, "")
          tokens[2].gsub!(/"|'\Z/m, "")
          append_param results, tokens
          results
        end
      end

      def parameterize params
        return params unless params.is_a?(Array)
        params[0].gsub(/ \?/, " %s") % params[1..-1]
      end

      def append_param results, tokens
        if tokens[0].starts_with? "interactions."
          comparator = COMPARATORS[tokens[1]] || tokens[1]
          results["#{tokens[0]} #{comparator}"] = tokens[2]
        else
          results[tokens[0]] = tokens[2]
        end
      end
    end
  end
end