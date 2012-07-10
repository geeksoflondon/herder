class Keeper
  class Config

    def initialize
      self.options = YAML.load_file("config/keeper.yml")
    rescue
      self.options = {}
      options["host"] = ENV["KEEPER_HOST"]
      options["user"] = ENV["KEEPER_USER"]
      options["password"] = ENV["KEEPER_PASSWORD"]
    end

    def [] key
      options[key]
    end

    protected

    attr_accessor :options
  end
end