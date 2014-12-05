class PermissionsController < ApplicationController
  respond_to :html, :js
  def index
    @wiki = Wiki.find(params[:wiki_id])

    authorize @wiki

    @author_id = @wiki.author_id
    @author = User.find(@wiki.author_id)

    #collaborators
    if @wiki.collaborators
      @collaborators = User.find(@wiki.collaborators)
    else
      @collaborators = nil
    end

    @autocomplete_items = User.all
  end

  def add_user
    @wiki = Wiki.find(params[:wiki])
    authorize @wiki
    success = false

    if User.where(username: params[:collaborator]).exists?
      user_id = User.find_by(username: params[:collaborator])._id
      @user = User.find_by(username: params[:collaborator])

      if user_id != @wiki.author_id && @wiki.collaborators.exclude?(user_id)
        @wiki.push(collaborators: user_id)
        success = true
      end
    end

    if success
      respond_with(@wiki) do |format|
        format.html { redirect_to wiki_permissions_path }
      end
    else
      redirect_to wiki_permissions_path
    end
  end

  def remove_collaborator
    @wiki = Wiki.find(params[:wiki])
    @user = User.find(params[:user])
    authorize @wiki
    user_id = @user._id
    if @wiki.collaborators.include?(user_id)
      @wiki.pop(collaborators: user_id)
      respond_with(@wiki) do |format|
        format.html { redirect_to wiki_permissions_path }
      end
    end
  end


end
