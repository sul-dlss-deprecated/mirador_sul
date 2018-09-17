# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'collections/_collection', type: :view do
  let(:collection) { create(:collection, description: 'description') }
  before do
    expect(view).to receive(:collection).at_least(:once).and_return(collection)
  end

  it 'renders action links for the collection' do
    render
    expect(rendered).to have_link('Edit collection')
    expect(rendered).to have_link('Create workspace from this collection')
    expect(rendered).to have_link('Destroy collection')
  end

  it 'renders a heading link to view the collection' do
    render
    expect(rendered).to have_css('h2 a', text: collection.name)
  end

  it 'renders a paragraph with the description of the collection' do
    render
    expect(rendered).to have_css('p', text: collection.description)
  end

  it 'renders a paragraph with no description if none is given' do
    collection.description = nil
    render
    expect(rendered).to have_css('h2 a')
    expect(rendered).not_to have_css('p')
  end

  it 'renders the number of workspaces assocated with the collection' do
    create_list(:workspace, 3, collection: collection)
    render
    expect(rendered).to have_content('3 workspaces created from this collection')
  end
end
