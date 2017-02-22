require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza.rb')

# POST REQUESTS CAN ONLY BE SENT BY FORMS!!!!!

# The below includes RESTful routing terms and their actions

# INDEX - READ - ACTION - index all the routes

get '/pizzas' do
  @pizzas = Pizza.all()    # @ instance variable makes it available to put in website 
  erb( :index )
end 

# NEW - CREATE - ACTION - to get the form (submitting a form is actually two steps)

# Sinatra will work through your orders in order, from top to bottom. So a new pizza will be typed into the bar. If pizzas/5 is typed in, it won't hit /pizzas/new, it will skip over and then got to /pizzas/5 because it matches an id

get '/pizzas/new' do
  erb( :new )
end

# SHOW - READ - ACTION - find one pizza by ID

get '/pizzas/:id' do      # NOT a symbol - sinatra uses it to determine dynamic IDs
  @pizza = Pizza.find( params[:id] )
  erb( :show )
end

# CREATE - CREATE - ACTION - submit form

post '/pizzas' do
  @new_pizza = Pizza.new( params )
  @new_pizza.save()
  erb (:create)
end

# could also do: redirect to '/pizzas/' + @new_pizza.id.to_s

# EDIT - UPDATE - create form
# Get back data from database - inject into a form

get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id]) # find pizza object by the current ID
  erb (:edit)
end


# UPDATE - UPDATE - submit form

post '/pizzas/:id' do
  @pizza_update = Pizza.new(params) 
  @pizza_update.update()
  redirect to("/pizzas/#{@pizza_update.id}")
end


# DESTROY - DELETE

post '/pizzas/:id/delete' do               # referring to id in database yet
  @delete_pizza = Pizza.find( params[:id] )
  @delete_pizza.delete()
  redirect to('/pizzas')
end

# Browsers don't support PUT or DELETE methods... So everything needs to be done with POST and GET methods

# DELETE doesn't work in browers, so will need to POST to "pizzas/:id/delete" 
# PUT (i.e. update) doesn't work... So will need to do PUT as POST to "pizzas/:id"

# JavaScript can use the other verbs... Which is why they exist.