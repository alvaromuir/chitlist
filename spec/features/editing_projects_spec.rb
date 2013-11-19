

require 'spec_helper'

feature "Editing Projects" do
  before do
    FactoryGirl.create(:project, name: "Work Project")

    visit '/'
    click_link 'Work Project'
    click_link 'Edit Project'
  end

  scenario 'Updating a project' do
    fill_in "Name", with: "Work Project 2"
    click_button 'Update Project'

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes is bad" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")
  end
end