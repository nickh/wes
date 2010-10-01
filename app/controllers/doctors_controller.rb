class DoctorsController < ApplicationController
  before_filter :ensure_signed_in

  def index
    @query     = params[:q]
    conditions = @query.nil?? {} : {:conditions => ["name LIKE ?", "%#{@query}%"]}
    @doctors   = Doctor.find(:all, conditions).paginate(:page => params[:page])
  end

  def show
    @doctor  = Doctor.find(params[:id])
    @reviews = @doctor.reviews.paginate(:page => params[:page])
  end
end
