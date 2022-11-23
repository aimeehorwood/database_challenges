# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')


repo = RecipeRepository.new


repo.all.each do |recipe|
  puts "#{recipe.name} - #{recipe.cooking_time} minutes - #{recipe.rating}/5"
end 

recipe = repo.find(1)
puts recipe.name