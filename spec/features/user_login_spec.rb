require 'rails_helper'

RSpec.feature 'User creation/login', type: :feature do
  scenario 'A new user can create an account' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(User.last.email).to eq 'test@example.com'
  end
  scenario 'An existing user can login and logout' do
    create(:user, email: 'yolo@example.com')
    visit root_path
    click_link 'Log in'

    fill_in 'Email', with: 'yolo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(User.last.sign_in_count).to eq 1
    expect(page).to have_link 'Log out'

    click_link 'Log out'
    expect(page).to have_link 'Log in'
  end
  scenario 'After login, user is taken to the collections view' do
    create(:user, email: 'yolo@example.com')
    visit root_path
    click_link 'Log in'

    fill_in 'Email', with: 'yolo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(current_path).to eql(collections_path)
  end
end
