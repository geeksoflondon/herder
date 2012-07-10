class Keeper
  class Model < ActiveResource::Base
    self.site = Keeper.config["host"]
    self.user = Keeper.config["user"]
    self.password = Keeper.config["password"]
  end
end
