class WorkspacesController < ApplicationController
  load_and_authorize_resource :collection, except: [:index, :show]
  load_and_authorize_resource :workspace, through: :collection, except: [:index, :show]

  load_and_authorize_resource :workspace, only: [:index, :show]

  # GET /workspaces
  def index; end

  # GET /collections/:collection_id/workspaces/new
  def new; end

  # GET /workspaces/:id
  def show; end

  # POST /collections/:collection_id/workspaces
  def create
    @workspace.collection = @collection
    @workspace.user = current_user

    if @workspace.save
      redirect_to @workspace, notice: t('workspaces.create')
    else
      redirect_to @collection, alert: t('workspaces.create_error')
    end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:data, :name)
  end
end
