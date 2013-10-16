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
    @post_id = (params[:post][:id])
    @post_url = '/user_post/#{@post_id}'
    @post = Post.create(post_url: @post_url, post_title: (params[:post][:post_title]), post_body: params[:post][:post_body])
  else
    @post = Post.create(params[:post])
  end
  redirect '/'
end

get '/user_post/:id' do
  @post = Post.find_by_id(params[:post][:id])

  erb :user_post
end
