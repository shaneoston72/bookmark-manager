require 'sinatra/base'
require_relative './models/link'

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
    title = params[:title]
    url = params[:url]
    Link.create(url: url, title: title )
    erb :"links/index"
  end

run! if app_file == $0
end
