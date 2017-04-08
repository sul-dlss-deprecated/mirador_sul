require 'rails_helper'

RSpec.describe Workspace, type: :model do
  let(:subject) { create(:workspace) }
  let(:collection) { create(:collection) }

  it 'links to a collection' do
    expect(subject.collection).to be_a(Collection)
  end

  it 'holds JSON data' do
    expect { JSON.parse(subject.data) }.not_to raise_error
  end

  describe '#data' do
    context 'when the workspace is not persisted' do
      it "returns the collection's mirador_options as json" do
        data = Workspace.new(collection: collection).data
        expect(data).to be_a String
        expect(JSON.parse(data)).to have_key('id')
        expect(JSON.parse(data)).to have_key('data')
      end

      it 'returns the correct data when persisted' do
        expect(subject.data).to be_a String
        expect(JSON.parse(subject.data)).to have_key('some_json_data')
      end
    end
  end

  describe 'public/private' do
    it 'has a public? boolean attribute' do
      expect(subject).not_to be_public
      subject.public = true
      expect(subject).to be_public
    end
  end

  describe '#mirador_options' do
    it 'includes original configuration keys' do
      subject.data = { a: :b }.to_json
      expect(JSON.parse(subject.mirador_options)).to have_key 'a'
    end
    it 'merges in the userLogo options for custom title' do
      subject.name = 'workspace_title'
      parsed_json = JSON.parse(subject.mirador_options)
      expect(parsed_json).to have_key 'mainMenuSettings'
      expect(parsed_json['mainMenuSettings']).to have_key 'userLogo'
      expect(parsed_json['mainMenuSettings']['userLogo']).to have_key 'label'
      expect(parsed_json['mainMenuSettings']['userLogo']['label']).to eq('workspace_title')
    end
  end
end
