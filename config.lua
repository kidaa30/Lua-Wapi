-- config
local config = require("lapis.config")

return config({"heroku, development", "production"}, function()
	port(os.getenv("PORT"))
	return postgresql_url(os.getenv("DATABASE_URL"))
end)


return config({"heroku, development", "production"}, {
	port = os.getenv("PORT"),
	postgresql_url = os.getenv("DATABASE_URL"),
})


