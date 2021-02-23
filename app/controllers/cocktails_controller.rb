class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update]

  def index
    @query = params.dig(:search, :name)
    @cocktails = Cocktail.search_by_name(@query).order(:name)
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)

    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def search

  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :image_url)
  end
end
