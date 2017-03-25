require 'rails_helper'

RSpec.describe ManifestsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/collections/1/manifests').to route_to('manifests#create', collection_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/collections/1/manifests/1').to route_to('manifests#destroy', collection_id: '1', id: '1')
    end
  end
end
