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
      flash[:message] = "You only have access to your Patterns."
      redirect :'/login'
    end
  end

  post '/patterns' do
    # binding.pry
    if params[:name] == "" || params[:quantity] == ""
      flash[:message] = "You need to fill in all fields to create a Pattern."
      redirect :'/patterns/new'
    else
      @pattern = Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
      # @pieces = Piece.all
      # if !params[:piece][:name].empty?
      #   @pattern.piece_ids = params[:pieces]
      #   @pieces << Piece.find_or_create_by(name: params[:piece][:name], size: params[:piece][:size])
      #   @pattern.user_id = current_user.id
      # else
      #   @pattern.piece_ids = params[:pieces]
      #   @pattern.user_id = current_user.id
      # end
      # current_user.patterns << @pattern
      @pattern.save
      flash[:message] = "Successfully created pattern."
      redirect :"/patterns/#{@pattern.id}"
    end
  end

  patch '/patterns/:id' do
    @pattern = Pattern.find_by_id(params[:id])
    @pattern.update(name: params[:name], quantity: params[:quantity])

    redirect :"patterns/#{@pattern.id}"
  end


  delete '/patterns/:id/delete' do
    if logged_in?
      @pattern = Pattern.find_by_id(params[:id])
      if @pattern && current_user.id == session[:user_id]
        @pattern.delete
      end
      redirect :'/pieces'
    else
      redirect :'/login'
    end
  end
end
