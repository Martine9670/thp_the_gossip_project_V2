class GossipsController < ApplicationController
  before_action :require_login
  before_action :set_gossip, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @gossips = Gossip.includes(:user, :comments).all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
    @tags = Tag.all
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user
    
    if @gossip.save
      redirect_to gossip_path(@gossip), notice: "Potin créé avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @gossip.update(gossip_params)
      redirect_to gossip_path(@gossip), notice: "Potin mis à jour avec succès !"
    else
      flash.now[:alert] = "La mise à jour a échouée. Veuillez corriger les erreurs."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip.destroy
    redirect_to root_path, notice: "Potin supprimé avec succès !"
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content, :user_id, tag_ids: [])
  end

  def authorize_user!
    unless @gossip.user == current_user
      flash[:error] = "Tu n'es pas autorisé à modifier ce potin."
      redirect_to gossips_path
    end
  end
end
