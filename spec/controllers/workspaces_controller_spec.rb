require 'rails_helper'

RSpec.describe WorkspacesController, type: :controller do
  let(:user) { create(:user) }
  let(:collection) { create(:collection, user: user) }
  before { sign_in user }

  let(:valid_params) { { name: 'Workspace1', collection: collection, user: user } }
  let(:invalid_params) { { name: nil } }

  describe 'GET #new' do
    it 'assigns a the workspace as @workspace' do
      get :new, params: { collection_id: collection.id }
      expect(assigns(:workspace)).to be_a_new(Workspace)
    end
    it 'assigns a the collection as @collection' do
      get :new, params: { collection_id: collection.id }
      expect(assigns(:collection)).to be_a(Collection)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested workspace as @workspace' do
      workspace = Workspace.create! valid_params
      get :show, params: { id: workspace.to_param }
      expect(assigns(:workspace)).to eq(workspace)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'assigns the collection as @collection' do
        post :create, params: { collection_id: collection.id, workspace: valid_params }
        expect(assigns(:collection)).to be_a(Collection)
      end

      it 'assigns the workspace as @workspace and sets the collection relationship' do
        post :create, params: { collection_id: collection.id, workspace: valid_params }
        expect(assigns(:workspace)).to be_a(Workspace)
        expect(assigns(:workspace).collection).to eq collection
      end

      it 'sets a flash notice' do
        post :create, params: { collection_id: collection.id, workspace: valid_params }

        expect(flash[:notice]).to eq 'Workspace was successfully created.'
      end
    end

    context 'with invalid params' do
      it 'redirects with an alert' do
        post :create, params: { collection_id: collection.id, workspace: invalid_params }

        expect(response).to redirect_to(collection)
        expect(flash[:alert]).to eq 'There was a problem creating the workspace.'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested workspace' do
      workspace = Workspace.create! valid_params
      expect {
        delete :destroy, params: {id: workspace.to_param}
      }.to change(Workspace, :count).by(-1)
    end

    it 'redirects to the workspaces list' do
      workspace = Workspace.create! valid_params
      delete :destroy, params: {id: workspace.to_param}
      expect(response).to redirect_to(workspaces_url)
    end
  end
end
