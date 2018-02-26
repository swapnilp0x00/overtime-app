require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Creation" do
    before do
      @user = User.create(email:"test@test.com",password:"astfgh",password_confirmation:"astfgh",first_name:"first_name",last_name:"last_name")
      @post = Post.create(date:Date.today,rationale:"Anything", user:@user)
    end
    it "can be created" do
      expect(@post).to be_valid
    end
    it "cant be created without empty date and rationale" do
      @post.date = nil
      @post.rationale = nil
      expect(@post).to_not be_valid
    end
  end
end
