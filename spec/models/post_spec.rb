require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Creation" do
    before do
      @post = Post.create(date:Date.today,rationale:"Anythin")
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
