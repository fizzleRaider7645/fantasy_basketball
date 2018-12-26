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
      #team name check
      if params[:team_name] != ""
        @team = current_user.team
        @team.update(name: params[:team_name])
      end
      #end of team name check

      #custom player check
      if params[:custom_player_name] != ""
        @player = Player.create(name: params[:custom_player_name])
        current_user.team.players << @player
      end
      #end of custom player check

      #check for players to add from checkbox
      if params.keys.include?("player_ids")
        params[:player_ids].each do |id|
          @player = Player.find(id)
          @player.team_id = current_user.team.id
          @player.save

          #check below for diff between incoming params and current player ids
          #and delete those players not in incoming params
          current_ids = current_user.team.players.map { |player| player.id }
          incoming_ids = params[:player_ids].map(&:to_i)
          if current_ids != incoming_ids
            hold = incoming_ids + current_ids
            players_to_delete = hold - (incoming_ids & current_ids)
            players_to_delete.each do |id|
              @player = Player.find(id)
              @player.team_id = nil
              @player.save
            end
          end
        end
      else
        current_user.team.players.clear
      end
      #end of checkbox check
    end
    redirect :'/show'
  end
end
