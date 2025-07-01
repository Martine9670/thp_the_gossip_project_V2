class StaticPagesController < ApplicationController

  def home
    @gossips = Gossip.all.includes(:user)
  end

  def team
  end

  def contact
  end

  def welcome
      @first_name = params[:first_name]
  end

end
