require 'spec_helper'

describe User do
  describe 'Authlogic session management' do
    authlogic_attrs = [
      :email, :crypted_password, :password_salt, :persistence_token,
      :single_access_token, :perishable_token, :login_count, :failed_login_count,
      :last_request_at, :current_login_at, :last_login_at, :current_login_ip,
      :last_login_ip
    ]
    authlogic_attrs.each do |attr|
      it "responds to authlogic attribute #{attr}" do
        User.new.should respond_to(attr)
      end
    end
  end

  describe 'attributes' do
    [:first_name, :last_name, :admin?].each do |attr|
      it "responds to #{attr}" do
        User.new.should respond_to(attr)
      end
    end

    it 'disables admin by default' do
      User.new.admin?.should be_false
    end
  end

  describe 'associations' do
    it 'has many reviews' do
      User.should have_many(:reviews)
    end
  end

  describe 'validation' do
    it 'ensures email is unique' do
      user1 = Factory.create(:user)
      user2 = Factory.build(:user, :email => user1.email)
      user2.should_not be_valid
      user2.should have_errors_on(:email)
    end
  end

  describe '#full_name' do
    it 'returns the full name' do
      user = User.new(:first_name => 'Full', :last_name => 'Name')
      user.full_name.should == 'Full Name'
    end

    it 'returns if the first name is nil' do
      user = User.new(:first_name => nil, :last_name => 'Name')
      user.full_name.should == 'Name'
    end

    it 'returns if the last name is nil' do
      user = User.new(:first_name => 'First', :last_name => nil)
      user.full_name.should == 'First'
    end
  end
end
