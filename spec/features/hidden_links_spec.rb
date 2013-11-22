

require 'spec_helper'

feature "Hidden links" do 
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) {FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:task) { FactoryGirl.create(:task, project: project, user: user) }

  context "anonymous users" do
    scenario "cannot see the 'New Project' link" do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular users" do
    before { sign_in_as!(user) }
    scenario "cannot see the 'New Project' link" do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario "New task link is shown to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create tasks", project)
      visit project_path(project)
      assert_link_for "New Task"
    end

    scenario "New task link is hidden from a user without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Task"
    end

    scenario "Edit task link is shown to a user with permission" do
      task
      define_permission!(user, "view", project)
      define_permission!(user, "edit tasks", project)
      visit project_path(project)
      click_link task.title
      assert_link_for "Edit Task"
    end

    scenario "Edit task link is hidden from a user without permission" do
      task
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link task.title
      assert_no_link_for "Edit Task"
    end

    scenario "Delete task link is shown to a user with permission" do
      task
      define_permission!(user, "view", project)
      define_permission!(user, "delete tasks", project)
      visit project_path(project)
      click_link task.title
      assert_link_for "Delete Task"
    end

    scenario "Delete task link is hidden from a user without permission" do
      task
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link task.title
      assert_no_link_for "Delete Task"
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
    scenario "can see the 'New Project' link" do
      visit '/'
      assert_link_for 'New Project'
    end

    scenario "can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end
    
    scenario "can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "New task link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Task"
    end

    scenario "Edit task link is shown to admins" do
      task
      visit project_path(project)
      click_link task.title
      assert_link_for "Edit Task"
    end

    scenario "Delete task link is shown to admins" do
      task
      visit project_path(project)
      click_link task.title
      assert_link_for "Delete Task"
    end
  end
end
