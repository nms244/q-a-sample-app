class QaMailer < ApplicationMailer
  def question_notification(question,user)
    @question = question
    mail to: user.email,
         subject: '質問が作成されました'
  end

  def answer_notification(answer, user)
    @answer = answer
    mail to: user.email,
          subject: '質問に回答がつきました'
  end
end
