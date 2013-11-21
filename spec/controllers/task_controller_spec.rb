

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
end