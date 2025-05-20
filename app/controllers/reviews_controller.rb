class ReviewsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save
      # redirect_to restaurant_path(@restaurant)
      # stay on the page and only change the reviews partial
      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant) }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "reviews",
            partial: 'reviews/index', locals: {
              restaurant: @restaurant,
              review: Review.new
            }
            )
        end
      end
    else
      # if it doesnt save, show the form again
      render 'restaurants/show', status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
