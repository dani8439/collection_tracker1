require 'pry'

class WishlistsController < ApplicationController

  get '/wishlists' do
    @user = User.find_by(params[:id])
    @wishlist = Wishlist.all
    if logged_in?
      erb :'/wishlists/index'
    else
      redirect :'/'
    end
  end
end
