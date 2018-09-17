# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'collections/edit', type: :view do
  let(:user) { create(:user) }
  before do
    assign(:collection, create(:collection, user: user, workspaces: [create(:workspace, name: 'my workspace')]))
    sign_in user
  end

  it 'renders the edit collection form' do
    render
    expect(rendered).to have_css 'input[name="collection[name]"]'
    expect(rendered).to have_css 'input[type="submit"]'
  end

  it 'renders the related workspace list' do
    render
    expect(rendered).to have_css 'h4', text: 'Workspaces'
    expect(rendered).to have_css 'h3 a', text: 'my workspace'
  end
end
