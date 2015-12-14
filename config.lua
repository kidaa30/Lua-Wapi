local config
config = require("lapis.config").config
return config("heroku", function()
  port(os.getenv("PORT"))
  return postgresql_url(os.getenv("DATABASE_URL"))
end)
