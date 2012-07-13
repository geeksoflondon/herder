class Herder
  class Model < ReactiveResource::Base
    self.site = Herder::Config.get("site")
    self.user = Herder::Config.get("user")
    self.password = Herder::Config.get("password")

    def self.where options
      find(:all, params: options)
    end
  end
end