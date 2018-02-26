require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end
  it "can be created" do
    expect(@user).to be_valid
  end
  it "cant be created without firstname" do
    @user.first_name = nil
    @user.last_name = nil
    expect(@user).to_not be_valid
  end
  it "has full name method" do
    expect(@user.full_name).to eq("#{@user.first_name.upcase} #{@user.last_name.upcase}")
  end
end
