class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect :'/pieces'
    else
      erb :'users/new'
    end
  end

  get '/login' do
    if logged_in?
      redirect :'/pieces'
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
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect :'/signup'
    else
      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect :'/pieces'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect :'/pieces'
    else
      redirect :'/login'
    end
  end
end
