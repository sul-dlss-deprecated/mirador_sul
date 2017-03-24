require 'rails_helper'

RSpec.describe 'collections/show', type: :view do
  before(:each) do
    @collection = assign(:collection, create(:collection))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to have_css 'h3', text: /My Collection/
  end
end
