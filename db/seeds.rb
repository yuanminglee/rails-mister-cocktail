# Seed ingredients
ingredient_response = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')
ingredients = ingredient_response['drinks'].map(&:values).flatten
ingredients.each do |ingredient|
  Ingredient.create!(name: ingredient) unless Ingredient.find_by_name(ingredient).present?
end

# Seed cocktails
50.times do
  cocktail_response = HTTParty.get('https://www.thecocktaildb.com/api/json/v1/1/random.php')
  cocktail = cocktail_response['drinks'].first

  next if Cocktail.find_by_name(cocktail['strDrink']).present?

  new_cocktail = Cocktail.new(
    name: cocktail['strDrink'],
    instructions: cocktail['strInstructions'],
    image_url: cocktail['strDrinkThumb']
  )

  next unless new_cocktail.save

  puts "Success! Added #{new_cocktail.name}."
  puts 'Adding ingredients...'

  ingredients = cocktail.select { |k, v| k.include?('strIngredient') && v.present? }
  description_keys = ingredients.keys.map { |key| key.gsub('Ingredient', 'Measure') }
  descriptions = cocktail.select { |k, _| description_keys.include? k }
  ingredient_descriptions = ingredients.values.zip(descriptions.values).map do |id|
    { ingredient_name: id.first, dose_description: id.last || 'No description' }
  end

  ingredient_descriptions.each do |id|
    new_cocktail.add_or_create_dose(id[:ingredient_name], id[:dose_description])
  end

  puts "Added #{new_cocktail.doses.count} ingredients to #{new_cocktail.name}!"
end
