class ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]
  before_action :set_cocktail, only: %i[create edit update]

  def create
    @review = Review.new(review_params)
    @review.cocktail = @cocktail

    @review.save

    redirect_to @cocktail
  end

  def edit
  end

  def update
    @review.update(review_params)

    if @review.save
      redirect_to @cocktail
    else
      render :edit
    end
  end

  def destroy
    @review.destroy

    redirect_to @review.cocktail
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
