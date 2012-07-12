require "spec_helper"

describe Herder::Config do

  describe "#initialize" do
    it "should try loading from file" do
      options = {
        "user" => "user2",
        "password" => "password2",
        "site" => "http://localhost2"

      }
      YAML.should_receive(:load_file).and_return(options)
      config = Herder::Config.new
      config.options["user"].should be == "user2"
      config.options["password"].should be == "password2"
      config.options["site"].should be == "http://localhost2"
    end

    it "should fall back to env vars" do
      ENV["HERDER_USER"] = "user1"
      ENV["HERDER_PASSWORD"] = "password1"
      ENV["HERDER_SITE"] = "http://localhost1"
      config = Herder::Config.new
      config.options["user"].should be == "user1"
      config.options["password"].should be == "password1"
      config.options["site"].should be == "http://localhost1"
      ENV["HERDER_USER"] = nil
      ENV["HERDER_PASSWORD"] = nil
      ENV["HERDER_SITE"] = nil
    end

    it "should load defaults as a last resort" do
      config = Herder::Config.new
      config.options["user"].should be == "user"
      config.options["password"].should be == "password"
      config.options["site"].should be == "http://localhost"
    end
  end

  describe ".instance" do
    it "should only ever create one instance" do
      instance = Herder::Config.instance
      instance.options = {foo: :bar}
      Herder::Config.instance.options.should be == {foo: :bar}
    end
  end

  describe ".get" do
    it "should return what's in the options" do
      Herder::Config.instance.options = {foo: :bar}
      Herder::Config.get(:foo).should be == :bar
    end
  end
end