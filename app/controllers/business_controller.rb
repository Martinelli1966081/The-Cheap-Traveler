class BusinessController < ApplicationController
  before_action :require_business, except: [:request_upgrade, :confirm_upgrade, :complete_upgrade]
  before_action :authenticate_user!, except: [:confirm_upgrade]
  before_action :validate_upgrade_token, only: [:confirm_upgrade, :complete_upgrade]
  def request_upgrade
    current_user.generate_upgrade_token!
    UserMailer.business_upgrade(current_user).deliver_now
    redirect_to root_path, notice: "Email di conferma inviata!"
  end

  def confirm_upgrade
    @user = User.find_by(upgrade_token: params[:token])
    render "confirm_upgrade" 
  end

  def complete_upgrade
    @user = User.find_by(upgrade_token: params[:token])
  
    if @user.valid_password?(params[:password])
      @user.update!(
        business: true, 
        upgrade_token: nil
      )
      redirect_to root_path, notice: "Sei ora un account Business!"
    else
      flash[:alert] = "Password non valida"
      render :confirm_upgrade, status: :unprocessable_entity
    end
  end

  def index
    @stays = current_user.stays
    @stay = Stay.new 
  end

  def create_stay
    @stay = current_user.stays.build(stay_params)
    if @stay.save
      redirect_to business_path, notice: 'Struttura creata con successo!'
    else
      render :index
    end
  end

  def destroy_stay
    @stay = current_user.stays.find(params[:id])
    @stay.destroy
    redirect_to business_path, notice: 'Struttura eliminata'
  end
  private

  def require_business
    redirect_to root_path, alert: "Area riservata" unless current_user.business?
  end

  def stay_params
    params.require(:stay).permit(:name, :city, :country, :family, :job, :group, 
                               :bus, :train, :price, :stay_type, :description, :tel)
  end

  def validate_upgrade_token
    @user = User.find_by(upgrade_token: params[:token])
    redirect_to root_path, alert: "Link non valido o scaduto" unless @user&.upgrade_token_valid?
  end
end