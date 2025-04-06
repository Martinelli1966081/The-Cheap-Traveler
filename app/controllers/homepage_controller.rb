class HomepageController < ApplicationController
  def index
    @name = params[:name]
    @city = params[:city]
    @country = params[:country]

    @most_viewed_stays = Stay.most_viewed
    @most_viewed_attractions = Attraction.most_viewed

    if @name.present?
      @most_viewed_stays = @most_viewed_stays.where(name: @name)
      @most_viewed_attractions = @most_viewed_attractions.where(name: @name)
    end

    if @city.present?
      @most_viewed_stays = @most_viewed_stays.where(city: @city)
      @most_viewed_attractions = @most_viewed_attractions.where(city: @city)
    end

    if @country.present?
      @most_viewed_stays = @most_viewed_stays.where(country: @country)
      @most_viewed_attractions = @most_viewed_attractions.where(country: @country)
    end
  end
end
