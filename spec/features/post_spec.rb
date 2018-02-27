require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create(:user)
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
      # build_stubbed doesn't hit database
      # it mimmics it does
      post1 = FactoryGirl.create(:post, user:@user)
      # post1 = FactoryGirl.build_stubbed(:post)
      post2 = FactoryGirl.create(:second_post, user:@user)
      # post2 = FactoryGirl.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)
    end
  end
  describe 'New' do
    it 'has a link from homepage' do
      visit root_path
      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end
  describe "creation" do
    before do
      user = FactoryGirl.create(:user)
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
  describe "Edit" do
    before do
      @post = FactoryGirl.create(:post, user:@user)
    end
    it "can be reached by clicking edit link" do
      visit posts_path
      click_link("edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end
    it "Can be edited" do
      visit edit_post_path(@post)
      fill_in 'post[date]',with: Date.today
      fill_in 'post[rationale]',with: "Edited Rationale"
      click_on "Save"
      expect(page).to have_content("Edited")
    end
  end
end
