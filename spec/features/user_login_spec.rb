require 'rails_helper'

RSpec.feature 'User creation/login', :type => :feature do
  scenario 'A new user can create an account' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(User.last.email).to eq 'test@example.com'
  end
  scenario 'An existing user can login' do
    create(:user, email: 'yolo@example.com')
    visit user_session_path

    fill_in 'Email', with: 'yolo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(User.last.sign_in_count).to eq 1
  end
end
