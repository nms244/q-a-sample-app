class QuestionsController < ApplicationController
  before_action :set_question, only: :show
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to root_url
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end

end
