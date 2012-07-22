require "spec_helper"

describe Herder::Interactable do
  class MockClass < Herder::Model
    include Herder::Interactable
  end

  describe "interactions" do
    it "should provide a class a interactions object" do
      mock_class = MockClass.new
      mock_class.interactions.should be_a(Herder::Interactable::Query)
      mock_class.interactions.send(:params)[:interactable_type].should be == "MockClass"
    end
  end
end