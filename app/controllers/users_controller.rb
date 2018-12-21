class UsersController < ApplicationController

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    erb :'users/show'
  end

  get '/new' do
    erb :'users/new'
  end

  post '/new' do
    if User.exists?(:email => params[:email]) || User.exists?(:username => params[:username])
      redirect :'/login'
    else
      @user = User.create(params) unless User.exists?(:email => params[:email])
      session[:user_id] = @user.id
      redirect :'users/show'
    end
  end

end
