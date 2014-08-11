class Chat < ActiveRecord::Base
	# attr: owner:integer, title:string, is_private:boolean

	def broadcast_message(message, user)
		# publish the message to the chatroom
		$redis.publish "chatroom_#{ self.id.to_s }", { user_name: user.name, message: message.content }.to_json
	end

	# is_private may be use for further feature development
	def is_private?
		self.is_private
	end
end
