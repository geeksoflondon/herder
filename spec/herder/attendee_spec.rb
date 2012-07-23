require "spec_helper"

describe Herder::Attendee do
  it "should setup right name" do
    Herder::Attendee.element_name.should be == "attendee"
  end

  it "should inherit Herder::Model" do
    Herder::Attendee.new.should be_a(Herder::Model)
  end

  it "should inherit Herder::Interactable" do
    Herder::Attendee.new.should be_a(Herder::Interactable)
  end

  it "should have many tickets and emails" do
    Herder::Attendee.associations.map(&:attribute).should =~ [:tickets, :emails]
    Herder::Attendee.associations.map(&:class).uniq.should be == [ReactiveResource::Association::HasManyAssociation]
  end
end