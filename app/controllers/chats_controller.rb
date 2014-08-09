class ChatsController < ApplicationController
	before_action :authenticate_user!

	def create
		begin
			@chat = Chat.create owner: current_user.id
			redirect_to :show
		rescue
			redirect_to root
		end
	end

	def show
	end
end
