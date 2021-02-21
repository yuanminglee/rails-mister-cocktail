response = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')

response['drinks'].map(&:values).flatten.each do |ingredient|
  Ingredient.create!(name: ingredient)
end
