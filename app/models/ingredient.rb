class Ingredient < ApplicationRecord
  has_many :doses

  validates_presence_of :name
  validates_uniqueness_of :name
end
