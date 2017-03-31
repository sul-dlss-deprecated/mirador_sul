require 'rails_helper'

RSpec.describe Collection, type: :model do
  let(:n) { 100 }
  let(:subject) { create(:collection) }

  it 'links to a user' do
    expect(subject.user).to be_a(User)
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
    it 'has the configured height' do
      expect(subject.mirador_options[:height]).to eq '600px'
    end

    it 'has the associated manifestUri in the data options' do
      3.times.each { subject.manifests << create(:manifest) }

      data_options = subject.mirador_options[:options][:data]
      data_options.each do |data|
        expect(data[:manifestUri]).to match %r{example.com/iiif/\d*/manifest.json}
      end
    end
  end
end
