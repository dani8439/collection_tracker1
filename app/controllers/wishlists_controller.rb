require 'pry'

class WishlistsController < ApplicationController

  get '/wishlists' do
    redirect_if_not_logged_in
    @wishlist = current_user.wishlists
    erb :'/wishlists/index'
  end

  get '/wishlists/new' do
    redirect_if_not_logged_in
    erb :'/wishlists/new'
  end

  get '/wishlists/:id' do
    redirect_if_not_logged_in
    @wishlist = Wishlist.find_by_id(params[:id])
    @user = User.find_by(params[:id])
    erb :'/wishlists/show'
  end

  get '/wishlists/:id/edit' do
    redirect_if_not_logged_in
    @wishlist = Wishlist.find_by_id(params[:id])
    if @wishlist && @wishlist.user == current_user
      erb :'wishlists/edit'
    else
      flash[:message] = "You only have access to your own Wishlist."
      redirect :'/wishlists'
    end
  end

  post '/wishlists' do
    # binding.pry
    redirect_if_not_logged_in
    if params[:piece_name] == "" || params[:piece_size] == "" || params[:pattern_name] == "" || params[:quantity] == ""
      flash[:message] = "Please fill in all fields to add an item to your Wishlist."
      redirect :'/wishlists/new'
    else
      @wishlist = current_user.wishlists.build(piece_name: params[:piece_name], piece_size: params[:piece_size], pattern_name: params[:pattern_name], quantity: params[:quantity])
      @wishlist.save

      flash[:message] = "Successfully added piece to your Wishlist."
      redirect :"/wishlists/#{@wishlist.id}"
    end
  end

  patch '/wishlists/:id' do
    redirect_if_not_logged_in
    @user = User.find_by(params[:user_id])
    @wishlist = Wishlist.find_by_id(params[:id])
    if @wishlist && @wishlist.user == current_user
      @wishlist.update(piece_name: params[:piece_name], piece_size: params[:piece_size], pattern_name: params[:pattern_name], quantity: params[:quantity], user_id: session[:user_id])

      flash[:message] = "Successfully updated item on your wishlist."
      redirect :"/wishlists/#{@wishlist.id}"
    else
      flash[:message] = "You can only edit items on your wishlist."
      redirect :'/wishlists'
    end
  end


  delete '/wishlists/:id/delete' do
    redirect_if_not_logged_in
    @wishlist = Wishlist.find_by_id(params[:id])
    if @wishlist && @wishlist.user_id == session[:user_id]
      @wishlist.delete
    end
    flash[:message] = "Item has been deleted from your wishlist."
    redirect :'/wishlists'
  end
end
