require 'spec_helper'

describe Doctor do
  describe 'attributes' do
    [:name].each do |attr|
      it "responds to #{attr}" do
        Doctor.new.should respond_to(attr)
      end
    end
  end
end
