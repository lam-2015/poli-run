class UsersController < ApplicationController

  # check if the user is logged in (e.g., for editing only her own information)
  before_filter :signed_in_user, only: [:edit, :update, :index]
  # check if the current user is the correct user (e.g., for editing only her own information)
  before_filter :correct_user, only: [:edit, :update]

  def new
    # init the user variable to be used in the sign up form
    @user = User.new
  end

  def create
    # refine the user variable content with the data passed by the sign up form
    @user = User.new(params[:user])
    if @user.save
      # handle a successful save
      flash[:success] = 'Welcome to PoliRun!'
      # automatically sign in the new user
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    # get the user with id :id (got from the URL)
    @user = User.find(params[:id])
  end

  def edit
    # intentionally left empty since the correct_user method (called by before_filter) initialize the @user object

    # without the correct_user method, this action should contain:
    # @user = User.find(params[:id])
  end

  def update
    # the correct_user method (called by before_filter) initialize the @user object
    # without the correct_user method, this action should also contain:
    # @user = User.find(params[:id])

    # check if the update was successfully
    if @user.update_attributes(params[:user])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # re-login the user
      sign_in @user
      # go to the user profile
      redirect_to @user
    else
      # handle a failed update
      render 'edit'
    end
  end

  def index
    # get all the users from the database
    @users = User.all
  end

  private

  # Redirect the user to the Sign in page if she is not logged in
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in" unless signed_in?
    # notice: "Please sign in" is the same of flash[:notice] = "Please sign in"
  end

  # Take the current user information (id) and redirect her to the home page if she is not the 'right' user
  def correct_user
    # init the user object to be used in the edit and update actions
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) # the current_user?(user) method is defined in the SessionsHelper
  end

end