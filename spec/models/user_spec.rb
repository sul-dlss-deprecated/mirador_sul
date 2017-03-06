require 'rails_helper'

RSpec.describe User, type: :model do
  let(:n) { 100 }
  context 'generic user' do
    let(:subject) { create(:user) }

    it 'computes password digest' do
      subject.password_digest = nil
      subject.password = 'something-password-like'
      expect(subject.password_digest).to match(/.+/) # autosets
    end

    it 'only accepts controlled vocab for source' do
      %w(local sunetid).each do |s|
        subject.source = s
        expect(subject.valid?).to be_truthy
      end
      subject.source = 'bad-value'
      expect(subject.valid?).to be_falsy
    end

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
      before(:each) do
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
end
