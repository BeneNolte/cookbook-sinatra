require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

### Controller ###

get '/' do # <- Router part
  # 'Hello world!'
  csv_file = File.join(__dir__, 'recipes.csv')
  cookbook   = Cookbook.new(csv_file)
  @recipes = cookbook.all
  erb :index

  # <h1>Hello <em>world</em>!</h1>
  # [...]   #
  # [...]   # <- Controller part
  # [...]   #

end

get '/new' do
  erb :new
end

post '/recipes' do
  csv_file = File.join(__dir__, 'recipes.csv')
  cookbook   = Cookbook.new(csv_file)
  recipe = Recipe.new(params[:user_name], params[:user_description], params[:user_rating], params[:user_prep_time], params[:user_done])
  cookbook.add_recipe(recipe)

  redirect to '/'
  erb :recipes

end
