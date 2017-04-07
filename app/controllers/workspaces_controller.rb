class WorkspacesController < ApplicationController
  load_and_authorize_resource :collection, except: [:index, :show, :destroy, :edit, :update]
  load_and_authorize_resource :workspace, through: :collection, except: [:index, :show, :destroy, :edit, :update]

  load_and_authorize_resource :workspace, only: [:index, :show, :destroy, :edit, :update]

  # GET /workspaces
  def index; end

  # GET /collections/:collection_id/workspaces/new
  def new; end

  # GET /workspaces/:id
  def show; end

  # GET /workspaces/:id/edit
  def edit; end

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

  # PATCH/PUT /workspace/:id
  def update
    respond_to do |format|
      if @workspace.update(workspace_params)
        format.html { redirect_to @workspace, notice: t('workspaces.update') }
        format.json { render json: @workspace, status: :ok }
      else
        format.html { redirect_to @workspace, alert: t('workspaces.update_error') }
        format.json { render json: { status: :error }, status: :bad_request }
      end
    end
  end

  # DELETE /workspaces/:id
  def destroy
    @workspace.destroy
    redirect_to workspaces_url, notice: t('collections.destroy')
  end

  private

  def workspace_params
    params.require(:workspace).permit(:data, :name)
  end
end
