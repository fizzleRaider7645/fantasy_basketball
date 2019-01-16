class UsersController < ApplicationController

  get '/users/login' do
    if logged_in?
      redirect :'/users/:id'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'users/show'
    else
      redirect :'/users/login'
    end
  end

  get '/users/new' do
    if logged_in?
      redirect :'/users/:id'
    else
      erb :'users/new'
    end
  end

  post '/new' do
    if User.exists?(:email => params[:email]) || User.exists?(:username => params[:username])
      redirect :'users/login'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      erb :'users/show'
    end
  end

  get '/users/logout' do
    session.clear
    redirect :'/'
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by(id: params[:id])
      erb :'users/show'
    else
      redirect :'/users/login'
    end
  end

  get '/users' do
    if logged_in?
      @users = User.all
      erb :'users/index'
    else
      redirect :'/users/login'
    end
  end

  delete '/users/:id' do
    @user = User.find(params[:id])
    if logged_in? && @user.id == current_user.id
      @user.team.players.clear unless @user.team == nil
      Team.delete(@user.team.id)
      User.delete(@user.id)
      redirect :'/users/logout'
    else
      redirect :'/users/login'
    end
  end

end
