require 'pry'

class PiecePatternsController < ApplicationController

  get '/piecepatterns' do
    if logged_in?
      @user = User.find_by_id(params[:id])
      @piecepattern = PiecePattern.all
      erb :'/piecepatterns/index'
    else
      flash[:message] = "you must login."
      redirect :'/'
    end
  end

  get '/piecepatterns/new' do
  end

  get '/piecepatterns/:id' do
    if logged_in?
      @piecepattern = PiecePattern.find_by_id(params[:id])
      @user = User.find_by(params[:id])
      erb :'piecepatterns/show'
    else
      redirect :'/login'
    end
  end


  get '/piecepatterns/:id/edit' do
    if logged_in?
      @piecepattern = PiecePattern.find_by_id(params[:id])
      erb :'/piecepatterns/edit'
    else
      flash[:message] = "You only have access to edit your own Collection."
      redirect :'/login'
    end
  end

  post '/piecepatterns' do
    # if logged_in?
    #
  end


  patch '/piecepatterns/:id' do
    if logged_in?
      @user = User.find_by_id(params[:user_id])
      @piecepattern = PiecePattern.find_by_id(params[:id])
      @piecepattern.update(quantity: params[:quantity])
      redirect :"/piecepatterns/#{@piecepattern.id}"
    else
      redirect :'/login'
    end
  end

  delete '/piecepatterns/:id/delete' do
  end
end
