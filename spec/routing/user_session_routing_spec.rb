require 'spec_helper'

describe 'User session routing' do
  it 'routes /signin to #new' do
    assert_routing '/signin', :controller => 'user_sessions', :action => 'new'
  end

  it 'routes /signout to #delete' do
    assert_routing '/signout', :controller => 'user_sessions', :action => 'delete'
  end
end
