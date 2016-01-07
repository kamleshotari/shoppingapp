class SendEmail < ActionMailer::Base
	
  def send_email(user)
    @user = user
    mail(from: ENV['GMAIL_USERNAME'], to: @user.email, subject: 'Confirmation Email')
  end
  
end
