require 'spec_helper'

describe User do
  describe "passwords" do
    it "needs a password and confirmation to save" do
      u = User.new(name: "appdev")

      u.save
      expect(u).to_not be_valid

      u.password = "password"
      u.password_confirmation = ""
      u.save
      expect(u).to_not be_valid

      u.password_confirmation = "password"
      u.save
      expect(u).to be_valid
    end

    it "needs password and cofirmation to match" do
      u = User.create(
        name: "appdev",
        password: "somepass",
        password_confirmation: "somepass2")
      expect(u).to_not be_valid
    end
  end

  describe "authentication" do
    let(:user) {
      User.create(
        name: "appdev",
        password: "somepass2",
        password_confirmation: "somepass2")
      }
    it "authenticates with a correct password" do
      expect(user.authenticate("somepass2")).to be
    end

    it "does not authenticate with an incorrect password" do
      expect(user.authenticate("somepass3")).to_not be
    end
  end
end
