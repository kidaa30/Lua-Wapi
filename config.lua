-- config
local config = require("lapis.config")

return config("heroku", function()
	port(os.getenv("PORT"))
	return postgresql_url(os.getenv("DATABASE_URL"))
end)

return config({"development", "production"}, function()
	port(os.getenv("PORT"))
	return postgresql_url(os.getenv("DATABASE_URL"))
end)




