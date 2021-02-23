class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.search_by_name(query)
    return all unless query

    where("name ILIKE '%#{query}%'")
  end
end
