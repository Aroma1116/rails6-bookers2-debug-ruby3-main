class ContactMailer < ApplicationMailer
  default from: 'aroma1116@outlook.jp'

  def send_mail(mail_title,mail_content,group_users) #メソッドに対して引数を設定
    @mail_title = mail_title
    @mail_content = mail_content
    mail to: group_users.pluck(:email), subject: mail_title
  end
end
