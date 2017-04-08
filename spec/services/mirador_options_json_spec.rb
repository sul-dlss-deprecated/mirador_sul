require 'rails_helper'

RSpec.describe MiradorOptionsJson do
  subject(:mirador_options) { described_class.new(workspace: workspace) }
  let(:workspace) { create(:workspace) }

  describe '#to_json' do
    it 'returns the workspace options' do
      expect(mirador_options.to_json).to eq workspace.mirador_options
    end
  end

  context 'a new workspace' do
    let(:manifest1) { create(:manifest) }
    let(:manifest2) { create(:manifest) }
    let(:collection) do
      create(:collection, manifests: [manifest1, manifest2])
    end
    let(:workspace) { build(:workspace, collection: collection) }

    it "includes the collection's manifests" do
      json = JSON.parse(mirador_options.to_json)
      expect(json['data'].map { |d| d['manifestUri'] }).to eq([manifest1.url, manifest2.url])
    end
  end
end
