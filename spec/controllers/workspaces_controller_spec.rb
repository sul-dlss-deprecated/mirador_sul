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

  describe 'GET #index' do
    context 'a user with collections' do
      it 'lists all their collections' do
        2.times { create(:workspace, user: user) }

        get :index
        expect(assigns(:workspaces).length).to eq 2
      end
    end

    context 'a user without collections' do
      it 'does not list public collections' do
        2.times { create(:workspace, public: true) }

        get :index
        expect(assigns(:workspaces).length).to eq 0
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested workspace as @workspace' do
      workspace = Workspace.create! valid_params
      get :show, params: { id: workspace.to_param }
      expect(assigns(:workspace)).to eq(workspace)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested workspace as @workspace' do
      workspace = Workspace.create! valid_params
      get :edit, params: { id: workspace.to_param }
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

  describe 'PUT #update' do
    let(:workspace) { Workspace.create! valid_params }
    context 'with valid params' do
      it 'updates the requested workspace' do
        put :update, params: {
          id: workspace.id,
          workspace: valid_params.merge(
            name: 'New Workspace Name',
            description: 'New Workspace Description',
            public: 'true'
          )
        }

        workspace.reload
        expect(workspace.name).to eq 'New Workspace Name'
        expect(workspace.description).to eq 'New Workspace Description'
        expect(workspace).to be_public
      end

      context 'json request' do
        it 'renders the workspace as json' do
          put :update, params: { id: workspace.id, workspace: valid_params, format: :json }

          response_hash = JSON.parse(response.body)
          expect(response_hash['id']).to eq workspace.id
          expect(response_hash['name']).to eq workspace.name
        end
      end

      context 'html request' do
        it 'redirects to the workspace with a flash notice' do
          put :update, params: { id: workspace.id, workspace: valid_params }

          expect(response).to redirect_to workspace
          expect(flash[:notice]).to eq 'Workspace successfully updated.'
        end
      end
    end

    context 'with invalid params' do
      it 'is not successfull' do
        put :update, params: { id: workspace.id, workspace: invalid_params }

        expect(response).not_to be_success
      end

      context 'json request' do
        it 'renders a json status' do
          put :update, params: { id: workspace.id, workspace: invalid_params, format: :json }

          response_hash = JSON.parse(response.body)
          expect(response_hash['status']).to eq 'error'
        end
      end

      context 'html request' do
        it 'redirects to the workspace with a flash alert' do
          put :update, params: { id: workspace.id, workspace: invalid_params }

          expect(response).to redirect_to workspace
          expect(flash[:alert]).to eq 'There was a problem updating the workspace.'
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested workspace' do
      workspace = Workspace.create! valid_params
      expect do
        delete :destroy, params: { id: workspace.to_param }
      end.to change(Workspace, :count).by(-1)
    end

    it 'redirects to the workspaces list' do
      workspace = Workspace.create! valid_params
      delete :destroy, params: { id: workspace.to_param }
      expect(response).to redirect_to(workspaces_url)
    end
  end
end
