class ReviewsController < ApplicationController

  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to :back
    else
      flash[:notice] = @review.errors.full_messages
      redirect_to :back
    end
  end



  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to :back, notice: 'Product deleted!'
  end

  private

    def review_params
      params.require(:review).permit(:description, :rating)
    end

end


