GBM_version = 201702271 --year month date versionofdate

Script.Load("lua/GhoulsBalance/GUIModChangelog.lua")

local function showchangelog()
	MainMenu_Open()
	local mm = GetGUIMainMenu and GetGUIMainMenu()
	if mm then
		local changelog = CreateMenuElement(mm.mainWindow, "GUIModChangelog")
	end
end

local function onLoadComplete()
	local oldversion = 0 --Client.GetOptionInteger("balancemod_version", 0)
	if GBM_version > oldversion then
		Client.SetOptionInteger("balancemod_version", GBM_version)
		showchangelog()
	end

end

Event.Hook("LoadComplete", onLoadComplete)
Event.Hook("Console_changelog", showchangelog)