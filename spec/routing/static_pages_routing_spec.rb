require 'rails_helper'

RSpec.describe 'Static page routing', type: :routing do
  describe 'Home page' do
    it { expect(get('/')).to route_to 'high_voltage/pages#show', id: 'home' }
    it { expect(get('/home')).to route_to 'high_voltage/pages#show', id: 'home' }
  end

  describe 'about-iiif page' do
    it { expect(get('/about-iiif')).to route_to 'high_voltage/pages#show', id: 'about-iiif' }
  end
end
