class Doctor < ActiveRecord::Base
  has_many :reviews

  # Return the average of non-empty rating values rounded down to the nearest int
  def average_rating
    ratings = reviews.map{|r| r.rating}.reject{|r| r.nil?}
    ratings.sum / ratings.size
  end
end
