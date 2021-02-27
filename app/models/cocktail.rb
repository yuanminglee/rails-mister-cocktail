class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy, inverse_of: :cocktail
  has_many :reviews, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo

  accepts_nested_attributes_for :doses, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.search_by_name(query)
    return all unless query

    where("name ILIKE '%#{query}%'")
  end

  def add_or_create_dose(ingredient_name, dose_description)
    ingredient = Ingredient.find_by_name(ingredient_name) || Ingredient.create!(name: ingredient_name)

    self.doses.create!(description: dose_description, ingredient: ingredient)
  end
end
