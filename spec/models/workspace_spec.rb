# frozen_string_literal: true

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
    it "returns the collection's mirador_options as json" do
      subject.data = nil
      subject.data = {}.to_json
    end
  end

  describe 'public/private' do
    it 'has a public? boolean attribute' do
      expect(subject).not_to be_public
      subject.public = true
      expect(subject).to be_public
    end
  end
end
