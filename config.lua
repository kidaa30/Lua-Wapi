-- config
local config = require("lapis.config")

-- return config("heroku", function()
-- 	port(os.getenv("PORT"))
-- 	return postgresql_url(os.getenv("DATABASE_URL"))
-- end)

return config("heroku", {
	port = os.getenv("PORT"),
	postgres_url = os.getenv("DATABASE_URL"),
	postgres = {
		host = os.getenv("DATABASE_URL"),
		port = "5432",
		user = "wddcthddvouvtr",
		password = "_EsJ9XVoYVSYXDWbUDOTQPdrph",
		database = "d2k28tn5s3orl5",
	}
})


