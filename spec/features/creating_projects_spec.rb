
require 'spec_helper'

feature 'Creating Projects' do
  scenario "can create a project" do
    visit '/'
    
    click_link 'New Project'
    
    fill_in 'Name', with: 'Work Project'
    fill_in 'Description', with: 'Some project for work'
    click_button 'Create Project'
    
    expect(page).to have_content('Project has been created.')
  
    project = Project.where(name: "Work Project").first

    expect(page.current_url).to eql(project_url(project))

    title = "Work Project - Projects - Chitlist"
    expect(page).to have_title(title)

  end
end