require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  it 'return true if in edit action' do
    expect(helper).to receive_messages(action_name: 'edit')
    expect(helper.in_edit_mode).to be true
  end

  it 'return false if not in edit action' do
    expect(helper.in_edit_mode).to be false
  end
end
