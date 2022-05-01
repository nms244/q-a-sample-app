class AnswersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      flash[:success] = '回答しました'
      redirect_to question_path(@answer.question_id)
    else
      flash[:danger] = '回答できませんでした'
      redirect_to question_path(@answer.question_id)
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    flash[:success] = '回答を削除しました'
    redirect_to question_path(answer.question)
  end

  private

    def answer_params
      params.require(:answer).permit(:body, :question_id)
    end

    def correct_user
      answer = current_user.answers.find_by(params[:id])
      if answer.nil?
        flash[:danger] = '他のユーザの回答は編集できません'
        redirect_to question_path(Answer.find(params[:id]).question)
      end
    end
end
