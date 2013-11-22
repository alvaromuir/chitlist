

require 'spec_helper'

feature 'Assigning permissions' do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:task) { FactoryGirl.create(:task, project: project, user: user) }

before do
  sign_in_as!(admin)
  click_link 'Admin'
  click_link 'Users'
  click_link user.email
  click_link 'Permissions'
end

scenario 'Viewing a project' do
  check_permission_box 'view', project
  click_button 'Update'
  click_link 'Sign out'
  sign_in_as!(user)
    expect(page).to have_content(project.name)
  end

  scenario "Creating tasks for a project" do
    check_permission_box 'view', project
    check_permission_box 'create_tasks', project
    click_button 'Update'
    click_link 'Sign out'
    sign_in_as!(user)
    click_link project.name
    click_link 'New Task'
    fill_in 'Title', with: "Testing!"
    fill_in 'Description', with: "BDD, TDD it's all good."
    click_button 'Create'
    expect(page).to have_content('Task has been created.')
  end

  scenario "Updating a task for a project" do
    check_permission_box 'view', project
    check_permission_box 'edit_tasks', project
    click_button 'Update'
    click_link 'Sign out'
    sign_in_as!(user)
    click_link project.name
    click_link task.title
    click_link 'Edit Task'
    fill_in 'Title', with: "Even More Testing!"
    click_button 'Update Task'
    expect(page).to have_content('Task has been updated')
  end

  scenario 'Deleting a task for a project' do
    check_permission_box 'view', project
    check_permission_box 'delete_tasks', project
    click_button 'Update'
    click_link 'Sign out'
    sign_in_as!(user)
    click_link project.name
    click_link task.title
    click_link 'Delete Task'
    expect(page).to have_content('Task has been deleted.')
  end
end