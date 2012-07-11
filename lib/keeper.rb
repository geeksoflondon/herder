require_relative "keeper/config"

class Keeper
  def self.config
    @config ||= Keeper::Config.new
  end
end

require_relative "keeper/attendee"