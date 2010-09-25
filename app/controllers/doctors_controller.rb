class DoctorsController < ApplicationController
  before_filter :ensure_signed_in

  def index
    @doctors = Doctor.find(:all)
  end
end
