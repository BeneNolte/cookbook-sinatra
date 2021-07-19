class Recipe
  attr_reader :done, :name, :description, :rating, :prep_time

  def initialize(name, description, rating, prep_time, done = false)
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
    @done = done
  end

  def mark_done
    @done = true
  end

  def done?
    @done
  end
end
