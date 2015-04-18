Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :spotify, "386c400d39ec46218857903fac22f401", "7fca20b74d694e23b86dfbb6dc3208e5", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
	

	
end