if not term.isColor or not term.isColor() then
	error('SurvData Requires an Advanced (gold) Computer')
end

local mainTitle = 'SurvData Update'
local subTitle = 'Checking For Update...'

local SelfUpdate = dofile("System/APIs/updater.lua")

function Draw()
	sleep(0)
	term.setBackgroundColour(colours.white)
	term.clear()
	local w, h = term.getSize()
	term.setTextColour(colours.lightBlue)
	term.setCursorPos(math.ceil((w-#mainTitle)/2), 8)
	term.write(mainTitle)
	term.setTextColour(colours.blue)
	term.setCursorPos(math.ceil((w-#subTitle)/2), 10)
	term.write(subTitle)
end
Draw()
function Sucessful ()
	local FSVER = fs.open("System/.dlversion", "r")
	local ver = tonumber(file.readAll())
	file.close()

	subTitle = 'Sucessfully updated to version '..FSVER..'.'
	Draw()
end

function UptoDate()
	local FSVER = fs.open("System/.dlversion", "r")
	local ver = tonumber(file.readAll())
	file.close()
		
	subTitle = 'Upto Date Starting System (Current Version: '..FSVER..'.'
	Draw()
end
sleep()
SelfUpdate.update(Sucessful, UptoDate, "SizableRapter", "cc-SurvData")

