require 'spec_helper'

describe Doctor do
  describe 'attributes' do
    [:name].each do |attr|
      it "responds to #{attr}" do
        Doctor.new.should respond_to(attr)
      end
    end
  end

  describe 'associations' do
    it 'has many reviews' do
      Doctor.should have_many(:reviews)
    end

    it 'orders reviews correctly' do
      doctor = Factory(:doctor)
      user1  = Factory(:user, :email => Factory.next(:email))
      user2  = Factory(:user, :email => Factory.next(:email))
      review1 = Factory(:review, :doctor => doctor, :user => user1, :updated_at => 1.day.ago, :created_at => 2.days.ago)
      review2 = Factory(:review, :doctor => doctor, :user => user2, :updated_at => 1.hour.ago, :created_at => 4.days.ago)
      doctor.reviews.should == [review2, review1]
    end
  end

  describe '#average_rating' do
    before(:each) do
      @doctor = Factory(:doctor)
      @user   = Factory(:user)
    end

    it 'returns nil if there are no reviews' do
      @doctor.average_rating.should be_nil
    end

    it 'returns nil if there are no reviews with ratings' do
      @doctor.reviews.create!(:user => @user, :rating => nil)
      @doctor.average_rating.should be_nil
    end

    it 'computes the average rating value from associated reviews' do
      @doctor.reviews.create!(:user => @user, :rating => 3)
      @doctor.reviews.create!(:user => @user, :rating => 5)
      @doctor.average_rating.should == 4
    end

    it 'rounds down to the nearest integer' do
      @doctor.reviews.create!(:user => @user, :rating => 2)
      @doctor.reviews.create!(:user => @user, :rating => 5)
      @doctor.average_rating.should == 3
    end

    it 'ignores reviews with no rating value' do
      @doctor.reviews.create!(:user => @user, :rating => 3)
      @doctor.reviews.create!(:user => @user, :rating => nil)
      @doctor.reviews.create!(:user => @user, :rating => 5)
      @doctor.average_rating.should == 4
    end
  end
end
