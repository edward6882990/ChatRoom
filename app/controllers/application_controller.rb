class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	# adding a parameter to the user model (through devise) 
	before_action :configure_permitted_parameters, if: :devise_controller?

	private
		# adding additional paramenters to devise user model		
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) << :name
		end

end
