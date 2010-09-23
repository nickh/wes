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
    [:first_name, :last_name].each do |attr|
      it "responds to #{attr}" do
        User.new.should respond_to(attr)
      end
    end
  end
end
