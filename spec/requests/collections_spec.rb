# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collections', type: :request do
  describe 'GET /collections' do
    it 'requires authorization' do
      get collections_path
      expect(response).to have_http_status(302)
    end
    it 'only shows users collections' do
      user = create(:user)
      create_list(:collection, 5)
      create_list(:collection, 2, user: user)
      sign_in user
      get collections_path
      expect(assigns(:collections).count).to eq 2
    end
  end
end
