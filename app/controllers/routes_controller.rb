class RoutesController < ApplicationController
  # check if the user is logged in (e.g., for editing only her own information)
  before_filter :signed_in_user

  def new
    @route = current_user.routes.build
  end

  def create
    @route = current_user.routes.build(params[:route])
    if @route.save
      flash[:success] = 'Route created!'
      redirect_to user_routes_path
    else
      render 'new'
    end
  end

  def show
    # get the route with id :id (got from the URL)
    @route = Route.find(params[:id])
    # get the information about the route owner
    @user = @route.user
  end

  def index
    # get the desired user
    @user = User.find(params[:user_id])
    # get all her routes
    @routes = @user.routes.paginate(page: params[:page])
  end

  def destroy
    # delete the route starting from its id
    Route.find(params[:id]).destroy
    redirect_to user_routes_path
  end

end
