# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workspaces/show', type: :view do
  let(:collection) { create(:collection) }
  let(:workspace) { create(:workspace, collection: collection, data: {}.to_json) }
  before do
    assign(:collection, collection)
    assign(:workspace, workspace)
    render
  end

  it 'renders a mirador script tag' do
    expect(rendered).to have_css('script', text: /Mirador/, visible: :hidden)
  end
end
