class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # flash[:success] = "ログイン成功"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    log_out
    @user.destroy
    redirect_to users_path
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      redirect_to questions_path unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
