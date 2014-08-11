class MessagesController < ApplicationController
	before_action :authenticate_user!

	def create
		# assign current user's id to the message
		params[:message][:user_id] = current_user.id

		begin
			# assert if chat exists
			@chat = Chat.find params[:message][:chat_id]
			raise "Invalid Chat." if @chat.nil?

			# attempt to create message 
			@message = Message.create message_params

			# broadcast the message if successful
			@chat.broadcast_message @message, current_user

			render nothing: true
		rescue
			logger.debug "Error - messages#create: #{ $!.message }"
			render status: :bad_request, text: $!.message
		end
	end

	private
		def message_params
			params.require(:message).permit(:content, :chat_id, :user_id)
		end
end
