##
# Controller used for a user's collection
class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /collections
  def index
    @collections = Collection.accessible_by(current_ability)
  end

  # GET /collections/1
  def show; end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit; end

  # POST /collections
  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user

    if @collection.save
      redirect_to @collection, notice: t('collections.create')
    else
      render :new
    end
  end

  # PATCH/PUT /collections/1
  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: t('collections.update')
    else
      render :edit
    end
  end

  # DELETE /collections/1
  def destroy
    @collection.destroy
    redirect_to collections_url, notice: t('collections.destroy')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collection
    @collection = Collection.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def collection_params
    params.require(:collection).permit(:description, :name, manifests_attributes: [:url])
  end
end
