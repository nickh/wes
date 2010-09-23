class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create!(params[:user])
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end
end
