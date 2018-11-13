require 'pry'

class PatternsController < ApplicationController

  get '/patterns' do
    @user = User.find_by(params[:id])
    # @pattern = @user.patterns
    @pattern = Pattern.all
    if logged_in?
      erb :'/patterns/index'
    else
      redirect :'/'
    end
  end

  get '/patterns/new' do
    if logged_in?
      erb :'patterns/new'
    else
      redirect :'/login'
    end
  end

  get '/patterns/:id' do
    if logged_in?
      @pattern = Pattern.find_by_id(params[:id])
      @user = User.find_by(params[:id])
      erb :'patterns/show'
    else
      redirect :'/login'
    end
  end


  get '/patterns/:id/edit' do
    if logged_in?
      @pattern = Pattern.find_by_id(params[:id])
      erb :'patterns/edit'
    else
      flash[:message] = "You only have access to your Patterns."
      redirect :'/login'
    end
  end

  post '/patterns' do
    # binding.pry
    if logged_in?
      if params[:pattern][:name] == ""
        flash[:message] = "You need to fill in name to create a Pattern."
        redirect :'/patterns/new'
      else
        @pattern = Pattern.create(name: params[:pattern][:name])
        @user = User.find_by(params[:id])
        if @user.patterns.include?(@pattern)
          flash[:message] = "Pattern already exists."
        elsif !params[:piece][:name].empty? && !params[:piece][:size].empty?
          @pattern.piece_ids = params[:pieces]
          @pattern.pieces << Piece.create(name: params[:piece][:name], size: params[:piece][:size], user_id: session[:user_id])
          @pattern.save
        else
          @pattern.piece_ids = params[:pieces]
          @pattern.user_id = session[:user_id]
        end
        @pattern.save
        flash[:message] = "Successfully created Pattern."
        redirect :"/patterns/#{@pattern.id}"
      end
    else
      redirect :'/login'
    end
  end

  patch '/patterns/:id' do
    # binding.pry
    if logged_in?
      @user = User.find_by(params[:user_id])
      @pattern = Pattern.find_by_id(params[:id])
      @pattern.update(name: params[:pattern][:name])
      @pattern.piece_ids = params[:pieces]
      if !params[:piece][:name].empty? && !params[:piece][:size].empty?
        @pattern.pieces << Piece.create(name: params[:piece][:name], size: params[:piece][:size], user_id: session[:user_id])
        @pattern.user_id = session[:user_id]
        @pattern.save
      end
      @pattern.save
      flash[:message] = "Sucessfully updated pattern."
      redirect :"patterns/#{@pattern.id}"
    else
      redirect :'/login'
    end
  end


  delete '/patterns/:id/delete' do
    if logged_in?
      @pattern = Pattern.find_by_id(params[:id])
      if @pattern && @pattern.user_id == session[:user_id]
        @pattern.delete
      end
      flash[:message] = "Pattern has been deleted from your collection."
      redirect :'/pieces'
    else
      redirect :'/login'
    end
  end
end
