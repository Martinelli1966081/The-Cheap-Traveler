class TaxisController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @taxis = current_user.taxis.order(day: :desc)
    @taxi = current_user.taxis.new
  end
  
  def create
    @taxi = current_user.taxis.new(taxi_params)
    
    # Gestione data
    if params[:taxi][:day].present?
      begin
        @taxi.day = DateTime.parse(params[:taxi][:day])
      rescue ArgumentError
        @taxi.day = nil
        @taxi.errors.add(:day, 'Formato data non valido')
      end
    end
    
    # Calcola durata
    if @taxi.partenza.present? && @taxi.arrivo.present?
      @taxi.duration = calculate_duration(@taxi.partenza, @taxi.arrivo)
    end
    
    if @taxi.save

      redirect_to taxis_path, notice: 'Prenotazione taxi creata con successo!'
    else
      @taxis = current_user.taxis.order(day: :desc)
      render :index
    end
  end
  
  def destroy
    @taxi = current_user.taxis.find(params[:id])
    
    @taxi.destroy
    redirect_to taxis_path, notice: 'Viaggio cancellato con successo.'
  end
  
  private
  
  def taxi_params
    params.require(:taxi).permit(:partenza, :arrivo, :day)
  end
  
  def calculate_duration(start_point, end_point)
    rand(10..120) 
  end
end