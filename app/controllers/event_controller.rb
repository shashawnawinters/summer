class EventsController < ApplicationController
  get '/create/:id' do |id|
    user = User.find_by id
    if user
      erb :form, locals: {username: user.username}
    else
      erb :event, locals: {message: 'You need to log in before adding an event'}
    end
  end


    post '/' do
      p session
      if session[:is_logged_in]
        
        'false'
      else 
        erb :event, locals: {message: 'You must log in to create an event'}
      end
    end

    get '/create' do
      erb :form
    end

    get '/:id' do |id|
      user = User.find_by id
      session[:is_logged_in] = true
      session[:user_id] = user.event.user_id
      puts '--------session--------'
      p session
      puts '-----------------------'


      erb :my_events
      # if session
      #   puts '--------session true--------'
      # p session[:user_id]
      # puts '-----------------------'
      #   redirect '/' 
      # else 
      #   puts '--------session false--------'
      #   p session[:user_id]
      #   puts '-----------------------'
      #   erb :event, locals: {message: 'You must log in to create an event'}
      # end
      
      
    end

    get '/?' do 
      data = @data
      session[:is_logged_in] = true
      puts '--------session--------'
      p session
      puts '-----------------------'
      erb :my_events 
    end



end
