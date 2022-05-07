class QaMailer < ApplicationMailer
  def question_notification(question, email)
    @question = question

    mail to: email,
         subject: '質問が作成されました'
  end

  def answer_notification(answer, email)
    @answer = answer

    mail to: email,
         subject: '質問に回答がつきました'
  end
end
