


require 'spec_helper'

feature "Editing tasks" do 
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:task) { FactoryGirl.create(:task, project: project, user: user) }

  before do
    define_permission!(user, "view", project)
    define_permission!(user, "edit tasks", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link task.title
    click_link 'Edit Task'
  end

  scenario "Updating a task" do
    fill_in 'Title', with: "Rework the entire project"
    click_button 'Update Task'

    expect(page).to have_content "Task has been updated."

    within('#task h2') do
      expect(page).to have_content('Rework the entire project')
    end

    expect(page).to_not have_content task.title
  end

  scenario "Updating a task with invaliid information" do
    fill_in 'Title', with: ""
    click_button 'Update Task'

    expect(page).to have_content('Task has not been updated.')
  end
end