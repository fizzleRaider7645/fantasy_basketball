class PlayersController < ApplicationController

  get '/players' do
    if logged_in?
      erb :'players/index'
    else
      redirect :'/login'
    end
  end

  get '/players/new' do
    if logged_in?
      erb :'players/new'
    else
      redirect :'/login'
    end
  end

  get '/posts/:id/edit' do
    if !session[:email]
      redirect "/login"
    else
      "A edit post form"
    end
  end
end
