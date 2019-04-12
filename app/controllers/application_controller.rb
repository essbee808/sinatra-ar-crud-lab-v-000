require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
    erb :new
  end
  
  post '/articles' do #make a new article
      @article = Article.create(params)
      @article.save
    redirect to "/articles/#{@article.id}"
  end
  
  get '/articles' do
    @articles = Article.all
    erb :index
  end
  
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end
  
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end
  
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Articles.all.select do |el|
      if el.id == params[:id]
        binding.pry
        Article.destroy(el.id)
      end
    end
    @articles = Article.all
    redirect to 'index.erb'
  end
end
