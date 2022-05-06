# Preview all emails at http://localhost:3000/rails/mailers/qa_mailer
class QaMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/qa_mailer/question_notification
  def question_notification
    question = Question.first
    QaMailer.question_notification(question)
  end

  # Preview this email at http://localhost:3000/rails/mailers/qa_mailer/answer_notification
  def answer_notification
    answer = Answer.find(4)
    QaMailer.answer_notification(answer)
  end

end
