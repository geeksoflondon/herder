require "spec_helper"

describe Herder::Interactable::Query do
  before :each do
     @interactions = Herder::Interactable::Query.new type: Herder::Ticket, id: 1
   end

   describe "#initialize" do
     it "should setup the default params" do
       @interactions.send(:params).should be == {:interactable_id=>1, :interactable_type=>Herder::Ticket, :order=>"created_at DESC"}
     end
   end

   describe "#each" do
     it "should yield the query" do
       result = [:a, :b]
       Herder::Interaction.should_receive(:where).and_return(result)

       @interactions.each.should be_a(Enumerator)
       @interactions.each{}.should be == result
     end
   end

   describe "#to_s" do
     it "should stringify the result" do
       result = [:a, :b]
       Herder::Interaction.should_receive(:where).and_return(result)
       @interactions.to_s.should be_a(String)
       @interactions.to_s{}.should be == result.to_s
     end
   end

   describe "#limit" do
     it "should set the limit" do
       @interactions.limit 10
       @interactions.send(:params)[:limit].should be == 10
     end
   end

   describe "#oldest" do
     it "should set the order created_at ASC" do
       @interactions.oldest
       @interactions.send(:params)[:order].should be == "created_at ASC"
     end
   end

   describe "#newest" do
     it "should set the order created_at DESC" do
       @interactions.newest
       @interactions.send(:params)[:order].should be == "created_at DESC"
     end
   end

   describe "#set" do
     it "should set the key" do
       @interactions.set(:foo)
       @interactions.send(:params)[:key].should be == :foo
     end
   end

   describe "#to" do
     it "should set the value and create a new object" do
       expected_params = {:interactable_id=>1, :interactable_type=>Herder::Ticket, :key=>:foo, :value=>:bar}
       Herder::Interaction.should_receive(:create).with(expected_params)
       @interactions.set(:foo).to(:bar)
       @interactions.send(:params)[:value].should be == :bar
     end
   end

   describe "#state" do
     before :each do
       expected_params = {:interactable_id=>1, :interactable_type=>Herder::Ticket, :order=>"created_at DESC", :limit=>1, :key=>:foo}
       interaction = Herder::Interaction.new value: "bar"
       Herder::Interaction.should_receive(:where).with(expected_params).and_return([interaction])
     end

     it "should determine the current state of a value" do
       @interactions.state(:foo).should be == "bar"
     end

     it "should also work by directly calling the key" do
       @interactions.foo.should be == "bar"
     end
   end

   describe "#state?" do
     it "should return true if the value is true" do
       expected_params = {:interactable_id=>1, :interactable_type=>Herder::Ticket, :order=>"created_at DESC", :limit=>1, :key=>:foo}
       interaction = Herder::Interaction.new value: true
       Herder::Interaction.should_receive(:where).with(expected_params).and_return([interaction])
       @interactions.state?(:foo).should be_true
     end

     it "should return true if the value is 'true'" do
       interaction = Herder::Interaction.new value: "true"
       Herder::Interaction.should_receive(:where).and_return([interaction])
       @interactions.state?(:foo).should be_true
     end

     it "should also work by directly asking it by key" do
       interaction = Herder::Interaction.new value: "true"
       Herder::Interaction.should_receive(:where).and_return([interaction])
       @interactions.foo?.should be_true
     end


     it "should return false if the value if falsy" do
       interaction = Herder::Interaction.new value: "foobar"
       Herder::Interaction.should_receive(:where).and_return([interaction])
       @interactions.foo?.should be_false
     end

     it "should return false if the value has never been set" do
       Herder::Interaction.should_receive(:where).and_return([])
       @interactions.foo?.should be_false
     end
   end

   describe "#states" do
     it "should return the results" do
       expected_params = {:interactable_id=>1, :interactable_type=>Herder::Ticket, :order=>"created_at DESC", :key=>:foo}
       Herder::Interaction.should_receive(:where).with(expected_params).and_return([:foo, :bar])
       @interactions.states(:foo).should be == [:foo, :bar]
     end

     it "should also be able to be called by key if a limit was set" do
       expected_params = {:interactable_id=>1, :interactable_type=>Herder::Ticket, :order=>"created_at DESC", :limit=>10, :key=>:foo}
       Herder::Interaction.should_receive(:where).with(expected_params).and_return([:foo, :bar])
       @interactions.limit(10).foo.should be == [:foo, :bar]
     end
   end
end