class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		redirect_to user_sign_in_path unless user_signed_in?
	end
end
