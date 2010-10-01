class DoctorsController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_admin_user, :only => [:new, :create]

  def index
    @query     = params[:q]
    conditions = @query.nil?? {} : {:conditions => ["name LIKE ?", "%#{@query}%"]}
    @doctors   = Doctor.find(:all, conditions).paginate(:page => params[:page])
  end

  def show
    @doctor  = Doctor.find(params[:id])
    @reviews = @doctor.reviews.paginate(:page => params[:page])
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      redirect_to @doctor
    else
      render 'new'
    end
  end
end
