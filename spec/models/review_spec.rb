require 'spec_helper'

describe Review do
  describe 'attributes' do
    [:rating, :detail].each do |attr|
      it "responds to #{attr}" do
        Review.new.should respond_to(attr)
      end
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      Review.should belong_to(:user)
    end

    it 'belongs to a doctor' do
      Review.should belong_to(:doctor)
    end
  end

  describe 'validations' do
    before(:each) do
      user = Factory(:user)
      doctor = Factory(:doctor)
      @review = Review.new(:rating => 3, :user => user, :doctor => doctor)
    end

    it 'allows an empty rating value' do
      @review.rating = nil
      @review.should be_valid
    end

    it 'ensures ratings are >= 1' do
      @review.rating = 0
      @review.should_not be_valid
      @review.should have_errors_on :rating
      @review.rating = 1
      @review.should be_valid
    end

    it 'ensures ratings are <= 5' do
      @review.rating = 6
      @review.should_not be_valid
      @review.should have_errors_on :rating
      @review.rating = 5
      @review.should be_valid
    end

    it 'ensures the review has a user' do
      @review.user = nil
      @review.should_not be_valid
      @review.should have_errors_on :user
    end

    it 'ensures the review has a doctor' do
      @review.doctor = nil
      @review.should_not be_valid
      @review.should have_errors_on :doctor
    end
  end
end
