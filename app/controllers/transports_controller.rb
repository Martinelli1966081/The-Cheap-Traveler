class TransportsController < ApplicationController

  def index
    @transports = Transport.all
  end

  def show
    @reservation = Reservation.new
    @transport = Transport.find(params[:id])
  end
end
