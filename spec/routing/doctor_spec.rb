require 'spec_helper'

describe 'Doctor routing' do
=begin
  # Neither syntax seems to work with nested resources.  rake routes disagrees.
  it 'has nested reviews' do
    assert_routing '/doctors/1/reviews', {
      :controller => 'reviews',
      :action     => 'index',
      :doctor_id  => '1'
    }
    #{:get => '/doctors/1/reviews'}.should route_to(
    #  :controller => 'reviews',
    #  :action     => 'index',
    #  :doctor_id  => '1'
    #)
  end
=end
end
