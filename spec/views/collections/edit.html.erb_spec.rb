require 'rails_helper'

RSpec.describe 'collections/edit', type: :view do
  before(:each) do
    @collection = assign(:collection, create(:collection, workspaces: [create(:workspace, name: 'my workspace')]))
  end

  it 'renders the edit collection form' do
    render
    expect(rendered).to have_css 'input[name="collection[name]"]'
    expect(rendered).to have_css 'input[type="submit"]'
  end

  it 'renders the related workspace list' do
    render
    expect(rendered).to have_css 'h4', text: 'Workspaces'
    expect(rendered).to have_css 'li', text: 'my workspace'
  end
end
