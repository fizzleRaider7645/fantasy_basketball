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
    #check if logged in
    if logged_in?
      @team = Team.find(params[:id])
      erb :'teams/show'
    else
      redirect :'/login'
    end
  end

  get '/teams/:id/edit' do
    @team = Team.find(params[:id])
    if logged_in? && @team.user_id == current_user.id
      # @team = Team.find(params[:id])
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
      if params[:custom_player_name] != "" && !current_user.team.at_limit?
        @player = Player.create(name: params[:custom_player_name])
        current_user.team.players << @player
      end
      #end of custom player check

      #check for players to add from checkbox
      current_ids = current_user.team.players.map { |player| player.id }
      incoming_ids = params[:player_ids].map(&:to_i)
      #checking whether to clear team
      if params.keys.include?("player_ids")
        #checking if any adding or deleteing of players needs to occur
        if current_ids != incoming_ids
          incoming_ids.each do |id|
            if !current_ids.include?(id)
              @player = Player.find(id)
              @player.team_id = nil
              @player.save
              current_user.team.roster_spots += 1
              current_user.team.save
            else
              @player.team_id = current_user.team.id
              @player.save
              current_user.team.roster_spots -= 1
              current_user.team.save
            end
          end
        else
          redirect :'/show'
          #end of adding / deleting check
      end

      else
        current_user.team.players.clear
        current_user.team.roster_spots = 5
        current_user.team.save
      end
      redirect :'/show'
      #end of checkbox check
    else
      redirect :'/login'
      #end of login check
    end
  end
end
