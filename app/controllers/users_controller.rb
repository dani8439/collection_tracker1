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
    if logged_in?
      session.destroy
      redirect :'/'
    else
      redirect :'/'
    end
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'/users/show'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:message] = "Please fill in all fields."
      redirect :'/signup'
    else
      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      @user.save
      # redirect :'/pieces'
      redirect :"users/#{@user.id}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # redirect :'/pieces'
      redirect :"users/#{@user.id}"
    else
      flash[:message] = "Something looks wrong with your info. Please try again, or signup to create an account."
      redirect :'/login'
    end
  end
end
