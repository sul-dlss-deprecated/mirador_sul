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
        expect(JSON.parse(data)).to have_key('height')
        expect(JSON.parse(data)).to have_key('options')
      end

      it 'returns the correct data when persisted' do
        expect(subject.data).to be_a String
        expect(JSON.parse(subject.data)).to have_key('some_json_data')
      end
    end
  end

  describe '#mirador_options' do
    it 'parses the json string into a hash' do
      expect(subject.mirador_options).to be_a Hash
    end

    it 'deep symbolizes the keys' do
      subject.data = { 'abc' => { 'xyz' => 'def' } }.to_json

      expect(subject.mirador_options).to have_key(:abc)
      expect(subject.mirador_options[:abc]).to have_key(:xyz)
    end
  end
end
