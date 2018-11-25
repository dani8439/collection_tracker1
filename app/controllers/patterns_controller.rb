require 'pry'

class PatternsController < ApplicationController

  get '/patterns' do
    redirect_if_not_logged_in
    @patterns = current_user.patterns
    erb :'/patterns/index'
  end

  get '/patterns/new' do
    redirect_if_not_logged_in
    @pieces = current_user.pieces
    erb :'patterns/new'
  end

  get '/patterns/:id' do
    redirect_if_not_logged_in
    @pattern = Pattern.find_by_id(params[:id])
    @user = User.find_by(params[:id])
    @wishlist = Wishlist.all
    erb :'patterns/show'
  end

  get '/patterns/:id/edit' do
    redirect_if_not_logged_in
    @pieces = current_user.pieces
    @pattern = Pattern.find_by_id(params[:id])
    if @pattern && @pattern.user_id == current_user.id
      erb :'patterns/edit'
    else
      flash[:message] = "You only have access to your own patterns."
      redirect :'/patterns'
    end
  end

  post '/patterns' do
    # binding.pry
    redirect_if_not_logged_in
    if params[:pattern][:name] == ""
      flash[:message] = "You need to fill in name to create a Pattern."
      redirect :'/patterns/new'
    else
      @pattern = Pattern.create(name: params[:pattern][:name])
      if current_user.patterns.include?(@pattern)
        flash[:message] = "Pattern already exists."
      elsif !params[:piece][:name].empty? && !params[:piece][:size].empty?
        @pattern.piece_ids = params[:pieces]
        @pattern.pieces << Piece.create(name: params[:piece][:name], size: params[:piece][:size], user_id: session[:user_id])
      else
        @pattern.piece_ids = params[:pieces]
        @pattern.user_id = session[:user_id]
      end
      @pattern.save
      flash[:message] = "Successfully created Pattern."
      redirect :"/patterns/#{@pattern.id}"
    end
  end

  patch '/patterns/:id' do
    # binding.pry
    redirect_if_not_logged_in
    @pattern = Pattern.find_by_id(params[:id])
    if @pattern && @pattern.user_id == current_user.id
      if @pattern.update(name: params[:pattern][:name], user_id: session[:user_id])
        @pattern.piece_ids = params[:pieces]
        if !params[:piece][:name].empty? && !params[:piece][:size].empty?
          @pattern.pieces << Piece.create(name: params[:piece][:name], size: params[:piece][:size], user_id: session[:user_id])
          @pattern.user_id = session[:user_id]
        end
        @pattern.save
        flash[:message] = "Successfully updated pattern."
        redirect :"patterns/#{@pattern.id}"
      end
    else
      flash[:message] = "You can only edit your patterns."
      redirect :'/patterns'
    end
  end


  delete '/patterns/:id/delete' do
    redirect_if_not_logged_in
    @pattern = Pattern.find_by_id(params[:id])
    if @pattern && @pattern.user_id == session[:user_id]
      @pattern.delete
    end
    flash[:message] = "Pattern has been deleted from your collection."
    redirect :'/pieces'
  end
end
