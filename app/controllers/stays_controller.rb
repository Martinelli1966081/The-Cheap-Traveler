class StaysController < ApplicationController
  before_action :set_stay, only: [:show, :edit, :update, :destroy]
  before_action :check_business, except: [:index, :show]

  def index
    @stays = Stay.all

    if params[:stay_type].present? && params[:stay_type] != "Tutte"
      @stays = @stays.where(stay_type: params[:stay_type])
    end

    if params[:city].present? && params[:city] != "Tutte"
      @stays = @stays.where(city: params[:city])
    end

    if params[:country].present? && params[:country] != "Tutte"
      @stays = @stays.where(country: params[:country])
    end

    if params[:family].present? 
      @stays = @stays.where(family: true)
    end

    if params[:job].present? 
      @stays = @stays.where(job: true)
    end
  end

  def show
    @stay = Stay.find(params[:id])
    @reservation = Reservation.new
    @stay.increment!(:views_count)
  end

  def new
    @stay = current_user.stays.build
  end

  def create
    @stay = current_user.stays.build(stay_params)
    
    if @stay.save
      redirect_to @stay, notice: 'Struttura creata con successo.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    # Solo il proprietario può modificare
    redirect_to stays_path, alert: 'Non autorizzato' unless owner?
  end

  def update
    if @stay.update(stay_params)
      redirect_to business_path, notice: 'Modifiche salvate con successo!'
    else
      render :edit
    end
  end

  def destroy
    if owner?
      @stay.destroy
      redirect_to stays_url, notice: 'Struttura eliminata con successo.'
    else
      redirect_to stays_path, alert: 'Non autorizzato'
    end
  end

  private

  def set_stay
    @stay = Stay.find(params[:id])
  end

  def stay_params
    params.require(:stay).permit(:name, :city, :country, :family, :job, :group, 
                               :bus, :train, :price, :stay_type, :description, :tel)
  end

  def check_business
    unless current_user.business?
      redirect_to stays_path, alert: 'Solo gli account business possono gestire strutture'
    end
  end

  def owner?
    @stay.user_id == current_user.id
  end
end