class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :top, :chef]
  before_action :set_restaurant, only: [:chef, :show, :edit, :update, :destroy]

  # '/restaurants/top'
  def top
    @restaurants = Restaurant.where(rating: 5)
    # render 'top.html.erb'
    # render
  end

  # '/restaurants/34/chef'
  def chef
    # @chef_name = @restaurant.chef_name
  end

  def index
    # @restaurants = Restaurant.all
    @restaurants = policy_scope(Restaurant)
    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "restaurants/info_window", locals: { restaurant: restaurant }),
        marker_html: render_to_string(partial: "marker")
      }
    end
    # render 'index.html.erb'
    respond_to do |format|
      format.html
      format.json { render json: @restaurants }
    end
  end

  def show
    # @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    authorize @restaurant
    # render 'show.html.erb'
  end

  def new
    # only for the form
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    # to create the instance from the form data
    @restaurant = Restaurant.new(restaurant_params)
    # dates = params[:restaurant][:opening_date].split(' to ')
    # @restaurant.start_date = dates.first
    # @restaurant.end_date = dates.last
    @restaurant.user = current_user
    authorize @restaurant
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
    # # @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def update
    authorize @restaurant
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    # find the restaurant with the id
    # then destroy
    authorize @restaurant
    @restaurant.destroy
    # redirect somewhere
    redirect_to restaurants_path, status: :see_other
  end

  private

  def restaurant_params
    # Strong params -> white listing the attributes users can give us in the form
    params.require(:restaurant).permit(:name, :address, :rating, :category, :opening_date)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end

# 200 -> OK
#
# 303 -> Redirects
#
# 401 ->
# 404 -> Not Found
