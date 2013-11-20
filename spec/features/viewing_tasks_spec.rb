

require 'spec_helper'

feature "Viewing tasks" do
  before do
    user = FactoryGirl.create(:user)
    work_project = FactoryGirl.create(:project, name: "Work Project")
    task = FactoryGirl.create(:task,
      project: work_project,
      title: "Some Work Stuff",
      description: "A todo item for some work project due this week.")
    task.update(user: user)

    weekend_project = FactoryGirl.create(:project, name: "Weekend Project")
    task = FactoryGirl.create(:task,
      project: weekend_project,
      title: "Rails4 Powered RESTFul Backend",
      description: "Modular rails4 based backend.")
    task.update(user: user)

    visit '/'
  end

  scenario "Viewing tickets for a given project" do
    click_link 'Work Project'

    expect(page).to have_content('Some Work Stuff')

    click_link 'Some Work Stuff'
    within('#task h2') do
      expect(page).to have_content('Some Work Stuff')
    end

    expect(page).to_not have_content('A very detailed descrip of another project that shouldn\'t be here')
  end
end