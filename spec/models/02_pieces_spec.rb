require 'spec_helper'

describe 'Piece' do
  before do
    @piece = Piece.create(:name => "Jug", :size => "1/4 Pint", :quantity => "1")
    @user = User.create(:username => "BaublesBaloo", :email => "Baubles@hotmail.com", :password => "Woof!")
    @pattern = Pattern.create(name: "Utility")

    @piece.patterns << @pattern
    @piece.pattern_ids = @pattern.id
    @user.pieces << @piece
  end

  it "can initialize a piece" do
    expect(Piece.new).to be_an_instance_of(Piece)
  end

  it "can have a name" do
    expect(@piece.name).to eq("Jug")
  end

  it "can have a size" do
    expect(@piece.size).to eq("1/4 Pint")
  end

  it "can have a quantity" do
    expect(@piece.quantity).to eq(1)
  end

  it "can have many patterns" do
    expect(@piece.patterns.count).to eq(1)
  end

end
