class PublicController < ApplicationController
  def index
    @wikis = Wiki.where(privacy: "Public")

    if current_user
      @wikis = Wiki.any_of({author_id: current_user._id}, {collaborators: current_user._id}, {privacy: "Public"})
    end
    
    authorize @wikis

  end
end
