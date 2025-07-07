class CommentsController < ApplicationController

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = User.first # À remplacer par current_user plus tard

    if @comment.save
      redirect_to gossip_path(@gossip), notice: "Commentaire ajouté !"
    else
      flash.now[:alert] = "Erreur : commentaire non ajouté."
      render 'gossips/show', status: :unprocessable_entity
    end
  end

  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to gossip_path(@gossip), notice: "Commentaire mis à jour !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.find(params[:id])
    @comment.destroy
    redirect_to gossip_path(@gossip), notice: "Commentaire supprimé !"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
