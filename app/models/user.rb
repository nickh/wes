class User < ActiveRecord::Base
  acts_as_authentic

  validate :email, :unique => true
end
