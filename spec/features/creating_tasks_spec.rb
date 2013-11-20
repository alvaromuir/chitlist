

require 'spec_helper'

feature "Creating Tasks" do
  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)

    visit '/'
    click_link project.name
    click_link 'New Task'
    message = 'You need to sign in or sign up before continuing.'
    expect(page).to have_content(message)

    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    click_link project.name
    click_link 'New Task'
  end

  scenario "Creating a task" do
    fill_in 'Title', with: "Build a Rails backend"
    fill_in "Description", with: "Need a dynamic backend tested and capabable of RESTful API support"
    click_button 'Create Task'

    expect(page).to have_content('Task has been created.')

    within '#task #author' do
      expect(page).to have_content("Created by someone@example.com")
    end
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