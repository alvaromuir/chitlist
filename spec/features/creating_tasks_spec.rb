

require 'spec_helper'

feature "Creating Tasks" do
  before do
    FactoryGirl.create(:project, name: "Weekend Project: ToDo App")

    visit '/'
    click_link 'Weekend Project'
    click_link 'New Task'
  end

  scenario "Creating a task" do
    fill_in 'Title', with: "Build a Rails backend"
    fill_in "Description", with: "Need a dynamic backend tested and capabable of RESTful API support"
    click_button 'Create Task'

    expect(page).to have_content('Task has been created.')
  end

  scenario 'Creating a task without valid attributes fails' do 
    click_button 'Create Task'

    expect(page).to have_content('Task has not been created.')
    expect(page).to have_content('Title can\'t be blank')
    expect(page).to have_content('Description can\'t be blank')
  end

  scenario 'Description must be longer than 10 characters' do
    fill_in 'Title', with: "Build a Rails backend"
    fill_in 'Description', with: 'Why not?'
    click_button 'Create Task'

    expect(page).to have_content('Task has not been created.')
    expect(page).to have_content('Description is too short')
  end
end