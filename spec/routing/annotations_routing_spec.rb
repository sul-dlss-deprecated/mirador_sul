require 'rails_helper'

RSpec.describe AnnotationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/annotations').to route_to(controller: 'annotations', action: 'index', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/annotations').to route_to(controller: 'annotations', action: 'create', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: '/annotations/1').to route_to(controller: 'annotations', action: 'destroy', id: '1', format: :json)
    end
  end
end
