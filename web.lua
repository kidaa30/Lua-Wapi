local lapis    = require "lapis"
local console  = require("lapis.console")
local config   = require("lapis.config").get()
local mqtt     = require("mqtt")
local markdown = require("markdown")

-- Do the app config things
local app = lapis.Application()
app:enable("etlua")


app.layout = require "views.layout"		-- Sets the layout we are using.


-- Override what happens when there is a default route.
app.default_route = function ( self )
	
	-- There is no trailing slash removal at this step!!!
	ngx.log(ngx.NOTICE, "User 404 path " .. self.req.parsed_url_path)

	return lapis.Application.default_route(self)
end



-- Handle 404s
app.handle_404 = function( self )
	-- Returns the code 404
	return { status = 404, layout = false, "Not Found!" }
end

-- Handle errors
app.handle_error = function(self, err, trace)
	-- Logs to the nginx console
	ngx.log(ngx.NOTICE, "Lapis error: " .. err .. ": " .. trace)

	-- Handle the erros with Lapis internaly.
	lapis.Application.handle_error(self, err, trace)

	-- TODO: Crashlytics?
end


-- Figures out the html for the index.
local renderIndex = function()
	
	local theString = "<h2>version</h2> " .. require("lapis.version")

	return theString
end



-- Muestra una lista
app:get("/lista", function(self)
	self.unalista = {
		"Uno",
		"Dos",
		"Tres"
	}

	return { render = "listaview" }
end)


local function generateJSON(self)
	-- This is a lua object that gets converted to JSON
	local demoLUAJSON = {
		hello = "hello message",
		otra = "otra message"
	}

	local response = {
		json = demoLUAJSON, 
		status = 200,
		content_type = "application/json"
	}

	return response
end

local function appDesctiprion(self)

	local api = {
		Harris = "programmer",
		Chris = "CEO"
	}

	return {json=api}
end


-- INDEX
app:get("/", function(self)
	return { render  = "index" , status = 200, content_type = "text/html" }
end)

app:get("/markdown", function(getReadme)

	readmeFile = io.open ("README.md", "r")
	contents = readmeFile:read("*all")

	return markdown(contents)
end)


app:get("/testjson", generateJSON)

-- Muestra la version
app:get("/version", renderIndex)


app:get("/api", apiDescription)


-- The LUA CONSOLE FTW!!!
-- app:match("/console", console.make({env="masterDeveloper"}))

-- Serves a lapis web app.
lapis.serve(app)
