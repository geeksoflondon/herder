require "spec_helper"

describe Herder::Event do
  it "should setup right name" do
    Herder::Event.element_name.should be == "event"
  end

  it "should inherit Herder::Model" do
    Herder::Event.new.should be_a(Herder::Model)
  end

  it "should inherit Herder::Interactable" do
    Herder::Event.new.should be_a(Herder::Interactable)
  end

  it "should belong to an attendee" do
    Herder::Event.associations.map(&:attribute).should =~ [:tickets, :venue]
    Herder::Event.associations.map(&:class).should be == [ReactiveResource::Association::HasManyAssociation, ReactiveResource::Association::BelongsToAssociation]
  end
end