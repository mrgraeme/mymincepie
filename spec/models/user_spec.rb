# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do

before(:each) do
  @attr = { :name => "Example", :email => "user@example.com" }
end

it "Should create a new instance of given valia attributes" do
  User.create!(@attr)
end

it "Should Require a name" do
  no_name_user = User.new(@attr.merge(:name => ""))
  no_name_user.should_not be_valid
end

it "Should have a name below 75 Characters" do
long_name = "a" * 76
long_name_user = User.new(@attr.merge(:name => long_name))
long_name_user.should_not be_valid
end

it "Should require an email" do
  no_email_user = User.new(@attr.merge(:email => ""))
  no_email_user.should_not be_valid
end


end
