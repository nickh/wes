require 'spec_helper'

describe UserSessionsController do
  render_views

  describe 'GET /user_session/new => #new' do
    it 'succeeds' do
      get :new
      response.should be_success
    end
  end

  describe 'POST /user_session => #create' do
    before(:each) do
      @user = Factory(:user)
    end

    it 'creates a user session' do
      post :create, :user_session => {:email => @user.email, :password => @user.password}
      user_session = UserSession.find
      user_session.should_not be_nil
      user_session.user.should == @user
    end

    it 'redirects to the home page' do
      post :create, :user_session => {:email => @user.email, :password => @user.password}
      response.should redirect_to(root_path)
    end
  end

  describe 'DELETE /user_session => #delete' do
    before(:each) do
      @user = Factory(:user)
      post :create, :user_session => {:email => @user.email, :password => @user.password}
    end

    it 'deletes the user session' do
      delete :destroy
      UserSession.find.should be_nil
    end

    it 'redirects to the login page' do
      delete :destroy
      response.should redirect_to(new_user_session_path)
    end
  end
end
