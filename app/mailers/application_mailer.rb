class ApplicationMailer < ActionMailer::Base
  default from: 'notice@qa-sample-app.com'
  layout 'mailer'
end
