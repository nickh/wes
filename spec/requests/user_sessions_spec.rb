require 'spec_helper'

describe 'User sessions' do
  describe 'signin' do
    describe 'failure' do
      it 'does not sign a user in' do
        user = User.new(:email => '', :password => '')
        integration_sign_in user
        response.should have_selector('div.flash.warning', :content => 'Login failed')
      end
    end

    describe 'success' do
      it 'signs a user in' do
        user = Factory(:user)
        integration_sign_in user
        controller.should be_signed_in
      end
    end
  end

  describe 'signout' do
    it 'signs a user out' do
      user = Factory(:user)
      integration_sign_in user
      click_link 'Sign out'
      controller.should_not be_signed_in
    end
  end
end
