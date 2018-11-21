require 'pry'

class PiecesController < ApplicationController

  get '/pieces' do
    redirect_if_not_logged_in
    @pieces = current_user.pieces
    erb :'/pieces/index'
  end

  get '/pieces/new' do
    redirect_if_not_logged_in
    erb :'pieces/new'
  end

  get '/pieces/:id' do
    redirect_if_not_logged_in
    @piece = Piece.find_by_id(params[:id])
    @wishlist = Wishlist.all
    erb :'pieces/show'
  end

  get '/pieces/:id/edit' do
    #  need to protect route so cannot access other uses info
    redirect_if_not_logged_in
    @piece = Piece.find_by_id(params[:id])
    erb :'/pieces/edit'
  end

  post '/pieces' do
    # binding.pry
    redirect_if_not_logged_in
    if params[:name] == "" || params[:size] == ""
      flash[:message] = "Please do not leave any fields blank."
      redirect :"/pieces/new"
    else
      @piece = current_user.pieces.build(name: params[:name], size: params[:size])
      @pattern = Pattern.find_by(name: params[:pattern][:name])
      if !params[:pattern][:name].empty?
        if current_user.patterns.include?(@pattern)
          flash[:message] = "Pattern already exists."
          redirect :"/pieces/new"
        end
        @piece.pattern_ids = params[:patterns]
        @piece.patterns << Pattern.create(name: params[:pattern][:name], user_id: session[:user_id])
        @piece.user_id = session[:user_id]
        @piece.save
      else
        @piece.pattern_ids = params[:patterns]
        @piece.user_id = session[:user_id]
      end
      @piece.save
      flash[:message] = "Successfully created piece."
      redirect :"/pieces/#{@piece.id}"
    end
  end

  patch '/pieces/:id' do
    # binding.pry
    redirect_if_not_logged_in
    @user = User.find_by(params[:user_id])
    @piece = Piece.find_by_id(params[:id])
    @piece.update(name: params[:name], size: params[:size])
    @piece.pattern_ids = params[:patterns]
    if !params[:pattern][:name].empty?
      @piece.patterns << Pattern.create(name: params[:pattern][:name], user_id: session[:user_id])
      @piece.user_id = session[:user_id]
      @piece.save
    end
    @piece.save
    flash[:message] = "Successfully updated Piece."
    redirect :"/pieces/#{@piece.id}"
  end


  delete '/pieces/:id/delete' do
    redirect_if_not_logged_in
    @piece = Piece.find_by_id(params[:id])
    if @piece && @piece.user_id == session[:user_id]
      @piece.delete
    end
    flash[:message] = "Piece has been deleted from your collection."
    redirect :'/pieces'
  end
end
