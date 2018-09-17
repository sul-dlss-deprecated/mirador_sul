# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:n) { 100 }
  context 'generic user' do
    let(:subject) { create(:user) }

    context 'with many collections' do
      before do
        (1..n).each do |_i|
          subject.collections << create(:collection)
        end
      end

      it 'holds them' do
        expect(subject.collections.length).to eq(n)
      end
    end

    context 'with many manifests' do
      before do
        subject.collections << create(:collection)
        (1..n).each do |_i|
          subject.collections.first.manifests << create(:manifest)
        end
      end

      it 'holds them' do
        expect(subject.manifests.length).to eq(n)
      end
      it 'removes duplicates' do
        # create a clone of the first collection
        collection = create(:collection)
        collection.manifests = subject.collections.first.manifests
        subject.collections << collection

        expect(subject.manifests.length).to eq(n)
      end
      it 'is read-only' do
        expect { subject.manifests << create(:manifest) }.to raise_error(ActiveRecord::HasManyThroughNestedAssociationsAreReadonly)
      end
    end
  end

  context 'user from local database' do
    let(:subject) { create(:user_local) }

    it 'valid and source is local' do
      expect(subject.valid?).to be_truthy
      expect(subject.source).to eq('local')
    end
  end

  context 'user from stanford database' do
    let(:subject) { create(:user_stanford) }

    it 'valid and source is sunetid' do
      expect(subject.valid?).to be_truthy
      expect(subject.source).to eq('sunetid')
    end
  end

  context 'user with sample data' do
    let(:subject) { create(:user_sample_data) }

    it 'valid and source is sample' do
      expect(subject.valid?).to be_truthy
      expect(subject.source).to eq('sample')
    end

    it 'has collections and manifests' do
      samples = JSON.parse(File.read('config/sample_data.json')).deep_symbolize_keys
      expect(subject.collections.size).to eq(samples.length)
      expect(subject.manifests.size).to eq(samples.values.map { |col| col[:manifests].length }.sum)
    end
  end
end
