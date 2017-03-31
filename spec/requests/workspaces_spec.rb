require 'rails_helper'

RSpec.describe 'Workspaces', type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET /collections/:collection_id/workspaces/new' do
    context 'an authorized user' do
      let(:collection) { create(:collection, user: user) }

      it 'is allowed' do
        get new_collection_workspace_path(collection)
        expect(response).to have_http_status(200)
      end
    end

    context 'an authorized user' do
      let(:collection) { create(:collection) }

      it 'is not allowed' do
        expect do
          get new_collection_workspace_path(collection)
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'GET /workspaces/:id' do
    let(:workspace) { create(:workspace, collection: collection, data: { height: '100px' }.to_json) }
    context 'an authorized user' do
      let(:collection) { create(:collection, user: user) }

      it 'is allowed' do
        get workspaces_path(collection, workspace)
        expect(response).to have_http_status(200)
      end
    end

    context 'an authorized user' do
      let(:collection) { create(:collection) }

      it 'is not allowed' do
        expect do
          get new_collection_workspace_path(collection)
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'POST /collections/:collection_id/manifests' do
    context 'an authorized user' do
      let(:collection) { create(:collection, user: user) }
      it 'is allowed' do
        post collection_workspaces_path(collection_id: collection.id, workspace: { name: 'New Workspace 1' })
        expect(response).to have_http_status(302)
        expect(Workspace.last.name).to eq 'New Workspace 1'
      end
    end

    context 'an anonymous user' do
      let(:collection) { create(:collection) }
      it 'is not allowed' do
        expect do
          post collection_workspaces_path(collection_id: collection.id, workspace: { name: 'does not matter' })
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'DELETE /workspaces/:id' do
    context 'an authorized user' do
      let(:workspace) { create(:workspace, user: user) }
      it 'is allowed' do
        delete workspace_path(workspace)
        expect(response).to have_http_status(302)
      end
    end

    context 'an anonymous user' do
      let(:workspace) { create(:workspace) }
      it 'is not allowed' do
        expect do
          delete workspace_path(workspace)
        end.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
