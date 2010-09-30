class DoctorsController < ApplicationController
  before_filter :ensure_signed_in

  def index
    @doctors = Doctor.paginate(:page => params[:page])
  end

  def show
    @doctor  = Doctor.find(params[:id])
    @reviews = @doctor.reviews.paginate(:page => params[:page])
  end
end
