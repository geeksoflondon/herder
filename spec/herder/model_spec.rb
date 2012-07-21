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
      Herder::Model.should_receive(:find).with(:all, params: options)
      Herder::Model.where(options)
    end

    it "should accept strings"

    it "should accept strings with formats as tokens"

    it "should be chain-able"
  end

end