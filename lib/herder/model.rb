class Herder
  class Model < ActiveResource::Base
    self.site = Herder::Config.get("host")
    self.user = Herder::Config.get("user")
    self.password = Herder::Config.get("password")

    def self.where options
      find(:all, params: options)
    end
  end
end