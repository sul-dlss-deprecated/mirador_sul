# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection, type: :model do
  let(:n) { 100 }
  let(:subject) { create(:collection) }

  it 'links to a user' do
    expect(subject.user).to be_a(User)
  end

  describe 'scopes' do
    describe 'default' do
      it 'orders by the created date so that the most recently created are first' do
        old_collection = create(:collection, created_at: Time.zone.today - 1.day)
        new_collection = create(:collection)
        all_collections = described_class.all

        expect(all_collections.first).to eq new_collection
        expect(all_collections.last).to eq old_collection
      end
    end
  end

  context 'with many manifests' do
    before do
      (1..n).each { subject.manifests << create(:manifest) }
    end

    it 'holds them' do
      expect(subject.manifests.length).to eq(n)
    end

    it 'surfaces as the users library' do
      expect(subject.user.manifests.length).to eq(n)
    end
  end

  context 'with many workspaces' do
    before do
      (1..n).each { create(:workspace, collection: subject) }
    end

    it 'holds them' do
      expect(subject.workspaces.length).to eq(n)
    end

    it 'caches a count of them' do
      expect(subject.workspaces_count).to eq(n)
    end
  end
end
