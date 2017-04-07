require 'rails_helper'

RSpec.describe 'Collection management', type: :feature do
  before { sign_in user }

  context 'As an owner of a collection' do
    let(:user) { create(:user) }
    let(:collection) { create(:collection, user: user) }

    scenario 'I can edit/update an existing collection' do
      visit "/collections/#{collection.id}/edit"

      fill_in 'Name', with: 'Updated Collection Name'
      fill_in 'Description', with: 'Updated Collection Description'

      click_button 'Update Collection'

      collection.reload

      expect(collection.name).to eq 'Updated Collection Name'
      expect(collection.description).to eq 'Updated Collection Description'
    end
  end
end
