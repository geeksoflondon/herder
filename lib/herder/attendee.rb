class Herder
  class Attendee < ActiveResource::Base
    self.site = Herder::Config.get("host")
    self.user = Herder::Config.get("user")
    self.password = Herder::Config.get("password")
    self.element_name = "attendee"
  end
end