require "spec_helper"

describe Herder::Interaction do
  it "should setup right name" do
    Herder::Interaction.element_name.should be == "interaction"
  end

  it "should inherit Herder::Model" do
    Herder::Email.new.should be_a(Herder::Model)
  end

  describe "#toggle" do
    it "should remove the interaction" do
      interaction = Herder::Interaction.new key: "foo", value: true
      query = mock "Query"
      interaction.should_receive(:query).and_return(query)
      query.should_receive(:set).with("foo").and_return(query)
      query.should_receive(:to).with(false)
      interaction.toggle
    end
  end

  describe "#undo!" do
    it "should remove the interaction" do
      interaction = Herder::Interaction.new value: "foo"
      interaction.should_receive(:destroy)
      interaction.undo!
    end
  end

  describe "#to_s" do
    it "should be represented by value" do
      interaction = Herder::Interaction.new value: "foo"
      interaction.to_s.should be == "foo"
    end
  end

  describe "#==" do
    it "should compare by value" do
      interaction = Herder::Interaction.new value: "foo"
      interaction.should be == "foo"
    end
  end
end