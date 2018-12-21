class UsersController < ApplicationController

  get '/login' do
    erb :'users/login'
  end

end
