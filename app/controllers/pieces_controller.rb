require 'pry'

class PiecesController < ApplicationController

  get '/pieces' do
    if logged_in?
    @user = User.find_by_id(params[:id])
    @piece = Piece.all
      erb :'/pieces/index'
    else
      flash[:message] = "You must login."
      redirect :'/'
    end
  end

  get '/pieces/new' do
    if logged_in?
      @user = User.find_by(params[:user_id])
      erb :'pieces/new'
    else
      redirect :'/login'
    end
  end

  get '/pieces/:id' do
    if logged_in?
      @piece = Piece.find_by_id(params[:id])
      erb :'pieces/show'
    else
      redirect :'/login'
    end
  end

  get '/pieces/:id/edit' do
    if logged_in?
      @piece = Piece.find_by_id(params[:id])
      erb :'/pieces/edit'
    else
      flash[:message] = "You only have access to edit your own Pieces."
      redirect :'/login'
    end
  end

  post '/pieces' do
    if logged_in?
      if params[:name] == "" || params[:size] == ""
        flash[:message] = "Please do not leave any fields blank."
        redirect :"/pieces/new"
      else
        @piece = current_user.pieces.build(name: params[:name], size: params[:size])
        if !params[:pattern][:name].empty?
          @piece.pattern_ids = params[:patterns]
          @piece.patterns << Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
          @piece.user_id = session[:user_id]
        else
          @piece.pattern_ids = params[:patterns]
          @piece.user_id = session[:user_id]
        end
        @piece.save
        flash[:message] = "Successfully created piece."
        redirect :"/pieces/#{@piece.id}"
      end
    else
      redirect :'/login'
    end
  end

  patch '/pieces/:id' do
    binding.pry
    if logged_in?
      @user = User.find_by(params[:user_id])
      @piece = Piece.find_by_id(params[:id])
      @piece.update(name: params[:name], size: params[:size])
      # @piece.pattern_ids = params[:patterns]
      if !params[:pattern][:name].empty?
        @piece.patterns << Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
        @piece.user_id = session[:user_id]
        @piece.save
      end
      # params[:patterns].each do |pattern|
      # .deep_stringify_key ??
      # http://billpatrianakos.me/blog/2013/09/29/rails-tricky-error-no-implicit-conversion-from-symbol-to-integer/
      # http://patshaughnessy.net/2014/6/16/a-rule-of-thumb-for-strong-parameters
      @piece.save
      redirect :"/pieces/#{@piece.id}"
    else
      redirect :'/login'
    end
  end
      # an array of hashes
      # params[:patterns].each do |k, v|
        # if !v.empty? # returns nil class
        #   @piece.patterns << Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
        #   @piece.save
        # end

        #.each_value doesn't work, doesn't recognize because it's an array.

        # if v.is_a? String
        #   puts "#{k} => #{v}."
        # end
      # end



# {:name => "Cup & Saucer", :size => "Small", :patterns => [pattern_id, {:quantity => "1"}, pattern_id, {:quantity => "1"}, pattern_id, {:quantity => "2"}, pattern_id, {:quantity => ""}]}



        # params[:patterns].each.with_index(1) do |params, index|
        #   if !params[:patterns][index][:quantity].empty?
        #     # @pattern = Pattern.update(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
        #     @piece.pattern_ids = params[:patterns]
        #     @piece.save
        #   end
        # end
      # end


  # patch '/pieces/:id' do
  #   binding.pry
  #   if logged_in?
  #     @user = User.find_by(params[:user_id])
  #     @piece = Piece.find_by_id(params[:id])
  #     @piece.update(name: params[:name], size: params[:size])
  #     # @piece.pattern_ids = params[:patterns] throws error now that added quantity back in.
  #     if !params[:patterns].empty?
  #       # params[:patterns][][:quantity] -- how to iterate through index without getting error of implicit conversion??
  #       params[:patterns].each.with_index(1) do |params, i|
  #       if !params[:patterns][i][:quantity].empty?
  #         @pattern = Pattern.update(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
  #         @piece.pattern_ids = params[:patterns]
  #         @piece.save
  #       end
  #     end
  #     if !params[:pattern][:name].empty?
  #       @piece.patterns << Pattern.create(name: params[:pattern][:name], quantity: params[:pattern][:quantity])
  #       @piece.user_id = session[:user_id]
  #       @piece.save
  #     end
  #     @piece.save
  #     redirect :"/pieces/#{@piece.id}"
  #   else
  #     redirect :'/login'
  #   end
  # end


  delete '/pieces/:id/delete' do
    if logged_in?
      @piece = Piece.find_by_id(params[:id])
      if @piece && @piece.user_id == session[:user_id]
        @piece.delete
      end
      redirect :'/pieces'
    else
      redirect :'/login'
    end
  end
end
