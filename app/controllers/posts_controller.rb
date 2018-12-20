class PostsController < ApplicationController

  get '/posts' do
    "You are logged in as #{session[:email]}"
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
