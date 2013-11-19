
require 'spec_helper'

feature "Viewing projects" do
  scenario "Listing all projects" do
    project = FactoryGirl.create(:project, name: "Work Project")
    visit '/'
    click_link 'Work Project'
    expect(page.current_url).to eql(project_url(project))
  end
end