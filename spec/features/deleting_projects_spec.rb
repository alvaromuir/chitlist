

require 'spec_helper'

feature "Deleting projects" do 
  scenario "Deleting a project" do
    FactoryGirl.create(:project, name: "Work Project")

    visit '/'
    click_link 'Work Project'
    click_link 'Delete Project'

    expect(page).to have_content('Project has been destroyed.')

    visit '/'

    expect(page).to have_no_content('Work Project')

  end
end