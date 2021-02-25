class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update destroy]

  def index
    @query = params.dig(:search, :name)
    @cocktails = Cocktail.search_by_name(@query).order(:name)
  end

  def show
  end

  def new
    @cocktail = Cocktail.new
    @cocktail.doses.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)

    if @cocktail.save
      redirect_to @cocktail
    else
      render :new
    end
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)

    if @cocktail.save
      redirect_to @cocktail
    else
      render :edit
    end
  end

  def destroy
    @cocktail.destroy

    redirect_to root_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :image_url, doses_attributes: [:id, :description, :ingredient_id, :_destroy])
  end
end
