require 'rails_helper'

RSpec.describe WorkspacesController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/collections/1/workspaces/new').to route_to('workspaces#new', collection_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/collections/1/workspaces/2').to route_to('workspaces#show', collection_id: '1', id: '2')
    end

    it 'routes to #create' do
      expect(post: '/collections/1/workspaces').to route_to('workspaces#create', collection_id: '1')
    end
  end
end
