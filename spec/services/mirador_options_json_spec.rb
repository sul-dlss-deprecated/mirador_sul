require 'rails_helper'

RSpec.describe MiradorOptionsJson, type: :service do
  subject(:mirador_options) { described_class.new(workspace: workspace) }
  let(:workspace) { create(:workspace) }

  describe '#to_json' do
    it 'returns valid json' do
      expect(JSON.parse(mirador_options.to_json).keys).not_to be_blank
    end
  end

  context 'a workspace without persisted data' do
    let(:manifest1) { create(:manifest) }
    let(:manifest2) { create(:manifest) }
    let(:collection) do
      create(:collection, manifests: [manifest1, manifest2])
    end
    let(:workspace) { create(:workspace, data: '', collection: collection) }

    it "includes an inital config with the collection's manifests" do
      json = JSON.parse(mirador_options.to_json)
      expect(json['data'].map { |d| d['manifestUri'] }).to eq([manifest1.url, manifest2.url])
    end
  end

  describe 'merging the user logoLogo' do
    before { workspace.name = 'workspace_title' }
    let(:json) { JSON.parse(mirador_options.to_json) }
    it 'includes the workspace name to the viewer config' do
      expect(json).to have_key 'mainMenuSettings'
      expect(json['mainMenuSettings']).to have_key 'userLogo'
      expect(json['mainMenuSettings']['userLogo']).to have_key 'label'
      expect(json['mainMenuSettings']['userLogo']['label']).to eq('workspace_title')
    end
  end

  describe 'configuring the Save userButton' do
    context 'when a user can update the workspace' do
      it 'the save button remains in the config' do
        expect(mirador_options).to receive_messages(user_can_update_workspace?: true)
        json = JSON.parse(mirador_options.to_json)
        expect(json['mainMenuSettings']['userButtons'].length).to eq 1
        expect(json['mainMenuSettings']['userButtons'].first['label']).to eq 'Save'
      end
    end

    context 'when a user cannot update the workspace' do
      before do
        workspace.data = {
          'mainMenuSettings' => {
            'userButtons' => [{ 'label' => 'Save' }]
          }
        }.to_json
      end
      it 'the save button is removed from the config' do
        json = JSON.parse(mirador_options.to_json)
        expect(json['mainMenuSettings']['userButtons']).to be_blank
      end
    end
  end

  describe 'configuring the annotationEndpoint' do
    it 'is included' do
      json = JSON.parse(mirador_options.to_json)
      expect(json['annotationEndpoint']).to be_present
      expect(json['annotationEndpoint']['name']).to eq 'Storage'
      expect(json['annotationEndpoint']['module']).to eq 'Endpoint'
    end
  end
end
