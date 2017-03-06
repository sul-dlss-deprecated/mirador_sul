RSpec.describe 'routes for sharing', type: :routing do
  context 'collections' do
    it 'shares' do
      expect(get(share_collection_path(1))).to route_to('share/collections#show', id: '1')
    end
    it 'read-only' do
      expect(post(share_collection_path(1))).not_to be_routable
    end
  end
  context 'manifests' do
    it 'shares' do
      expect(get(share_manifest_path(1))).to route_to('share/manifests#show', id: '1')
    end
    it 'read-only' do
      expect(post(share_manifest_path(1))).not_to be_routable
    end
  end
  context 'workspaces' do
    it 'shares' do
      expect(get(share_workspace_path(1))).to route_to('share/workspaces#show', id: '1')
    end
    it 'read-only' do
      expect(post(share_workspace_path(1))).not_to be_routable
    end
  end
end
