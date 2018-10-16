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
  end

  get '/pieces/:id/edit' do
  end

  post '/pieces' do
  end

  patch '/pieces/:id' do
  end

  delete '/pieces/:id/delete' do
  end
end
