require 'bcrypt'

class UsersController < ApplicationController
 	
  #Loads individual user's home profile page
  get '/:id/?' do |id|
    user = User.find_by id
    if user
      erb :profile, locals: {username: user.username}
    else
      erb :event, locals: {message: 'No user by that ID found'}
    end
    # erb :event
  end	


  delete '/:id/?' do |id|
    # Delete a single userr
    user = User.find_by id
    console.log(user)

    if user
      user.destroy
      erb :login, { status: 'ok', message: 'User deleted' }.to_json
    else
      erb :login, { status: 'error', message: 'Error' }.to_json
    end
  end

  #Logs user in and redirects to profile page
  post '/login/?' do
    user = User.find_by username: params['username']

    if user
      password = BCrypt::Password.new(user.password)

      if password == params['password']
        session[:is_logged_in] = true
        session[:user_id] = user.id
        p session
        redirect 'users/' + session[:user_id].to_s
      else
        incorrect = 'Incorrect Username or Password'
        erb :login, locals: {message: incorrect}
      end
    end
  end

  #Logs user out
  post '/logout/?' do
    session[:is_logged_in] = false
    session[:user_id] = nil
    p session
    redirect '/'
  end

  # get '/membersonly/?' do
  #   p session
  #   if session[:is_logged_in]
  #     'Hello ' 
  #   else
  #     'Unauthorized Access'
  #   end
  # end


  #Registers a new user and redirects to profile page
  post '/register/?' do
    password = BCrypt::Password.create(params['password'])
    if params['username'].length > 1 && params['email'].length >  6
      user  = User.find_by username: params['username']
      email = User.find_by email: params['email']
      if user || email
        'Username already taken or Email already registered'
      else
        user = User.create username: params['username'], email: params['email'], password: password
        if user 
          # 'User was added'
          session[:is_logged_in] = true
          session[:user_id] = user.id
          p session
          redirect 'users/' + session[:user_id].to_s
          
        else
          'Error'
        end
      end
    else 
      'Username or Email not long enough' 
    end  
  end
end
