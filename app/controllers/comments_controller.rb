class CommentsController < ApplicationController

    def create
        @gossip = Gossip.find(params[:gossip_id])
        @comment = @gossip.comments.build(comment_params)
        @comment.user = User.first # user par défaut

        if @comment.save
            redirect_to gossip_path(@gossip), notice: "Commentaire ajouté !"
        else
            flash.now[:alert] = "Erreur : commentaire non ajouté."
            render 'gossips/show', status: :unprocessable_entity
        end
    end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
