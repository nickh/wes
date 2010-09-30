class User < ActiveRecord::Base
  acts_as_authentic

  has_many :reviews

  validate :email, :unique => true

  def full_name
    name_parts = []
    name_parts << first_name unless first_name.nil?
    name_parts << last_name  unless last_name.nil?
    name_parts.join(' ').strip
  end
end
