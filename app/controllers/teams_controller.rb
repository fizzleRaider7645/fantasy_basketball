class TeamsController < ApplicationController
  get '/teams' do
    if logged_in?
      erb :'teams/index'
    else
      redirect :'/login'
    end
  end

  post '/team' do
    if logged_in?
      @team = Team.create(params)
      @team.owner_id = current_user.id
      @team.roster_spots = 0
      @team.save
      erb :'teams/show'
    else
      redirect :'/login'
    end
  end

  get '/team/new' do
    if logged_in?
      erb :'teams/new'
    else
      redirect :'/login'
    end
  end
end
