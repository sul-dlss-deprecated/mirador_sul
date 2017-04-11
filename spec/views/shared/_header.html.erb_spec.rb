require 'rails_helper'

RSpec.describe 'shared/_header', type: :view do
  it 'shows an alert message' do
    expect(view).to receive_messages(alert: 'Alert')
    render
    expect(rendered).to have_css 'div.messages div.alert-danger.show', text: 'Alert'
    expect(rendered).to have_css 'div.messages div.alert-info.hide'
  end

  it 'shows a notice message' do
    expect(view).to receive_messages(notice: 'Notice')
    render
    expect(rendered).to have_css 'div.messages div.alert-info.show', text: 'Notice'
    expect(rendered).to have_css 'div.messages div.alert-danger.hide'
  end

  it 'shows notice and alert messages' do
    expect(view).to receive_messages(alert: 'Alert')
    expect(view).to receive_messages(notice: 'Notice')
    render
    expect(rendered).to have_css 'div.messages div.alert-danger.show', text: 'Alert'
    expect(rendered).to have_css 'div.messages div.alert-info.show', text: 'Notice'
  end
end
