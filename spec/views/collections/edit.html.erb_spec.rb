require 'rails_helper'

RSpec.describe 'collections/edit', type: :view do
  before(:each) do
    @collection = assign(:collection, create(:collection))
  end

  it 'renders the edit collection form' do
    render
    expect(rendered).to have_css 'input[name="collection[name]"]'
    expect(rendered).to have_css 'input[type="submit"]'
  end
end
