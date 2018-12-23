class PlayersController < ApplicationController

  get '/players' do
    if logged_in?
      erb :'players/index'
    else
      redirect :'/login'
    end
  end

  get '/posts/new' do
    if !session[:email]
      redirect "/login"
    else
      "A new post form"
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
