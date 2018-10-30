require 'pry'

class PatternsController < ApplicationController

  get '/patterns' do
    @user = User.find_by(params[:id])
    @pattern = @user.patterns
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
    if params[:pattern][:name] == "" || params[:pattern][:quantity] == ""
      flash[:message] = "You need to fill in all fields to create a Pattern."
      redirect :'/patterns/new'
    else
      @pattern = Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
      @user = User.find_by(params[:id])
      if !params[:piece][:name].empty?
        @pattern.piece_ids = params[:pieces]
        @piece = Piece.find_or_create_by(name: params[:piece][:name], size: params[:piece][:size])
        @pattern.pieces << @piece
        @user.pieces << @piece
        @pattern.user_id = session[:user_id]
        @piece.user_id = session[:user_id]
        @pattern.save
        @piece.save
      else
        @pattern.piece_ids = params[:pieces]
        @pattern.user_id = session[:user_id]
      end
      @pattern.save
      flash[:message] = "Successfully created pattern."
      redirect :"/patterns/#{@pattern.id}"
    end
  end

  patch '/patterns/:id' do
    @pattern = Pattern.find_by_id(params[:id])
    @pattern.update(name: params[:name], quantity: params[:quantity])

    redirect :"patterns/#{@pattern.id}"
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
