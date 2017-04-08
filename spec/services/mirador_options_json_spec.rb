require 'rails_helper'

RSpec.describe MiradorOptionsJson do
  subject(:mirador_options) { described_class.new(workspace: workspace) }
  let(:workspace) { create(:workspace) }

  describe '#to_json' do
    it 'returns the workspace options' do
      expect(mirador_options.to_json).to eq workspace.mirador_options
    end
  end
end
