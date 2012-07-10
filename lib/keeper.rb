require "keeper/config"

class Keeper
  def self.config
    @config ||= Keeper::Config.new
  end
end

require "keeper/attendee"