require 'spec_helper'

describe 'User' do
  before do
    @user = User.create(:username => "BaublesBaloo", :email => "Baubles@hotmail.com", :password => "Woof!")
    @piece = Piece.create(:name => "Jug", :size => "1/4 Pint", :quantity => "1")

    @user.pieces << @piece

  end

  it 'can initialize a user' do
    expect(User.new).to be_instance_of(User)
  end

  it 'can have a username' do
    expect(@user.username).to eq("BaublesBaloo")
  end

  it 'has a secure password' do
   expect(@user.authenticate("yarr")).to eq(false)

   expect(@user.authenticate("Woof!")).to eq(@user)
 end

 it "can have many pieces" do
   expect(@user.pieces.count).to eq(1)
 end

end
