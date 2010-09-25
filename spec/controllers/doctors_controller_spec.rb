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
    end
  end
end
