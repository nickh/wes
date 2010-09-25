class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor

  validates :rating, :inclusion => {:in => 1..5, :allow_nil => true, :message => 'must be between 1 and 5'}
  validates :user,   :presence => true
  validates :doctor, :presence => true

  default_scope :order => 'reviews.updated_at DESC'
end
