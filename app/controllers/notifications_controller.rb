class NotificationsController < ApplicationController
    def show
      notifications = []
  
      return render json: { notifications: [] } unless user_signed_in?
  
      if current_user.structure_notifications
        recent_business_stay = Stay.joins(:user)
                                  .where(users: { business: true })
                                  .where("stays.created_at >= ?", 1.hour.ago)
                                  .order(created_at: :desc)
                                  .first
  
        if recent_business_stay
          notifications << {
            type: "new_stay",
            message: "Nuova struttura disponibile: #{recent_business_stay.name}"
          }
        end
      end
  
      if current_user.discount_notifications && rand(1..5) == 1
        discount = rand(5..30)
        notifications << {
          type: "discount", 
          message: "Hai ricevuto uno sconto del #{discount}% su tutte le strutture per un periodo limitato"
        }
      end
  
      render json: { notifications: notifications }
    end
  
    def update_notification_preferences
      if current_user.update(notification_params)
        redirect_back(fallback_location: root_path, notice: 'Preferenze aggiornate con successo')
      else
        redirect_back(fallback_location: root_path, alert: 'Errore nell\'aggiornamento delle preferenze')
      end
    end
  
    private
  
    def notification_params
      params.require(:user).permit(:discount_notifications, :structure_notifications)
    end
end