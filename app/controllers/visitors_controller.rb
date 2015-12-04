class VisitorsController < ApplicationController
	before_filter :check_signin
	def check_signin
		if user_signed_in?
			redirect_to feed_path
		end
	end
end
