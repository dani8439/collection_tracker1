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
    if logged_in?
      @user = User.find_by_id(params[:id])
      erb :'/piecepatterns/new'
    else
      redirect :'/login'
    end
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
    # binding.pry
    if logged_in?
      if params[:piecepattern][:quantity] == "" || params[:piecepattern][:piece][:name] == "" || params[:piecepattern][:piece][:size] == ""
        flash[:message] = "Please fill in all fields to create a piece."
        redirect :'/piecepatterns/new'
      else
        @piecepattern = PiecePattern.create(quantity: params[:piecepattern][:quantity])
        @piecepattern.pattern = Pattern.find_or_create_by(name: params[:piecepattern][:pattern][:name])
        @piecepattern.piece = Piece.find_or_create_by(name: params[:piecepattern][:piece][:name], size: params[:piecepattern][:piece][:size])
        @piecepattern.piece.user_id = session[:user_id]
        @piecepattern.save

        flash[:message] = "Successfully create piece."
        redirect :"/piecepatterns/#{@piecepattern.id}"
      end
    end
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
    if logged_in?
      @piecepattern = PiecePattern.find_by_id(params[:id])
      if @piecepattern && @piecepattern.piece.user_id == session[:user_id]
        @piecepattern.delete
      end
      redirect :'/piecepatterns'
    else
      redirect :'/login'
    end
  end
end
