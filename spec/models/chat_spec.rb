require 'rails_helper'

RSpec.describe Chat, :type => :model do
	it "should be invalid without an owner" do 
		# create a chat with no owner
		@chat = Chat.new

		# assert if chat is not valid
		expect(@chat.valid?)to be_falsy
	end
end
