class GossipsController < ApplicationController
  def index
    @gossips = Gossip.includes(:user, :comments).all
  end

  def show
    @gossip = Gossip.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    if @gossip.save
      redirect_to gossip_path(@gossip), notice: "Potin créé avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(gossip_params)
      redirect_to gossip_path(@gossip), notice: "Potin mis à jour avec succès !"
    else
      flash.now[:alert] = "La mise à jour a échoué. Veuillez corriger les erreurs."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path, notice: "Potin supprimé avec succès !"
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, :user_id)
  end
end


