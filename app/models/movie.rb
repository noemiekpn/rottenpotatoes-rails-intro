class Movie < ActiveRecord::Base

# A class method that returns the appropriate values for ratings
  def self.ratings_list
    ['G', 'PG', 'PG-13', 'R']
  end
end
