class TravelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_travels = Travel.where(creator: current_user.id)
  end

  def create
    stay = Stay.find(params[:stay_id])
    @travel = Travel.new( name_stay: stay.name, creator: current_user.id, people:1, price: stay.price)

    if @travel.save
      redirect_to stays_path, notice: "Viaggio di gruppo creato con successo!"
    else 
      redirect_to stays_path, alert: "Errore nella creazione del viaggio"
    end
  end 

  def join 
    @travel = Travel.find(params[:id])
    if @travel.people < 10
      @travel.increment!(:people)
      redirect_to stays_path, notice: "Ti sei unito al gruppo"
    else 
      redirect_to stays_path, alert: "Il gruppo ha già 10 partecipanti"
    end
  end
end
