require 'rails_helper'

RSpec.describe 'collections/new', type: :view do
  before(:each) do
    assign(:collection, build(:collection))
  end

  it 'renders new collection form' do
    render

    expect(rendered).to have_css 'input[name="collection[name]"]'
    expect(rendered).to have_css 'input[type="submit"]'
  end
end
