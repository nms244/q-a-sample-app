class QaMailer < ApplicationMailer

  def question_notification(question)
    @question = question
    @emails = User.where.not(id: question.user_id).pluck(:email)

    mail bcc: @emails,
         subject: "質問が作成されました"
  end

  def answer_notification(answer)
    @answer = answer
    user_ids = answer.question.answers.where.not(user_id: answer.user_id).pluck(:user_id) + [answer.question.user_id]
    @emails = User.where(id: user_ids).pluck(:email)

    mail bcc: @emails,
         subject: "質問に回答がつきました"
  end
end
