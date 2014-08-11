class ChatsController < ApplicationController
	before_action :authenticate_user!

	def create
		begin
			# create a chat 

			# add 'owner' to params
			params[:chat][:owner] = current_user.id
			@chat = Chat.create chat_param

			# redirect to the chat room upon create
			redirect_to @chat

			return
		rescue
			# redirect to root if error occurs
			
			redirect_to root_path
			return 
		end
	end

	def new
		# create a new Chat object
		@chat = Chat.new
	end

	def show
		@chat = Chat.find(params[:id])
	end

	private

	def chat_param
		# permit chat parameters
		params.require(:chat).permit(:owner, :title, :is_private)
	end
end
