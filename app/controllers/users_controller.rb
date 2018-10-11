class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect :'/collections'
    else
      erb :'users/new'
    end
  end

  get '/login' do
    if logged_in?
      redirect :'/collections'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    logout
    redirect :'/login'
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'/users/show'
  end

  post '/signup' do
  end

  post '/login' do
  end
end
