class QuestionsController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update destroy solve]
  before_action :correct_user, only: %i[edit update destroy solve]

  def index
    @questions = Question.eager_load(:user).order(created_at: :desc).page(params[:page]).per(5)
  end

  def solved
    @questions = Question.eager_load(:user).where(solved: true).order(created_at: :desc).page(params[:page]).per(5)
    render :index
  end

  def unsolved
    @questions = Question.eager_load(:user).where(solved: false).order(created_at: :desc).page(params[:page]).per(5)
    render :index
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    @emails = User.where.not(id: @question.user_id).pluck(:email)
    if @question.save
      @emails.each do |email|
        QaMailer.question_notification(@question, email).deliver_now
      end
      flash[:success] = '質問を作成しました'
      redirect_to @question
    else
      flash.now[:danger] = '質問の作成ができませんでした'
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.eager_load(:user)
    @answer = current_user.answers.build if logged_in?
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = '質問を更新しました'
      redirect_to @question
    else
      flash.now[:danger] = '質問の更新ができませんでした'
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = '質問を削除しました'
    redirect_to root_url
  end

  def solve
    if @question.update(solved: true)
      flash[:success] = '解決済みにしました'
      redirect_to question_path(@question)
    else
      flash.now[:danger] = '解決済みにできませんでした'
      render question_url(@question)
    end
  end

  private

  def correct_user
    @question = current_user.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
