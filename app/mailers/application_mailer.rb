class ApplicationMailer < ActionMailer::Base
  default from: ENV["KEY"]
  layout 'mailer'
end
