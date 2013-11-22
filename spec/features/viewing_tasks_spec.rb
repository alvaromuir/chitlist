

require 'spec_helper'

feature "Viewing tasks" do
  before do
    user = FactoryGirl.create(:user)

    project1 = FactoryGirl.create(:project, name: "Project 1")
    task = FactoryGirl.create(:task,
      project: project1,
      title: "Example Task 1",
      description: "A very long and detailed description for Example Task 1.")
    task.update(user: user)
    define_permission!(user, "view", project1)

    project2 = FactoryGirl.create(:project, name: "Project 2")
    task = FactoryGirl.create(:task,
      project: project2,
      title: "Example Task 2",
      description: "Short decript - re: Task 2.")
    task.update(user: user)
    define_permission!(user, "view", project2)

    sign_in_as!(user)
    visit '/'
  end

  scenario "Viewing tasksfor a given project" do
    click_link 'Project 1'
    
    expect(page).to have_content('Example Task 1')

    click_link 'Example Task 1'
    within('#task h2') do
      expect(page).to have_content('Example Task 1')
    end

    expect(page).to_not have_content('A very detailed descrip of another project that shouldn\'t be here')
  end
end