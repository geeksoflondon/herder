class Keeper
  class Attendee < ActiveResource::Base
    self.site = "http://localhost:3000" #Keeper.config["host"]
  end
end