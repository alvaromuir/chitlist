

require 'spec_helper'

feature "Viewing tasks" do
  before do
    work_project = FactoryGirl.create(:project, name: "Work Project")
    FactoryGirl.create(:task,
      project: work_project,
      title: "Big Review Deck Materials",
      description: "Deck materials for review.")

    weekend_project = FactoryGirl.create(:project, name: "Weekend Project")
    FactoryGirl.create(:task,
      project: weekend_project,
      title: "Rails4 Powered RESTFul Backend",
      description: "Modular rails4 based backend.")

    visit '/'
  end

  scenario "Viewing tickets for a given project" do
    click_link 'Work Project'

    expect(page).to have_content('Big Review Deck Materials')

    click_link 'Big Review Deck Materials'
    within('#task h2') do
      expect(page).to have_content('Big Review Deck Materials')
    end

    expect(page).to_not have_content('Rails4 Powered RESTFul Backend')
  end
end