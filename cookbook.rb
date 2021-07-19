require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :file, :recipes

  def initialize(csv_file_path)
    # INSTANCE VARIABLES
    @csv_file_path = csv_file_path
    @recipes = []

    load_csv
  end

  # add_recipe(recipe) which adds a new recipe to the cookbook
  def add_recipe(recipe)
    @recipes << recipe
    store_csv
  end

  # remove_recipe(recipe_index) which removes a recipe from the cookbook.
  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    store_csv
  end

  def all
    return @recipes
  end

  def mark_done_save(index)
    recipe = @recipes[index]
    recipe.mark_done
    store_csv
  end

  private

  def load_csv
    # PARSE
    # csv_options = { col_sep: ',', quote_char: '"' }
    # @file = CSV.open(csv_file_path, "wb", csv_options)
    @file = CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # puts "#{row[0]} is a #{row[1]} from #{row[2]}"
      row[:done] = (row[:done] == "true") # gives a conversion from true/false string into symbol
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def store_csv
    # STORE
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["name", "description", "rating", "prep_time", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end


# book = Cookbook.new("lib/recipes.csv")
# p book
