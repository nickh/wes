require 'spec_helper'

describe DoctorsController do
  include Authlogic::TestCase
  render_views

  before(:each) do
    activate_authlogic
  end

  describe 'GET /doctors => #index' do
    context 'when not signed in' do
      before(:each) do
        test_sign_out
      end

      it 'denies access' do
        get :index
        response.should redirect_to(signin_path)
      end
    end

    context 'when signed in' do
      before(:each) do
        @doctors = [Factory(:doctor), Factory(:doctor)]
        test_sign_in(Factory(:user))
      end

      it 'succeeds' do
        get :index
        response.should be_success
      end

      it 'loads the doctors' do
        get :index
        assigns[:doctors].should == @doctors
      end

      it 'paginates doctors' do
        40.times do |i|
          Factory(:doctor, :name => "Doctor #{i}")
        end
        get :index
        response.should have_selector('div.pagination')
        response.should have_selector('span.disabled', :content => 'Previous')
        response.should have_selector('a', :href => '/doctors?page=2', :content => '2')
        response.should have_selector('a', :href => '/doctors?page=2', :content => 'Next')
      end
    end
  end

  describe 'GET /doctors/:doctor_id => #show' do
    context 'when not signed in' do
      before(:each) do
        test_sign_out
      end

      it 'denies access' do
        get :index
        response.should redirect_to(signin_path)
      end
    end

    context 'when signed in' do
      before(:each) do
        @doctor = Factory(:doctor)
        @user   = Factory(:user)
        test_sign_in(@user)
      end

      it 'succeeds' do
        get :show, :id => @doctor
        response.should be_success
      end

      it 'paginates reviews' do
        40.times do |i|
          Factory(:review, :doctor => @doctor, :user => @user)
        end
        get :show, :id => @doctor
        response.should have_selector('div.pagination')
        response.should have_selector('span.disabled', :content => 'Previous')
        response.should have_selector('a', :href => doctor_path(@doctor, :page => 2), :content => '2')
        response.should have_selector('a', :href => doctor_path(@doctor, :page => 2), :content => 'Next')
      end
    end
  end
end
