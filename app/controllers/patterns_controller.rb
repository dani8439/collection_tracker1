class PatternsController < ApplicationController

  get '/patterns' do
    @pattern = Pattern.all
    if logged_in?
      erb :'/patterns/index'
    else
      redirect :'/'
    end
  end

  get '/patterns/new' do
  end

  get '/patterns/:id' do
  end

  get '/patterns/:id/edit' do
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
  end

  delete '/patterns/:id/delete' do
  end
end
