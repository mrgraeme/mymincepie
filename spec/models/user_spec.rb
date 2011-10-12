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
    @attr = { :name => "Example", 
      :email => "user@example.com",
      :password => "victoria",
      :password_confirmation => "victoria"
    }
  end


  it "Should create a new instance of given valid attributes" do
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

  it "Should accept valid email addresses" do
    addresses = %w[graeme@mrmetrics.com graeme@mr.metrics.jp graeme.benstead@sitevisibility.co.uk]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "Should reject invalid email addresses" do
    addresses = %w[user@jump,com user_at_something.org yes.no@maybe.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "Should reject duplicate user emails ignoring case" do
    upcase_address = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_address))
    duplicate_user = User.new(@attr)
    duplicate_user.should_not be_valid
  end

  it "Should require a password" do
    user = User.new(@attr.merge(:password => ""))
    user.should_not be_valid
  end

  it "Should require a matching passowrd confirmation" do
    user = User.new(@attr.merge(:password_confirmation => 'other'))
    user.should_not be_valid
  end

  it "Should reject short passwords" do
    short_password = "a" * 5
    user = User.new(@attr.merge(:password => short_password, :password_confirmation => short_password))
    user.should_not be_valid
  end

  it "Should reject long paswords" do
    long_password = "z" * 21
    user = User.new(@attr.merge(:password => long_password, :password_confirmation => long_password))
    user.should_not be_valid
  end



  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "Should have an encrypted password" do
      @user.should respond_to(:encrypted_password)
    end

  end

end

