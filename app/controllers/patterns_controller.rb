class PatternsController < ApplicationController

  get '/patterns' do
    @pattern = Pattern.all
    @user = User.find_by(params[:id])
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
      redirect :'/login'
    end
  end

  post '/patterns' do
    if params[:name] == "" || params[:quantity] == ""
      flash[:message] = "You need to fill in all fields to create a Pattern."
      redirect :'/patterns/new'
    else
      @pattern = Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
      if !params[:piece][:name].empty?
        @pattern.pieces << Piece.find_or_create_by(name: params[:piece][:name], size: params[:piece][:size])
      end
      @pattern.user_id = current_user.id
      @pattern.save
      flash[:message] = "Successfully created pattern."
      redirect :"/patterns/#{@pattern.id}"
    end
  end

  patch '/patterns/:id' do
    @pattern = Pattern.find_by_id(params[:id])
    @pattern.update(params[:pattern])
  end

  delete '/patterns/:id/delete' do
  end
end
