require 'rails_helper'

RSpec.describe MiradorOptionsJson do
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
end
