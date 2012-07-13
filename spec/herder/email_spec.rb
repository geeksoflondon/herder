require "spec_helper"

describe Herder::Email do
  it "should setup right name" do
    Herder::Email.element_name.should be == "email"
  end

  it "should inherit Herder::Model" do
    Herder::Email.new.should be_a(Herder::Model)
  end

  it "should belong to an attendee" do
    Herder::Ticket.associations.map(&:attribute).should =~ [:attendee]
    Herder::Ticket.associations.map(&:class).should be == [ReactiveResource::Association::BelongsToAssociation]
  end
end