require "rails_helper"

RSpec.describe QaMailer, type: :mailer do
  describe "question_notification" do
    let(:mail) { QaMailer.question_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Question notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "answer_notification" do
    let(:mail) { QaMailer.answer_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Answer notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
