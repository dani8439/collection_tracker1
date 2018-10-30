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
      if params[:pattern][:name] == "" || params[:pattern][:quantity] == ""
        flash[:message] = "You need to fill in all fields to create a Pattern."
        redirect :'/patterns/new'
      else
        @pattern = Pattern.find_or_create_by(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
        @user = User.find_by(params[:id])
        if !params[:piece][:name].empty?
          @pattern.piece_ids = params[:pieces]
          @pattern.pieces << Piece.find_or_create_by(name: params[:piece][:name], size: params[:piece][:size])
          @pattern.user_id = session[:id]
          @pattern.save
        else
          @pattern.piece_ids = params[:pieces]
          @pattern.user_id = session[:user_id]
        end
        @pattern.save
        flash[:message] = "Successfully created pattern."
        redirect :"/patterns/#{@pattern.id}"
      end
    else
      redirect :'/login'
    end
  end

  patch '/patterns/:id' do
    # binding.pry
    if logged_in?
      @pattern = Pattern.find_by_id(params[:id])
      @pattern.update(name: params[:name], quantity: params[:quantity])
      @pattern.piece_ids = params[:pieces]
      @piece = Piece.find_by_id(params[:id])
      if !params[:piece][:name].empty? && !params[:piece][:size].empty?
        @pattern.pieces << Piece.find_or_create_by(name: params[:piece][:name], size: params[:piece][:size])
        @pattern.user_id = session[:user_id]
        @pattern.save
        @piece.save
      end
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
      redirect :'/pieces'
    else
      redirect :'/login'
    end
  end
end
