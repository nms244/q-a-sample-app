class UsersController < ApplicationController
  before_action :reject_not_logged_in_user, only: %i[index show edit update destroy]
  before_action :reject_incorrect_user, only: %i[edit update destroy]

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
      flash[:success] = 'サインアップが完了しました'
      redirect_to questions_path
    else
      flash.now[:danger] = 'ユーザ登録失敗'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザ情報の更新に失敗しました'
      render 'edit'
    end
  end

  def destroy
    log_out
    @user.destroy
    flash[:success] = 'ユーザを削除しました'
    redirect_to users_path
  end

  private

  def reject_incorrect_user
    if current_user.id == params[:id]
      @user = User.find(current_user.id)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
