class WikisController < ApplicationController
  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.author = current_user._id

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def permissions
    @wiki = Wiki.find(params[:id])
    @collaborators = User.all(_id: @wiki.collaborators)
    @author = User.find(_id: @wiki.author)
  end

  def index
    @wikis = Wiki.any_of({author: current_user._id}, {moderators: current_user._id})
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])


    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki, notice: "Wiki was updated successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.subject

    if @wiki.destroy
      flash[:notice] = "\"#{title}\"  was deleted succesfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:subject,:body)
  end

end
