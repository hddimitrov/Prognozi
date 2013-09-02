class AdminPanelController < ActionController::Base

	def add_matches
		@tournaments = Tournament.all
	end

end
