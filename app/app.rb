ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
enable :sessions

  before do
    @links = Link.all
  end

  get '/links' do
    erb :"links/index"
  end

  get '/links/new' do
    erb :"links/new"
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tag = Tag.create(tag: params[:tags])
    link.tags << tag
    link.save
    redirect to('/links')
  end

run! if app_file == $0
end
