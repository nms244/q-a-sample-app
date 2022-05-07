class Admin::SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password]) && user&.admin?
      log_in user
      flash[:sucess] = 'ログインしました'
      redirect_to admin_users_path
    elsif !user.admin?
      flash.now[:danger] = '管理者アカウントでログインしてください'
      render 'new'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end
end
