require 'rails_helper'

RSpec.describe User, :type => :model do
	it "should be invalid if any required field is absent" do 
		params = { email: "edward123@gmail.com", password: "12345678", password_confirmation: "12345678 " }
		@user = User.new params
		expect(@user.valid?).to be_falsy

		params[:name] = "Edward"
		params[:email] = ""
		@user = User.new params
		expect(@user.valid?).to be_falsy

		params[:email] = "edward123@gmail.com"
		params[:password] = ""
		@user = User.new params
		expect(@user.valid?).to be_falsy

		params[:password] = "12345678"
		params[:password_confirmation] = ""
		@user = User.new params
		expect(@user.valid?).to be_falsy
	end

	it "should be invalid if password and password confirmation are not the same" do
		@user = User.new name:"Edward", email: "edward123@gmail.com", password: "12345678", password_confirmation: "12345679"
		expect(@user.valid?).to be_falsy
	end
end
