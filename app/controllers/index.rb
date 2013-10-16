enable :sessions

get '/' do
  @posts = Post.all
  erb :index
end

get '/create_post' do
  erb :create_post
end

post '/create_post' do
  #if url field is nil, render automatic 'internal' url:
  if params[:post][:url] == nil
    # '/user_post/:id'
    @post = Post.create(post_title: (params[:post][:post_title]), post_body: params[:post][:post_body])
    @post_url = "/user_post/#{@post.id}"
    @post.update_attributes(post_url: @post_url)
  else
    @post = Post.create(params[:post])
  end
  redirect '/'
end

get '/user_post/:id' do
  @post = Post.find_by_id(params[:id])
  erb :user_post
end

get '/login_signup' do
  erb :login_signup
end

post '/login' do
  user = User.find_by_username(params[:user][:username])
  if user.password == params[:user][:password]
    session[:user_id] = user.id
    session[:user_name] = user.username
    redirect '/'
  else
    @error_login = "username or password incorrect"
    redirect '/login_signup'
  end
end

post '/signup' do
  user = User.create(params[:user])
  @error_signup = user.errors.full_messages

  if @error_signup.any?
    @error_signup = @error_signup.join(", ")
    redirect '/'
  else
    session[:user_id] = user.id
    redirect to '/'
  end

end

get '/user_profile/:id' do
  @user = User.find_by_id(params[:id])

  erb :user_profile
end

get '/logout' do
  session.clear
  redirect '/login_signup'
end





