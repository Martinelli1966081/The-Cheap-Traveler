class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all

    if params[:country].present? && params[:country] != "Tutte"
      @destinations = @destinations.where(country: params[:country])
    end

    if params[:plane].present? 
      @destinations = @destinations.where(plane: true)
    end

    if params[:train].present? 
      @destinations = @destinations.where(train: true)
    end

    if params[:ship].present? 
      @destinations = @destinations.where(ship: true)
    end
  end

  def show
    @destination = Destination.find(params[:id])
  end
end
