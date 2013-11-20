

require 'spec_helper'

feature "Signing up" do
  scenario 'Successful sign up' do
    visit '/'

    click_link 'Sign up'
    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "somepass"
    fill_in 'Password confirmation', with: "somepass"
    click_button "Sign up"

    expect(page).to have_content('You have signed up successfully.')
  end
end