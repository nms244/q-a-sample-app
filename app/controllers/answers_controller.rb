class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(@answer.question_id)
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    redirect_to root_path
  end

  private

    def answer_params
      params.require(:answer).permit(:body, :question_id)
    end
end
