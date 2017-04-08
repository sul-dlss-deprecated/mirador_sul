require 'rails_helper'

RSpec.describe 'workspaces/edit', type: :view do
  before do
    assign(:workspace, create(:workspace))
  end

  it 'renders a heading' do
    render
    expect(rendered).to have_css('h1', text: 'Editing Workspace')
  end

  it 'renders the edit workspace form' do
    render
    expect(rendered).to have_css 'input[name="workspace[name]"]'
    expect(rendered).to have_css 'input[name="workspace[public]"][type="checkbox"]'
    expect(rendered).to have_css 'input[type="submit"]'
  end
end
