require 'pry'

class PiecesController < ApplicationController

  get '/pieces' do
    if logged_in?
    @piece = Piece.all
    @user = User.find_by(params[:user_id])
      erb :'/pieces/index'
    else
      flash[:message] = "You must login."
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
      flash[:message] = "You only have access to edit your own pieces."
      redirect :'/login'
    end
  end

  post '/pieces' do
    # binding.pry
    if params[:name] == "" || params[:size] == ""
      flash[:message] = "Please do not leave any fields blank."
      redirect :'/pieces/new'
    else
      @piece = Piece.create(name: params[:name], size: params[:size])
      @pattern = params[:pattern][:name]
      if params[:pattern][:name].empty?
        # @piece.patterns = Pattern.find_or_create_by(params[:pattern][:name])
        @piece.pattern_ids = params[:patterns]
        @piece.patterns.quantity = params[:pattern][:quantity]
        @piece.user_id = current_user.id
        @piece.save
      else
        if !Pattern.all.include?(@pattern)
          @piece.patterns << Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
          @piece.pattern_ids = params[:patterns]
          @piece.user_id = current_user.id
          @piece.save
        else
          @piece.patterns.quantity = params[:pattern][:quantity]
          @piece.pattern_ids = params[:patterns]
          @piece.user_id = current_user.id
          @piece.save
        end
      end
      flash[:message] = "Successfully create piece."
      redirect :"pieces/#{@piece.id}"
    end
  end

  patch '/pieces/:id' do
    # binding.pry
    @piece = Piece.find_by_id(params[:id])
    @piece.update(name: params[:name], size: params[:size])
    @pattern = Pattern.find_by_id(params[:id])
    if !params[:name].empty?
      @piece.patterns << Pattern.find_or_create_by(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
      @piece.pattern_ids = params[:patterns]
      @piece.user_id = current_user.id
      @piece.save
    else
      @pattern.quantity = params[:pattern][:quantity]
      @piece.patterns.save
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
