class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		redirect_to user_sign_in_path unless user_signed_in?

		# track the current page number
		@page = params[:page].to_i >= 1 ? params[:page] : 1

		# paginate public chat rooms. Currently fixed items per page to be 15
		@chats = Chat.where(is_private: false).paginate(page: @page, per_page: 15).order('created_at DESC')

		@total_pages = @chats.total_pages
	end
end
