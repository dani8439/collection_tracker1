class CollectionController < ApplicationController

  get '/collections' do
    @collection = Collection.all
    @user = User.find_by(params[:user_id])
    if logged_in?
      erb :'/collections/collections'
    else
      redirect :'/login'
    end
  end

  get '/collections/:id' do
  end
end
