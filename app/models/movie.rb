class Movie < ActiveRecord::Base

# A class method that returns the appropriate values for ratings
  def self.ratings_list
    Movie.select(:rating).pluck(:rating).uniq
  end
end
