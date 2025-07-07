class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    # Tous les potins écrits par les utilisateurs de cette ville
    @gossips = Gossip.joins(:user).where(users: { city_id: @city.id })
  end
end
