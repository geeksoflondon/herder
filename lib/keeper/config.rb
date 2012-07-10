class Keeper
  class Config

    def initialize
      self.options = YAML.load_file(Rails.root + "config/keeper.yml")
    rescue
      self.options = ENV["keeper_host"]
    end

    def [] key
      options[key]
    end

    protected

    attr_accessor :options
  end
end