require 'rails_helper'

RSpec.describe Manifest, type: :model do
  let(:subject) { create(:manifest) }

  it 'requires non-nil url' do
    expect(subject.valid?).to be_truthy
    subject.url = nil
    expect(subject.valid?).to be_falsey
  end

  it 'links to a user' do
    expect(subject.user).to be_a(User)
  end
end
