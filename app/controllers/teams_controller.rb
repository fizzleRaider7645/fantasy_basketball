class TeamsController < ApplicationController
  get '/teams' do
    if logged_in?
      erb :'teams/index'
    else
      redirect :'/login'
    end
  end

  post '/teams' do
    if logged_in?
      @team = Team.create(params)
      @team.user_id = current_user.id
      @team.roster_spots = 5
      @team.save
      redirect :'/show'
    else
      redirect :'/login'
    end
  end

  get '/teams/new' do
    if logged_in?
      @players = Player.all
      erb :'teams/new'
    else
      redirect :'/login'
    end
  end

  get '/teams/show/:id' do
    if logged_in?
      @team = Team.find(params[:id])
      erb :'teams/show'
    else
      redirect :'/login'
    end
  end

  get '/teams/:id/edit' do
    if logged_in?
      @team = Team.find(params[:id])
      @players = Player.all.uniq { |player| player.name }.select { |player| player.team_id == current_user.id || player.team_id == nil }
      erb :'teams/edit'
    else
      redirect :'/login'
    end
  end

  patch '/teams/:id/edit' do
    if logged_in?
      binding.pry

    else
      redirect :'/login'
    end
  end
end
