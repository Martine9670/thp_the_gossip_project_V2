class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @gossips = @tag.gossips
  end
end
