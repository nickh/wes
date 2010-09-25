require 'spec_helper'

describe UsersController do
  render_views

  describe 'GET /users/new => #new' do
    it 'succeeds' do
      get :new
      response.should be_success
    end
  end

  describe 'POST /users => #create' do
    before(:each) do
      @user_attrs = {
        :first_name            => 'Test',
        :last_name             => 'User',
        :email                 => 'test_user@example.com',
        :password              => 'test1234',
        :password_confirmation => 'test1234'
      }
    end

    it 'creates a user' do
      lambda do
        post :create, :user => @user_attrs
      end.should change(User, :count).by(1)
    end

    it 'creates a user session for the new user' do
      post :create, :user => @user_attrs
      user_session = UserSession.find
      user_session.should_not be_nil
      user_session.user.should == assigns[:user]
    end

    it 'redirects to the show page' do
      post :create, :user => @user_attrs
      response.should redirect_to(user_path(assigns(:user)))
    end
  end

  describe 'GET /users/:id => #show' do
    before(:each) do
      @user = Factory(:user)
    end

    it 'succeeds' do
      get :show, :id => @user
      response.should be_success
    end
  end
end
