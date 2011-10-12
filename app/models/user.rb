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

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true, 
                    :length => {:maximum => 75}
  validates :email, :presence => true, 
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..20}
  
end
