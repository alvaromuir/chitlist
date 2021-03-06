

require 'spec_helper'

describe TasksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:task) { FactoryGirl.create(:task,
                                    project: project,
                                    user: user) }
  context "standard users" do
    it "cannot access a task for a project" do
      sign_in(user)
      get :show, :id => task.id, :project_id => project.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end 
  end

  context "with permission to view the project" do
    before do
      sign_in(user)
      define_permission!(user, "view", project)
    end

    def cannot_create_tasks!
      response.should redirect_to(project)
      flash[:alert].should eql('You cannot create tasks on this project.')
    end


    it "cannot begin to create a task" do
      get :new, project_id: project.id
      cannot_create_tasks!
    end

    it "cannot create a task without permission" do
      post :create, project_id: project.id
      cannot_create_tasks!
    end


    def cannot_update_tasks!
      response.should redirect_to(project)
      flash[:alert].should eql('You cannot edit tasks on this project.')
    end

    it "cannot edit a task without permission" do
      get :edit, { project_id: project.id, id: task.id }
      cannot_update_tasks!
    end

    it "cannot update a task without permission" do
      put :update, { project_id: project.id,
                      id: task.id,
                      task: {} }
      cannot_update_tasks!
    end

    it "cannot delete a task without permission" do
      delete :destroy, { project_id: project.id, id: task.id }

      expect(response).to redirect_to(project)
      flash[:alert].should eql('You cannot delete tasks from this project.')
    end

  end
end