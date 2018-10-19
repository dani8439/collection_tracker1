require 'pry'

class PiecesController < ApplicationController

  get '/pieces' do
    @piece = Piece.all
    @user = User.find_by(params[:id])
    if logged_in?
      erb :'/pieces/index'
    else
      redirect :'/'
    end
  end

  get '/pieces/new' do
    if logged_in?
      erb :'pieces/new'
    else
      redirect :'/login'
    end
  end

  get '/pieces/:id' do
    if logged_in?
      @piece = Piece.find_by_id(params[:id])
      erb :'pieces/show'
    else
      redirect :'/login'
    end
  end

  get '/pieces/:id/edit' do
    if logged_in?
      @piece = Piece.find_by_id(params[:id])
      erb :'/pieces/edit'
    else
      redirect :'/login'
    end
  end

  post '/pieces' do
    # binding.pry
    if params[:name] == "" || params[:size] == ""
      redirect :'/pieces/new'
    else
      @piece = Piece.create(name: params[:name], size: params[:size])
      if !params[:pattern][:name].empty?
        @piece.patterns << Pattern.find_or_create_by(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
        @piece.pattern_ids = params[:patterns]
        @piece.user_id = current_user.id
      end
      @piece.save
      flash[:message] = "Successfully create piece."
      redirect :"pieces/#{@piece.id}"
    end
  end

  patch '/pieces/:id' do
    # binding.pry
    @piece = Piece.find_by_id(params[:id])
    @piece.update(name: params[:name], size: params[:size])
    if !params[:name].empty?
      @piece.patterns << Pattern.find_or_create_by(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
      @piece.pattern_ids = params[:patterns]
      @piece.user_id = current_user.id
      @piece.save
    end
    redirect :"/pieces/#{@piece.id}"
  end


  delete '/pieces/:id/delete' do
    if logged_in?
      @piece = Piece.find_by_id(params[:id])
      if @piece && @piece.user_id == session[:user_id]
        @piece.delete
      end
      redirect :'/pieces'
    else
      redirect :'/login'
    end
  end
end
