require 'rails_helper'

RSpec.describe 'collections/index', type: :view do
  before(:each) do
    assign(:collections, create_list(:collection, 2))
  end

  it 'renders a list of collections' do
    render
    expect(rendered).to have_css 'td', text: /My Collection/, count: 2
    expect(rendered).to have_css 'a', text: /New Workspace/, count: 2
  end

  it 'renders a links to create workspaces from each collection' do
    render
    expect(rendered).to have_css 'a', text: /New Workspace/, count: 2
  end
end
