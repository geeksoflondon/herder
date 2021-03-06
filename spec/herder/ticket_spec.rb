require "spec_helper"

describe Herder::Ticket do
  it "should setup right name" do
    Herder::Ticket.element_name.should be == "ticket"
  end

  it "should inherit Herder::Model" do
    Herder::Ticket.new.should be_a(Herder::Model)
  end

  it "should inherit Herder::Interactable" do
    Herder::Ticket.new.should be_a(Herder::Interactable)
  end

  it "should belong to an attendee" do
    Herder::Ticket.associations.map(&:attribute).should =~ [:attendee, :event]
    Herder::Ticket.associations.map(&:class).should be == [ReactiveResource::Association::BelongsToAssociation, ReactiveResource::Association::BelongsToAssociation]
  end
end