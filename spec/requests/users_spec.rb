require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",   :with         => ""
          fill_in "Email",   :with        => ""
          fill_in "Password",   :with     => ""
          fill_in "Confirmation",   :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explaination')
        end.should_not change(User, :count)
      end
    end


    describe "success" do
      
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",   :with           => "Graeme"
          fill_in "Email",   :with          => "graeme@mrmetrics.com"
          fill_in "Password",   :with       => "p@ssw0rd"
          fill_in "Confirmation",   :with   => "p@ssw0rd"
          click_button
          response.should render_template('users/show')
          response.should have_selector('div.flash.success', :content => "Thank")
        end.should change(User, :count).by(1)
      end
    end
  end
end
