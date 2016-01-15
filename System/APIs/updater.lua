local JSON = dofile("System/APIs/dkjson.lua")

local updater = {}

local function getLocal(v)
	if v then
		if fs.exists("System/.version") then
			local file = fs.open("System/.version", "r")
			local ver = file.readAll()
			file.close()
			return tonumber(ver)
		else
			return 0
		end
	else
		if fs.exists("System/.dlversion") then
			local file = fs.open("System/.dlversion", "r")
			local ver = file.readAll()
			file.close()
			return tonumber(ver)
		else
			return 0
		end	
	end
end

local function getOnline(user, repo)
	local size = 0
	local query = "https://api.github.com/repos/"..user.."/"..repo.."/commits"
	local request = http.get(query).readAll()
	local data = JSON.decode(request)
	size = size + #data
	local sha = data[#data].sha
	repeat
		local query = "https://api.github.com/repos/"..user.."/"..repo.."/commits?sha="..sha
		local request = http.get(query).readAll()
		local data = JSON.decode(request)
		if #data ~= 1 then
			size = size + #data
			size = size - 1
		end
		sha = data[#data].sha
	until #data == 1
	return size
end

local function setLocal(ver, v)
	if v then
		local file = fs.open("System/.version", "w")
		file.write(ver)
		file.close()
	else
		local file = fs.open("System/.dlversion", "w")
		file.write(ver)
		file.close()
	end
end

function updater.update(funcToRun, funcToRunNone, user, repo)
	local onl = getOnline(user, repo)
	local loc = getLocal(true)
	if onl > loc then
		setLocal(onl, true)
		funcToRun()
	else
		funcToRunNone()
	end
end

return updater
