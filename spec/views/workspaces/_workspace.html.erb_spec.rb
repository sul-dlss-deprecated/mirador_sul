# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workspaces/_workspace', type: :view do
  let(:user) { create(:user) }
  let(:workspace) { create(:workspace, user: user) }
  let(:long_description) do
    <<-STR.strip_heredoc
      Bacon ipsum dolor amet tail alcatra pastrami pork pig t-bone short ribs. Cupim shankle alcatra turkey swine tenderloin prosciutto hamburger bacon. Pork chop turducken kevin bresaola strip steak capicola ground round prosciutto short ribs tenderloin. Drumstick pancetta flank, venison biltong short ribs ham turducken.
    STR
  end
  before do
    expect(view).to receive_messages(workspace: workspace)
    sign_in user
  end

  it 'truncates long descriptions (and includes the value in an alt)' do
    workspace.description = long_description
    render

    expect(rendered).to have_content('Bacon ipsum dolor amet tail alcatra') # Text start
    expect(rendered).to have_content('Pork chop turducken kevin...') # Truncated text end
    expect(rendered).not_to have_content('short ribs ham turducken') # Text that is truncated

    expect(rendered).to have_css('p[title^="Bacon ipsum"]')
  end

  context 'an owner of the workspace' do
    it 'can see links to to edit/destroy the workspace' do
      render
      expect(rendered).to have_css('a', text: /Edit workspace/)
      expect(rendered).to have_css('a', text: /Delete workspace/)
    end
  end

  context 'as a non-owner of the workspace' do
    let(:workspace) { create(:workspace) }
    it 'cannot see links to to edit/destroy the workspace' do
      render
      expect(rendered).not_to have_css('a', text: /Edit workspace/)
      expect(rendered).not_to have_css('a', text: /Delete workspace/)
    end
  end
end
