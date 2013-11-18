

require 'spec_helper'

feature 'Creating Projects' do
  scenario "can create a project" do
    visit '/'
    
    click_link 'New Project'
    
    fill_in 'Name', with: 'Work Project'
    fill_in 'Description', with: 'Some project for work'
    click_button 'Create Project'
    
    expect(page).to have_content('Project has been created.')
  end
end