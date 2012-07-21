class Herder
  class Model < ReactiveResource::Base
    self.site = Herder::Config.get("site")
    self.user = Herder::Config.get("user")
    self.password = Herder::Config.get("password")

    def self.where *options
      pp  hashify(options)
      find :all, params: hashify(options)
    end

    def self.hashify options
      return hashify(stringify(options)) if options.is_a?(Array) && !options.first.is_a?(Hash)
      options = options.first
      return options unless options.is_a?(String)

      subqueries = options.split(/and/i)
      return subqueries.inject(Hash.new) do |results, subquery|
        tokens = subquery.strip.split(" ", 3)
        tokens[2].gsub!(/\A"|'/m, "")
        tokens[2].gsub(/"|'\Z/m, "")
        insert_token results, tokens
        results
      end
    end

    def self.stringify options
      return options unless options.is_a?(Array)
      options[0].gsub(/ \?/, " %s") % options[1..-1]
    end

    def self.insert_token results, tokens
      results[tokens[0]] = tokens[2]
    end
  end
end

require_relative "interaction"
require_relative "interactable"

require_relative "attendee"
require_relative "ticket"
require_relative "email"
