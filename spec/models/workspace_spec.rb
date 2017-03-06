require 'rails_helper'

RSpec.describe Workspace, type: :model do
  let(:subject) { create(:workspace) }

  it 'links to a collection' do
    expect(subject.collection).to be_a(Collection)
  end

  it 'holds JSON data' do
    expect { JSON.parse(subject.data) }.not_to raise_error
  end
end
