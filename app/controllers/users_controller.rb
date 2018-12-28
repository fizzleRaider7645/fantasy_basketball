class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect :'/show'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect :'/show'
    else
      redirect :'/login'
    end
  end

  get '/new' do
    if logged_in?
      redirect :'/show'
    else
      erb :'users/new'
    end
  end

  post '/new' do
    if User.exists?(:email => params[:email], :username => params[:username])
      redirect :'/login'
    else
      @user = User.create(params) unless User.exists?(:email => params[:email])
      session[:user_id] = @user.id
      redirect :'/show'
    end
  end

  get '/show' do
    if logged_in?
      @user = User.find_by(email: current_user[:email])
      erb :'users/show'
    else
      redirect :'/login'
    end
  end

  get '/show/:id' do
    if logged_in?
      @user = User.find_by(id: params[:id])
      erb :'users/show'
    else
      redirect :'/login'
    end
  end

  get '/users' do
    if logged_in?
      @users = User.all
      erb :'users/index'
    else
      redirect :'/login'
    end
  end

  get '/logout' do
    session.clear
    redirect :'/'
  end

  delete '/users/:id/delete' do
    @user = User.find(params[:id])
    if logged_in? && @user.id == current_user.id
      @user.team.players.clear unless @user.team == nil
      User.delete(@user.id)
      redirect :'/logout'
    else
      redirect :'/login'
    end
  end

end
