class EventsController < ApplicationController
  get '/:id/events/create' do |id|
    user = User.find_by id
    if user
      erb :form, locals: {username: user.username}
    else
      erb :event, locals: {message: 'No user by that ID found'}
    end
  end

  post '/create' do
    session[:is_logged_in] = true
    puts success
    p params
    redirect 'users/' + session[:user_id].to_s
  end

  get '/' do
    'yay'
  end

end
