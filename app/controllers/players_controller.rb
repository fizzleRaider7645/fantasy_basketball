class PlayersController < ApplicationController

  get '/players' do
    if logged_in?
      erb :'players/index'
    else
      redirect :'/login'
    end
  end

  get '/players/:id' do
    if logged_in?
      erb :'players/show'
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

  get '/players/:id/edit' do
    if logged_in?
      @player = Player.find(params[:id])
      erb :'players/edit'
    else
      redirect :'/login'
    end
  end
end
