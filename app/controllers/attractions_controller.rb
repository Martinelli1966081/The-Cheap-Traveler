class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all

    if params[:season].present? && params[:season] != "Tutte"
      @attractions = @attractions.where(season: params[:season])
    end

    if params[:city].present? && params[:city] != "Tutte"
      @attractions = @attractions.where(city: params[:city])
    end

    if params[:country].present? && params[:country] != "Tutte"
      @attractions = @attractions.where(country: params[:country])
    end

  end

  def show
    @attraction = Attraction.find(params[:id])
    @attraction.increment!(:views_count)
  end
end
