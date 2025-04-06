class NewsletterSubscriptionsController < ApplicationController
    def create
        user=User.find_by(email: params[:email])

        if user && !user.newsletter?
            user.update(newsletter: true)
            NewsletterMailer.welcome_email(user).deliver_now
            flash[:notice]='Iscrizione avvenuta con successo'
        else
            flash[:notice]='Utente già iscritto o non trovato'
        end

        redirect_to root_path
    end
end
