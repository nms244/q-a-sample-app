class AnswersController < ApplicationController
  before_action :reject_not_logged_in_user, only: %i[create destroy]
  before_action :reject_incorrect_user, only: :destroy

  def create
    @answer = current_user.answers.build(answer_params)
    user_ids = @answer.question.answers.where.not(user_id: @answer.user_id).pluck(:user_id) + [@answer.question.user_id]
    if @answer.save
      User.where(id: user_ids).find_each do |user|
        QaMailer.answer_notification(@answer, user).deliver_now
      end
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

  def reject_incorrect_user
    answer = current_user.answers.find_by(params[:id])
    if answer.nil?
      flash[:danger] = '他のユーザの回答は編集できません'
      redirect_to question_path(Answer.find(params[:id]).question)
    end
  end
end
