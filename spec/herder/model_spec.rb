require "spec_helper"

describe Herder::Model do
  it "should setup the remote site" do
    Herder::Model.user.should be == "user"
    Herder::Model.password.should be == "password"
    Herder::Model.site.should be == URI("http://localhost")
  end

  it "should inherit active resource" do
    Herder::Model.new.should be_a(ActiveResource::Base)
  end

  describe "#where" do
    it "should pass the query along to find" do
      options = {foo: :bar}
      Herder::Model.should_receive(:find).with(:all, params: {"foo" => :bar})
      Herder::Model.where(options).to_s
    end

    it "should accept strings" do
      options = {"foo" => "bar"}
      Herder::Model.should_receive(:find).with(:all, params: options)
      Herder::Model.where("foo = 'bar'").to_s
    end

    it "should accept strings with formats as tokens" do
      options = {"foo" => "bar"}
      Herder::Model.should_receive(:find).with(:all, params: options)
      Herder::Model.where("foo = ?", "bar").to_s
    end

    it "should be chain-able" do
      options = {"foo" => "bar", "baz" => "qar"}
      Herder::Model.should_receive(:find).with(:all, params: options)
      Herder::Model.where("foo = ?", "bar").where("baz = ?", "qar").to_s
    end
  end
end