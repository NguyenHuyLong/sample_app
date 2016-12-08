class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: :update
  before_action :verify_admin, only: :destroy
  before_action :load_gender, except: [:index, :show, :destroy]
  before_action :find_user, except: [:index, :new, :create]
  before_action :gender_downcase, only: [:create, :update]
  before_action :select_gender, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @microposts = @user.microposts.order(created_at: :desc).
      paginate page: params[:page]
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    correct_user
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
    else
      flash[:danger] = "Error! Cann't delete user"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :gender
  end

  def load_gender
    @genders = User.genders.keys.map(&:capitalize)
  end

  def correct_user
    find_user
    redirect_to root_url unless current_user.current_user? @user
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end

  def gender_downcase
    params[:user][:gender] = params[:user][:gender].downcase
  end

  def select_gender
    @gender = @user.gender.capitalize
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = "Users didn't existed"
      redirect_to users_url
    end
  end
end
