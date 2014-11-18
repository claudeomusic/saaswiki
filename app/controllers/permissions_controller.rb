class PermissionsController < ApplicationController
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @author_id = @wiki.author
    @author = User.find(@wiki.author)

    #collaborators
    if @wiki.collaborators
      @collaborators = User.find(@wiki.collaborators)
    else
      @collaborators = nil
    end

    #non-collaborators AKA users
    @exclude_list = @wiki.collaborators
    if !@exclude_list
      @exclude_list = @author_id
    else
      @exclude_list << @author_id
    end

    @excluded_users = User.not.in(_id: @exclude_list)

  end

end
