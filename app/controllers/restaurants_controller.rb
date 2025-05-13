class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    # render 'index.html.erb'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    # render 'show.html.erb'
  end

  def new
    # only for the form
    @restaurant = Restaurant.new
  end

  def create
    # to create the instance from the form data
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      # when it saves -> go to the restaurants show page
      redirect_to restaurant_path(@restaurant)
    else
      # when it doesnt save -> show the form again
      render 'new', status: :unprocessable_entity # throws a 422 (for Turbo)
    end
  end

  def edit
    # only for the form
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    # find the restaurant with the id
    @restaurant = Restaurant.find(params[:id])
    # then destroy
    @restaurant.destroy
    # redirect somewhere
    redirect_to restaurants_path, status: :see_other
  end

  def restaurant_params
    # Strong params -> white listing the attributes users can give us in the form
    params.require(:restaurant).permit(:name, :address)
  end
end

# 200 -> OK
#
# 303 -> Redirects
#
# 401 ->
# 404 -> Not Found
