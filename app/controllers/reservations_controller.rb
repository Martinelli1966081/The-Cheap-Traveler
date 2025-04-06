class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.where(user: current_user.id)
  end

  def destroy
    set_reservation
    if @reservation
      @reservation.destroy
      flash[:notice] = "Prenotazione eliminata con successo!"
    else
      flash[:alert] = "Errore durante l'eliminazione della prenotazione!"
    end
    redirect_to reservations_path
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    @reservation.user = current_user.id

    if @reservation.save && @reservation.days_counter > 0 
      redirect_to reservations_path, notice: "Prenotazione effettuata con successo!"
    else
      flash[:alert] = "Errore nella prenotazione. Verifica le date."
      redirect_to stays_path
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name_stay, :name_auto, :check_in, :check_out, :days_counter, :people, :description)
  end

  def set_reservation
    @reservation = Reservation.find_by(id: params[:id])
    unless @reservation
      flash[:alert] = "Prenotazione non trovata"
      redirect_to reservations_path
    end
  end

  
end
