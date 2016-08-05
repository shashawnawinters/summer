class HomeController < ApplicationController
  get '/register/?' do
    erb :register
  end  

  get '/login/?' do
    erb :login, locals: {message: ''}    
  end
  
  get '/' do 
    erb :event, locals: {message: ''}
  end
end
