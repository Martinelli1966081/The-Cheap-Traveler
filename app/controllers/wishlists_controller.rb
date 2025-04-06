class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlists = Wishlist.all
  end

  def show
  end

  def create
    @stay = Stay.find(params[:stay_id])
    
    existing_wishlist = Wishlist.find_by(user: current_user.username, name_stay: @stay.name)

    if existing_wishlist
      redirect_to wishlists_path, notice: 'Questa struttura è già nella tua wishlist.'
    else

      @wishlist = Wishlist.new(user: current_user.username, name_stay: @stay.name, stay_id: @stay.id, price: @stay.price)

      if @wishlist.save
        redirect_to wishlists_path, notice: 'Struttura aggiunta alla wishlist!'
      else
        redirect_to stays_path, alert: 'Errore durante l\'aggiunta alla wishlist.'
      end
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:wishlist_id])

    if @wishlist
      @wishlist.destroy
      redirect_to wishlists_path, notice: 'Struttura rimossa dalla wishlist.'
    else
      redirect_to wishlists_path, alert: 'Errore durante la rimozione dalla wishlist.'
    end
  end
end
