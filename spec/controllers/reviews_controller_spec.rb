require 'spec_helper'

describe ReviewsController do
  include Authlogic::TestCase
  render_views

  before(:each) do
    activate_authlogic
    @doctor = Factory(:doctor)
    @review = {:rating => 1, :detail => 'Rule!'}
  end

  describe 'GET /doctors/:doctor_id/reviews/new => #new' do
    context 'when not signed in' do
      before(:each) do
        test_sign_out
      end

      it 'denies access' do
        get :new, :doctor_id => @doctor
        response.should redirect_to(signin_path)
      end
    end

    context 'when signed in' do
      before(:each) do
        test_sign_in(Factory(:user))
      end

      it 'succeeds' do
        get :new, :doctor_id => @doctor
        response.should be_success
      end
    end
  end

  describe 'POST /doctors/:doctor_id/reviews => #create' do
    context 'when not signed in' do
      before(:each) do
        test_sign_out
      end

      it 'denies access' do
        post :create, :doctor_id => @doctor, :review => @review
        response.should redirect_to(signin_path)
      end

      it 'does not create a review' do
        lambda do
          post :create,
               :doctor_id => @doctor,
               :review => {:rating => 1, :detail => 'Rule!'}
        end.should_not change(Review, :count)
      end
    end

    context 'when signed in' do
      before(:each) do
        test_sign_in(Factory(:user))
      end

      it 'creates a review' do
        lambda do
          post :create,
               :doctor_id => @doctor,
               :review => {:rating => 1, :detail => 'Rule!'}
        end.should change(Review, :count).by(1)
      end
    end
  end
end
