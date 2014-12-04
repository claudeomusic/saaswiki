class WikisController < ApplicationController

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki

    if(wiki_params[:privacy] == 1)
      @wiki.privacy = "Private"
    end

    @wiki.author_id = current_user._id

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def index
    @wikis = Wiki.any_of({author_id: current_user._id}, {collaborators: current_user._id})
    authorize @wikis
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki


    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki, notice: "Wiki was updated successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    params.require(:wiki).permit(:subject,:body,:privacy)
  end

end
