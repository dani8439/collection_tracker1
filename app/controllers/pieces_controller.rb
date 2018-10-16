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
    if params[:name] == "" || params[:size] == "" || params[:quantity] == "" || params[:pattern] == ""
      redirect :'/pieces/new'
    else
      @piece = Piece.create(name: params[:name], size: params[:size], quantity: params[:quantity], pattern: params[:pattern])
      @piece.user_id = current_user.id
      @piece.save
      flash[:message] = "Successfully created piece."
      erb :"pieces/#{@piece.id}"
    end
  end

  patch '/pieces/:id' do
    @piece = Piece.find_by_id(params[:id])
    @piece.update(params[:piece])
    @piece.save

    redirect :"pieces/#{@piece.id}"
  end

  delete '/pieces/:id/delete' do
    @piece = Piece.find_by_id(params[:id])
  end
end
