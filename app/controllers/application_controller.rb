class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def reject_not_logged_in_user
    unless logged_in?
      flash[:danger] = 'ログインしてください'
      redirect_to login_path
    end
  end

  def admin_user
    logged_in_user
    unless current_user.admin?
      flash[:danger] = '管理者ユーザ以外はアクセスできません'
      redirect_to root_path
    end
  end
end
