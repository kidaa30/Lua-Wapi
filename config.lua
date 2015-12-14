-- config
local config = require("lapis.config")

return config({"heroku, development", "production"}, {
	port = os.getenv("PORT"),
	postgresql_url = os.getenv("DATABASE_URL"),
})


