require 'rails_helper'

describe 'navigate' do
  before do
    @user = User.create(email:"test@test.com",password:"astfgh",password_confirmation:"astfgh",first_name:"first_name",last_name:"last_name")
    login_as(@user,:scope => :user)
  end
  describe 'index' do
    before do
      visit posts_path
    end
    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end
    it 'has title of Posts' do
      expect(page).to have_content(/Posts/)
    end
    it "has list of posts" do
      post1 = Post.create(date: Date.today, rationale:"Post1",user_id:@user.id)
      post2 = Post.create(date: Date.today, rationale:"Post2",user_id:@user.id)
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)
    end
  end

  describe "creation" do
    before do
      user = User.create(email:"test2@test.com",password:"astfgh",password_confirmation:"astfgh",first_name:"first_name",last_name:"last_name")
      # used to sign in devise user
      login_as(user,:scope => :user)
      visit new_post_path
    end
    it "has can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can create new post" do
      fill_in 'post[date]',with: Date.today
      fill_in 'post[rationale]',with: "Some Rationale"
      click_on "Save"
      expect(page).to have_content(/Some Rationale/)
    end
    it "will have user associated with it" do
      fill_in 'post[date]',with: Date.today
      fill_in 'post[rationale]',with: "User Rationale"
      click_on "Save"
      expect(User.last.posts.last.rationale).to eq('User Rationale')
    end
  end
end
