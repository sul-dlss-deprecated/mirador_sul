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
        all_collections = Collection.all

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
      (1..n).each { subject.workspaces << create(:workspace) }
    end

    it 'holds them' do
      expect(subject.workspaces.length).to eq(n)
    end
  end

  describe '#mirador_options' do
    it 'has the associated manifestUri in the data options' do
      3.times.each { subject.manifests << create(:manifest) }

      data_options = subject.mirador_options[:data]
      data_options.each do |data|
        expect(data[:manifestUri]).to match %r{example.com/iiif/\d*/manifest.json}
      end
    end

    it 'sets up a Save button in the mainmenu' do
      user_buttons = subject.mirador_options[:mainMenuSettings][:userButtons]
      expect(user_buttons[0][:label]).to eq 'Save'
    end

    it 'forces the load window to open' do
      expect(subject.mirador_options[:openManifestsPage]).to be true
    end
  end
end
