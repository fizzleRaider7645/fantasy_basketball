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
    @player = Player.find(params[:id])
    if logged_in? && !@player.scraped? && current_user.team.id == @player.team_id
      erb :'players/edit'
    else
      redirect :'/login'
    end
  end

  patch '/players/:id/edit' do
    @player = Player.find(params[:id])
    if logged_in? && !@player.scraped? && current_user.team.id == @player.team_id
      @player.name = params[:player_name]
      @player.save
      redirect :'/show'
    else
      redirect :'/login'
    end
  end

  delete '/players/:id/delete' do
    @player = Player.find(params[:id])
    if logged_in? && @player.team_id == current_user.team.id && !@player.scraped?
      Player.delete(@player.id)
      current_user.team.roster_spots += 1
      current_user.team.save
      redirect :'/show'
    else
      redirect :'/login'
    end
  end
end
