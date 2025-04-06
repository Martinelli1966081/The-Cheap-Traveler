class NewsletterMailer < ApplicationMailer
  default from: 'no-reply@TheCheapTraveler'

  def welcome_email(user)
    @user=user
    mail(to: @user.email, subject: 'Grazie per esserti iscritto')
  end
end
