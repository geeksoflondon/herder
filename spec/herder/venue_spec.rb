require "spec_helper"

describe Herder::Venue do
  it "should setup right name" do
    Herder::Venue.element_name.should be == "venue"
  end

  it "should inherit Herder::Model" do
    Herder::Venue.new.should be_a(Herder::Model)
  end

  it "should have many events" do
    Herder::Venue.associations.map(&:attribute).should =~ [:events]
    Herder::Venue.associations.map(&:class).should be == [ReactiveResource::Association::HasManyAssociation]
  end
end