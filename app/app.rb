ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to '/links'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      redirect to 'sessions/new'
    end
  end

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
    tags = params[:name].gsub(/, /, ',').split(',')
    tags.each{ |tag| link.tags << Tag.create(name: tag) }
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :"links/index"
  end

  get '/users' do
    @user = User.new
    erb :'/users/index'
  end

  post '/users' do
    @user = User.new(name: params[:name],
                       password: params[:password],
                       email: params[:email],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect('/links')
    else
      flash.next[:errors] = @user.errors.full_messages
      redirect to('/users')
    end
  end

  get '/welcome' do
    @user = User.last
    erb :'login/welcome'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'Goodbye'
    redirect to 'links'
  end

run! if app_file == $0
end
