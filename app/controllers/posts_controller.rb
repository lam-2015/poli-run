class PostsController < ApplicationController
  # check if the user is logged in
  before_filter :signed_in_user

  def create
    # build a new post from the information contained in the "new post" form
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to root_url
    else
      render 'pages/home'
    end
  end

end