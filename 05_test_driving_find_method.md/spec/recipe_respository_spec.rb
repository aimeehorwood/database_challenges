require "recipe_repository"

def reset_recipes_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "recipes_directory_test" })
  connection.exec(seed_sql)
end

RSpec.describe RecipeRepository do
  before(:each) do
    reset_recipes_table
  end

  it "returns all recipes" do
    repo = RecipeRepository.new
    recipes = repo.all
    expect(recipes.length).to eq (2)
    expect(recipes.first.name).to eq("Lasagne")
    expect(recipes.first.cooking_time).to eq("75")
    expect(recipes.first.rating).to eq("5")
  end

  it "returns the single recipe Lasagne" do
    repo = RecipeRepository.new
    recipes = repo.find(1)
    expect(recipes.name).to eq("Lasagne")
    expect(recipes.cooking_time).to eq("75")
    expect(recipes.rating).to eq("5")
  end

  it "returns the single recipe Vodka Pasta" do
    repo = RecipeRepository.new
    recipes = repo.find(2)
    expect(recipes.name).to eq("Vodka Pasta")
    expect(recipes.cooking_time).to eq("30")
    expect(recipes.rating).to eq("3")
  end
end
