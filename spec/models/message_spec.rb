require 'rails_helper'

RSpec.describe Message, :type => :model do
	before(:all) do
		@user = User.create! name: "Edward", email: "example@gmail.com", password: "12345678", password_confirmation: "12345678"
		@chat = Chat.create! owner: @user.id
	end

	it "should not be valid if content is empty" do
		# assert empty message to be invalid
		@message = Message.new
		expect(@message.valid?).to be_falsy
	end

	it "should have a reference to a user and a chat" do
		# checking if missing user_id makes the message invalid
		@message = Message.new content: "Hellow World!", chat_id: @chat.id
		expect(@message.valid?).to be_falsy

		# checking if putting baack user_id makes the message valid again
		@message.user_id = @user.id
		expect(@message.valid?).to be_truthy

		# checking if missing chat_id makes the message invalid
		@message.chat_id = nil
		expect(@message.valid?).to be_falsy

		# checking if putting back chat_id makes the message valid again
		@message.chat_id = @chat.id
		expect(@message.valid?).to be_truthy
	end
end
