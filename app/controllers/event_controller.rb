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
      if !session[:is_logged_in]
        erb :event, locals: {message: 'You need to log in before adding an event'}
      else 
        id = session[:user_id]
        user = User.find id
        event = user.events.create user_id: session[:user_id], name: params['event'], description: params['description'], image_url: params['image_url'], location: params['address'], date: params['event_date'], time: params['time'], category: params['category']
        p event
        redirect 'users/' + session[:user_id].to_s
      end
    end



    get '/:id' do |id|
      user = User.find_by id
      session[:is_logged_in] = true
      session[:user_id] = user.event.user_id
      puts '--------session--------'
      p session
      session[:user_id]
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
      puts '--------session--------'
      p session
      puts '-----------------------'
      if session[:is_logged_in]
        erb :form
      else
        erb :event, locals: {message: 'Must log in'}
      end
    end



end
