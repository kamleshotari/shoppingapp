class SendEmail < ActionMailer::Base
	
  def send_email(user)
    @user = user
    mail(from: 'prabhasiddhi9@gmail.com', to: @user.email, subject: 'Confirmation Email')
  end
  
end
