require 'rails_helper'

RSpec.feature 'Workspace Management', type: :feature do
  before { sign_in user }

  context 'As an owner of a collection' do
    let(:user) { create(:user) }
    let(:manifest1) { create(:manifest) }
    let(:manifest2) { create(:manifest) }
    let(:manifests) { [manifest1, manifest2] }
    let(:collection) { create(:collection, user: user, manifests: manifests) }

    before { sign_in(user) }

    scenario 'I can create a new workspace from a collection' do
      visit "/collections/#{collection.id}"

      click_link 'New Workspace'

      fill_in 'Name', with: 'My New Workspace'
      click_button 'Create Workspace'

      expect(Workspace.last.name).to eq 'My New Workspace'
    end

    scenario 'I can view a workspace (with mirador instance)' do
      url = 'http://manifest-host/iiif/manifest.json'
      workspace = create(:workspace, collection: collection, data: {
        options: { data: [url] }
      }.to_json, user: user)
      visit "/workspaces/#{workspace.id}"

      expect(page).to have_css('script', visible: false, text: /Mirador/)
      expect(page).to have_css('script', visible: false, text: /#{url}/)
    end

    scenario 'I can edit/update an existing workspace' do
      workspace = create(:workspace, user: user)

      visit "/workspaces/#{workspace.id}/edit"

      fill_in 'Name', with: 'Updated Workspace Name'

      click_button 'Update Workspace'

      workspace.reload
      expect(workspace.name).to eq 'Updated Workspace Name'
    end

    scenario 'I can destroy a workspace' do
      url = 'http://manifest-host/iiif/manifest.json'
      create(:workspace, collection: collection, data: {
        options: { data: [url] }
      }.to_json, user: user)
      visit '/workspaces'

      click_link 'Destroy'

      expect(page).to_not have_css 'a', text: 'Destroy'
    end
  end
end
