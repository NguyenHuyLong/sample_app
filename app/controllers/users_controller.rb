class UsersController < ApplicationController
  before_action :load_gender, only: [:new, :create]

  def show
    @user = User.find_by id: params[:id]
  end

  def new
    @user = User.new
  end

  def create
    params[:user][:gender] = params[:user][:gender].downcase
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :gender
  end

  def load_gender
    @genders = User.genders.keys
  end
end
