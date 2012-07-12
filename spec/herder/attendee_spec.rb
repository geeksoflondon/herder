require "spec_helper"

describe Herder::Attendee do
  it "should setup right name" do
    Herder::Attendee.element_name.should be == "attendee"
  end

  it "should inherit Herder::Model" do
    Herder::Attendee.new.should be_a(Herder::Model)
  end
end