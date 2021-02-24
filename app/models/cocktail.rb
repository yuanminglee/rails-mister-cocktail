class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy, inverse_of: :cocktail
  has_many :ingredients, through: :doses

  accepts_nested_attributes_for :doses, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.search_by_name(query)
    return all unless query

    where("name ILIKE '%#{query}%'")
  end
end
