class UserMailer < ApplicationMailer
  def business_upgrade(user)
    @user = user
    @url = confirm_upgrade_business_index_url(token: @user.upgrade_token) 
    mail(
      to: @user.email,
      subject: "Conferma upgrade a Business",
      template_path: 'devise/mailer',
      template_name: 'business_upgrade'
    )
  end
end