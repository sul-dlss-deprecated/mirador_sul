class WorkspacesController < ApplicationController
  load_and_authorize_resource :collection
  load_and_authorize_resource :workspace, through: :collection

  # GET /collections/:collection_id/workspaces/new
  def new; end

  def show; end

  # POST /collections/:collection_id/workspaces
  def create
    @workspace.collection = @collection

    if @workspace.save
      redirect_to [@collection, @workspace], notice: t('workspaces.create')
    else
      redirect_to @collection, alert: t('workspaces.create_error')
    end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:data, :name)
  end
end
