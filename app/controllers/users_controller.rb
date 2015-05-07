class UsersController < ApplicationController

  def new
    
  end

  def show
    # get the user with id :id (got from the URL)
    @user = User.find(params[:id])
  end

end
