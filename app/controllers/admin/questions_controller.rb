class Admin::QuestionsController < ApplicationController

  before_action :admin_user


  def index
    @questions = Question.all
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = '質問を削除しました'
    redirect_to admin_users_path
  end
end
