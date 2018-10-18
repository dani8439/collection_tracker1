require 'spec_helper'

describe 'Pattern' do
  before do
    @piece = Piece.create(:name => "Jug", :size => "1/4 Pint")
    @pattern = Pattern.create(name: "Utility", quantity: "1")

    @piece.patterns << @pattern
    @piece.pattern_ids = @pattern.id
  end

  it "can initialize a pattern" do
    expect(Pattern.new).to be_an_instance_of(Pattern)
  end

  it "can have a name" do
    expect(@pattern.name).to eq("Utility")
  end

  it "can have a quantity" do
    expect(@pattern.quantity).to eq(1)
  end

  it "can have many pieces" do
    expect(@pattern.pieces.count).to eq(1)
  end

end
