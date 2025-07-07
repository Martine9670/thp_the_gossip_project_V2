class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    likeable = find_likeable
    like = likeable.likes.new(user: current_user)

    if like.save
      redirect_back fallback_location: root_path, notice: "Tu as liké !"
    else
      redirect_back fallback_location: root_path, alert: "Tu as déjà liké."
    end
  end

  def destroy
    likeable = find_likeable
    like = likeable.likes.find_by(user: current_user)
    like&.destroy
    redirect_back fallback_location: root_path, notice: "Like retiré."
  end

  private

  def find_likeable
    # Trouve la ressource likeable (gossip ou comment) selon les params
    if params[:gossip_id]
      Gossip.find(params[:gossip_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    else
      raise "Likeable not found"
    end
  end
end
