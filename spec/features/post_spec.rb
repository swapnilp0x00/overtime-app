require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end
    it 'has title of Posts' do
      visit posts_path
      expect(page).to have_content(/Posts/)
    end
  end

  describe "creation" do
    before do
      user = User.create(email:"test@test.com",password:"astfgh",password_confirmation:"astfgh",first_name:"first_name",last_name:"last_name")
      # used to sign in devise user
      login_as(user,:scope => :user)
      visit new_post_path
    end
    it "has new post form" do
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
