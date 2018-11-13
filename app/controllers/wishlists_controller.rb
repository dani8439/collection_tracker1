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

  get '/wishlists/new' do
    if logged_in?
      erb :'/wishlists/new'
    else
      redirect :'/'
    end
  end

  get '/wishlists/:id' do
    if logged_in?
      @wishlist = Wishlist.find_by_id(params[:id])
      @user = User.find_by(params[:id])
      erb :'/wishlists/show'
    else
      redirect :'/login'
    end
  end

  get '/wishlists/:id/edit' do
    if logged_in?
      @wishlist = Wishlist.find_by_id(params[:id])
      erb :'wishlists/edit'
    else
      flash[:message] = "You only have access to your Wishlist."
      redirect :'/login'
    end
  end

  post '/wishlists' do
    # binding.pry
    if logged_in?
      if params[:piece_name] == "" || params[:piece_size] == "" || params[:pattern_name] == "" || params[:quantity] == ""
        flash[:message] = "Please fill in all fields to add an item to your Wishlist."
        redirect :'/wishlists/new'
      else
        @wishlist = Wishlist.create(piece_name: params[:piece_name], piece_size: params[:piece_size], pattern_name: params[:pattern_name], quantity: params[:quantity])
        @wishlist.user_id = session[:user_id]
        @wishlist.save

        flash[:message] = "Successfully added piece to your Wishlist."
        redirect :"/wishlists/#{@wishlist.id}"
      end
    else
      redirect :'/login'
    end
  end

  patch '/wishlists/:id' do
    if logged_in?
      @user = User.find_by(params[:user_id])
      @wishlist = Wishlist.find_by_id(params[:id])
      @wishlist.update(piece_name: params[:piece_name], piece_size: params[:piece_size], pattern_name: params[:pattern_name], quantity: params[:quantity], user_id: session[:user_id])

      flash[:message] = "Successfully updated wishlist."
      redirect :"/wishlists/#{@wishlist.id}"
    else
      redirect :'/login'
    end
  end

  delete '/wishlists/:id/delete' do
    if logged_in?
      @wishlist = Wishlist.find_by_id(params[:id])
      if @wishlist && @wishlist.user_id == session[:user_id]
        @wishlist.delete
      end
      flash[:message] = "Item has been deleted from your wishlist."
      redirect :'/wishlists'
    else
      redirect :'/login'
    end
  end
end
