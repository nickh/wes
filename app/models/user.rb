class User < ActiveRecord::Base
  acts_as_authentic

  has_many :reviews

  validate :email, :unique => true
end
