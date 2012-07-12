class Herder
  class Config

    attr_accessor :options

    def initialize
      self.options = YAML.load_file("config/herder.yml")
    rescue
      self.options = {}
      options["site"] = ENV["HERDER_SITE"] || "http://localhost"
      options["user"] = ENV["HERDER_USER"] || "user"
      options["password"] = ENV["HERDER_PASSWORD"] || "password"
    end

    def self.get key
      self.instance.options[key]
    end

    def self.instance
      @instance ||= Herder::Config.new
    end

  end
end