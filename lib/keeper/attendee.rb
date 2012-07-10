class Keeper
  class Attendee < ActiveResource::Base
    self.site = Keeper.config["host"]
    self.user = Keeper.config["user"]
    self.password = Keeper.config["password"]
    self.element_name = "attendee"
  end
end