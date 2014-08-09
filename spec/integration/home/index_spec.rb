require 'rails_helper'

RSpec.describe HomeController, type: :controller do

	it "should redirect to sign in page if unauhtenticated" do
		# try to access 'index' wihtout signing in 
		get 'index'

		# check if it redirects to the sign in page
		expect(response.redirect_url).to match /users\/sign_in/
	end

	it "should land when user is signed in" do
		# performs following tasks:
		#1. sign in user
		#2. visit index page
		#3. sign out user
		
		# create a user
		@user = User.create! name: "Edward", 
												 email: "example@gmail.com",
												 password: "12345678", 
												 password_confirmation: "12345678"
		
		# sign in the user
		sign_in @user

		# devise model mapping
		@request.env["devise.mapping"] = Devise.mappings[:user]

		# visit 'index'
		get 'index'

		# assert if page has the following content:
		expect(response.redirect_url).to match /\//

		#sign out user
		sign_out @user

		# assert: it should redirect to teh sign in page
		expect(response.redirect_url).to match /iusers\/sign_in/
	end
end
