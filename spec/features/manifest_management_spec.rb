# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Manifest Management', type: :feature do
  before { sign_in user }

  context 'As an owner of a collection' do
    let(:user) { create(:user) }
    let!(:collection) { create(:collection, user: user) }

    scenario 'I should be able to add manifests to collections' do
      visit "/collections/#{collection.id}/edit"

      fill_in 'Manifest URL', with: 'http://example.com/iiif/manifest.json'
      click_button 'Add'

      expect(page).to have_content 'Manifest was successfully created.'
      expect(page).to have_css 'li', text: 'http://example.com/iiif/manifest.json'
    end

    scenario 'I should be able to delete manifests from collections' do
      create(:manifest, user: user, collections: [collection], url: 'http://example.com/iiif/manifest2.json')
      visit "/collections/#{collection.id}/edit"

      expect(page).to have_css 'li', text: 'http://example.com/iiif/manifest2.json'
      click_link 'Destroy'

      expect(page).to have_content('Manifest was successfully destroyed.')
      expect(page).not_to have_css 'li', text: 'http://example.com/iiif/manifest2.json'
    end
  end
end
