class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all.includes(:user)
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
    redirect_to @gossip, notice: "Potin créé avec succès"
  else
    @tags = Tag.all
    puts @gossip.errors.full_messages # ← ajoute ça pour afficher les erreurs en console
    render :new
  end
end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, :user_id)
  end
end


