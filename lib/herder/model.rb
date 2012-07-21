class Herder
  class Model < ReactiveResource::Base
    self.site = Herder::Config.get("site")
    self.user = Herder::Config.get("user")
    self.password = Herder::Config.get("password")

    def self.where options
      find :all, params: hashify(options)
    end

    protected

    def self.hashify options
      return options unless options.is_a?(String)
      subqueries = options.split(/and/i)
      return subqueries.inject(Hash.new) do |results, subquery|
        tokens = subquery.strip.split(" ", 3)
        value = tokens[2].gsub(/\A"|'/m, "").gsub(/"|'\Z/m, "")
        if tokens[0].starts_with? "interactions."
          results["#{tokens[0]} #{tokens[1]}"] = value
        else
          results[tokens[0]] = value
        end
        results
      end
    end
  end
end

require_relative "interactable"
require_relative "interaction"
require_relative "attendee"
require_relative "ticket"
require_relative "email"
