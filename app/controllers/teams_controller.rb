class TeamsController < ApplicationController
  get '/teams' do
    if logged_in?
      erb :'teams/index'
    else
      redirect :'/users/login'
    end
  end

  post '/teams' do
    if logged_in?
      @team = Team.create(params)
      @team.user_id = current_user.id
      @team.roster_spots = 5
      @team.save
      redirect :'/users/id'
    else
      redirect :'/users/login'
    end
  end

  get '/teams/new' do
    if logged_in?
      @players = Player.all
      erb :'teams/new'
    else
      redirect :'/users/login'
    end
  end

  get '/teams/:id' do
    if logged_in?
      @team = Team.find(params[:id])
      erb :'teams/show'
    else
      redirect :'/users/login'
    end
  end

  get '/teams/:id/edit' do
    @team = Team.find(params[:id])
    if logged_in? && @team.user_id == current_user.id
      @players = Player.all.uniq { |player| player.name }.select { |player| player.team_id == current_user.team.id || player.team_id == nil }
      erb :'teams/edit'
    else
      redirect :'/users/login'
    end
  end


  patch '/teams/:id' do
    if logged_in?
      #team name edit check
      if params[:team_name] != ""
        @team = current_user.team
        @team.update(name: params[:team_name])
      end
      #end of team name edit check

      #custom player check
      if params[:custom_player_name] != ""
        @custom_player = Player.create(name: params[:custom_player_name])

        #in case of a custom player being created
        #and no params[:player_ids] / clear all previously checked players
        #and add custom player
        if params[:player_ids].nil?
          current_user.team.players.clear
          current_user.team.players << @custom_player
        end

        # current_user.team.players << @custom_player unless params[:player_ids] || current_user.team.at_max?

        #reset and adjust the team roster_spots count
        current_user.team.roster_spots = 5
        current_user.team.roster_spots -= current_user.team.players.count
        current_user.team.save
      end
      #end of custom player check

#**************CHECKBOX LOGIC START********************************************

      #When no players are checked and no custom player / remove all players from team
      if params[:player_ids] == nil && params[:custom_player_name] == ""
        current_user.team.players.clear
        #reset and adjust the team roster_spots
        current_user.team.roster_spots = 5
        current_user.team.save
      end
        #end of no custom player && params check

      #When there are checked players
      if params[:player_ids]

        old_players = current_user.team.players
        new_players = params[:player_ids].map { |id| Player.find(id) }

        #Delete any old players not included in the array of new players
        old_players.each do |old_player|
          if !new_players.include?(old_player)
            old_player.team_id = nil
            old_player.save
          end
        end

        #shovel in the custom player unless there are alreay 5 or more players included
        new_players << @custom_player if @custom_player && new_players.length < 5
        #add/re-assign new players with limit of 5
        new_players.each do |new_player|
          current_user.team.players << new_player unless current_user.team.players.count == 5 && new_player.team_id == nil
        end

        #reset and adjust the team roster_spots count
        current_user.team.roster_spots = 5
        current_user.team.roster_spots -= current_user.team.players.count
        current_user.team.save
        redirect :'users/:id'
      end
      #end of check when there are checked players and players currently on roster
    else
      redirect :'/users/login'
    end
    redirect :'/users/:id'
    #**************CHECKBOX LOGIC END********************************************
  end

  delete '/teams/:id' do
    @team = Team.find(params[:id])
    if logged_in? && @team.id == current_user.team.id
      @team.players.clear
      Team.delete(@team.id)
      redirect :'/users/:id'
    else
      redirect :'/users/login'
    end
  end
end
