require 'pry'

class PiecesController < ApplicationController

  get '/pieces' do
    redirect_if_not_logged_in
    @pieces = current_user.pieces
    erb :'/pieces/index'
  end

  get '/pieces/new' do
    redirect_if_not_logged_in
    @patterns = current_user.patterns
    erb :'pieces/new'
  end

  get '/pieces/:id' do
    redirect_if_not_logged_in
    @piece = Piece.find_by_id(params[:id])
    @wishlist = Wishlist.all
    erb :'pieces/show'
  end

  get '/pieces/:id/edit' do
    redirect_if_not_logged_in
    @patterns = current_user.patterns
    @piece = Piece.find_by_id(params[:id])
    if @piece && @piece.user == current_user
      erb :'/pieces/edit'
    else
      flash[:message] = "You only have access to your own pieces"
      redirect :'/pieces'
    end
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
    @piece = Piece.find_by_id(params[:id])
    if @piece && @piece.user == current_user
      if @piece.update(name: params[:name], size: params[:size])
        @piece.pattern_ids = params[:patterns]
        if !params[:pattern][:name].empty?
          @piece.patterns << Pattern.create(name: params[:pattern][:name], user_id: session[:user_id])
          @piece.user_id = session[:user_id]
        end
        @piece.save
        flash[:message] = "Successfully updated Piece."
        redirect :"/pieces/#{@piece.id}"
      end
    else
      flash[:message] = "You can only update your pieces."
      redirect :'/pieces'
    end
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
