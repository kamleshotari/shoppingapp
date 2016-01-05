class SendEmail < ActionMailer::Base
	
  def send_email(user)
    @user = user
    mail(from: 'vickyrocks86@gmail.com', to: @user.email, subject: 'Confirmation Email')
  end
  
end
