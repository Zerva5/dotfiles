local naughty = require("naughty")
local awful = require("awful")

local tag = {}

tag.main = {}

tag.main.Web = {
	name = "Web",
	tag = {},
	selectedClients = {},
	subtags = {}
}

tag.main.Music = {
	name = "Music",
	tag = {},
	selectedClients = {},
	subtags = {}
}

tag.main.Misc = {
	name = "Misc",
	tag = {},
	selectedTags = {},
	subtags = {}
}

tag.addSubtag = function(tag, subclient)
	table.insert(tag.subtags, subclient)
	subclient:move_to_tag(tag.tag)
end

tag.Initialize = function(s)
	tag.main.Web.tag = awful.tag.add(tag.main.Web.name, {
		layout = awful.layout.suit.tile,
		selected = true
	})

	tag.main.Music.tag = awful.tag.add(tag.main.Music.name, {
		layout = awful.layout.suit.tile,
	})
	
end

tag.cycleClient = function(oldClient, dir)
	tag.changeClient(oldClient, oldClient.next(-1))
end

tag.changeClient = function(cold, cnew)
	cold.minimized = true

	cnew.minimized = false

end

return tag
