class ManifestsController < ApplicationController
  before_action :set_manifest, only: :destroy
  load_and_authorize_resource :collection
  load_and_authorize_resource :manifest, through: :collection

  # POST /collections/:collection_id/manifests
  def create
    @manifest = Manifest.new(manifest_params)
    @manifest.collections << @collection
    @manifest.user = current_user

    if @manifest.save
      redirect_to edit_collection_path(@collection), notice: t('manifests.create')
    else
      redirect_to @collection, alert: t('manifests.create_error')
    end
  end

  # DELETE /collections/:collection_id/manifests/1
  def destroy
    @manifest.destroy
    redirect_to @collection, notice: t('manifests.destroy')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_manifest
    @manifest = Manifest.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def manifest_params
    params.require(:manifest).permit(:url)
  end
end
