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
    @pattern = Pattern.find_by_id(params[:id])
    erb :'patterns/edit'
  end

  post '/patterns' do
    if params[:name] == ""
      redirect :'/patterns/new'
    else
      @pattern = Pattern.create(name: params[:name])
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
