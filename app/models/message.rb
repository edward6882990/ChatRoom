class Message < ActiveRecord::Base
	# attr - content:string
	
	belongs_to :user
	belongs_to :chat

	validates_presence_of :content
	validates_presence_of :user_id
	validates_presence_of :chat_id
end
