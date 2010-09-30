class ReviewsController < ApplicationController
  before_filter :ensure_signed_in

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @review = current_user.reviews.find_or_initialize_by_doctor_id(@doctor)
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @review = current_user.reviews.find_or_create_by_doctor_id(@doctor)
    @review.update_attributes(params[:review])
    redirect_to @doctor
  end
end
