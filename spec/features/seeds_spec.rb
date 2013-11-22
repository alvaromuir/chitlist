

require 'spec_helper'

feature "Seed Data" do
  scenario "The basics" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "alvaro@muiral.com").first!
    project = Project.where(name: "Chitlist Beta").first!
  end 
end