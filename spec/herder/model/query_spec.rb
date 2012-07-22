require "spec_helper"

describe Herder::Model::Query do
  before :each do
    @query = Herder::Model::Query.new(Herder::Ticket)
  end

  describe "#initialize" do
    it "should assign the model and init the params" do
      @query.model.should be == Herder::Ticket
      @query.params.should be == {}
    end
  end

  describe "#where" do
    it "should append to the params" do
      @query.where("id = ?", 1)
      @query.params.should be == {"id" => "1"}
    end

    it "should be chainable" do
      @query.where("id = ?", 1).where("foo = bar")
      @query.params.should be == {"id" => "1", "foo" => "bar"}
    end

    it "should overwrite previously stated values" do
      @query.where("id = ?", 1).where("id = ?", 2)
      @query.params.should be == {"id" => "2"}
    end

    it "should parse interactions seperately" do
      @query.where("id = ?", 1).where("interactions.confirmed ~ ?", "true")
      @query.params.should be == {"id" => "1", "interactions.confirmed ~" => "true"}
    end

    it "should allow for interactions date ranges" do
      Timecop.freeze(Time.now) do
        @query.where("id = ?", 1).where("interactions.created_at > ? AND interactions.created_at < ?",  10.day.ago, 1.days.ago)
        @query.params.should be == {"id" => "1", "interactions.created_at >" => 10.days.ago.to_s, "interactions.created_at <" => 1.days.ago.to_s}
      end
    end
  end

  describe "#each" do
    it "should yield the query" do
      result = [:a, :b]
      Herder::Ticket.should_receive(:find).and_return(result)

      @query.each.should be_a(Enumerator)
      @query.each{}.should be == result
    end
  end

  describe "#to_s" do
    it "should stringify the result" do
      result = [:a, :b]
      Herder::Ticket.should_receive(:find).and_return(result)
      @query.to_s.should be_a(String)
      @query.to_s{}.should be == result.to_s
    end
  end

  describe "COMPARATORS" do
    it "should translate interaction comparators" do
      @query.where("interactions.a is 'a'").where("interactions.b isnt 'b'").where("interactions.c was 'c'").where("interactions.d wasnt 'c'")
      @query.params.should be == {"interactions.a ="=>"a", "interactions.b !="=>"b", "interactions.c ~"=>"c", "interactions.d !~"=>"c"}
    end
  end

  describe "#hashify" do
    it "should accept hashes" do
      @query.where(foo: "this is a sentence")
      @query.params.should be == {"foo" => "this is a sentence"}
    end

    it "should accept strings" do
      @query.where("foo = 'this is a sentence'")
      @query.params.should be == {"foo" => "this is a sentence"}
    end

    it "should accept strings with formats as tokens" do
      @query.where("foo = ?", "this is a sentence")
      @query.params.should be == {"foo" => "this is a sentence"}
    end

    it "should be chain-able" do
      @query.where("foo = ?", "this is a sentence1").where("bar = 'this is a sentence2'")
      @query.params.should be == {"foo" => "this is a sentence1", "bar" => "this is a sentence2"}
    end
  end
end