require 'spec_helper'

describe 'Wishlist' do
  before do
    @wishlist = Wishlist.create(:piece_name => "Jug", :piece_size => "Tiny", :pattern_name => "Blue Stars", :quantity => "1")
    @user = User.create(:username => "BaublesBaloo", :email => "Baubles@hotmail.com", :password => "Woof!")

    @user.wishlists << @wishlist
  end

  it "can initialize a Wishlist" do
    expect(Wishlist.new).to be_an_instance_of(Wishlist)
  end

  it "can have a piece name" do
    expect(@wishlist.piece_name).to eq("Jug")
  end

  it "can have a piece size" do
    expect(@wishlist.piece_size).to eq("Tiny")
  end

  it "can have a pattern name" do
    expect(@wishlist.pattern_name).to eq("Blue Stars")
  end

  it "can have a quantity" do
    expect(@wishlist.quantity).to eq(1)
  end

end
