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
    if params[:name] == "" || params[:size] == ""
      redirect :'/pieces/new'
    else
      @piece = Piece.create(name: params[:name], size: params[:size])
      @piece.user_id = current_user.id
      @piece.save
      flash[:message] = "Successfully created piece."
      redirect :"/pieces/#{@piece.id}"
    end
  end

  patch '/pieces/:id' do
    @piece = Piece.find_by_id(params[:id])
    if !params[:name].empty?
      @piece.update(name: params[:name], size: params[:size])
      redirect :"/pieces/#{@piece.id}"
    else
      redirect :"/pieces/#{@piece.id}/edit"
    end
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
