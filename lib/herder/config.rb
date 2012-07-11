class Herder
  class Config

    def initialize
      self.options = YAML.load_file("config/herder.yml")
    rescue
      self.options = {}
      options["host"] = ENV["HERDER_HOST"]
      options["user"] = ENV["HERDER_USER"]
      options["password"] = ENV["HERDER_PASSWORD"]
    end

    def [] key
      options[key]
    end

    def self.get key
      self.instance[key]
    end

    def self.instance
      @instance ||= Herder::Config.new
    end

    protected

    attr_accessor :options
  end
end