local function UnlockAbility(forAlien, techId)

	local mapName = LookupTechData(techId, kTechDataMapName)
	if mapName and forAlien:GetIsAlive() then

		local activeWeapon = forAlien:GetActiveWeapon()

		local tierWeapon = forAlien:GetWeapon(mapName)
		if not tierWeapon then

			forAlien:GiveItem(mapName)

			if activeWeapon then
				forAlien:SetActiveWeapon(activeWeapon:GetMapName())
			end

		end

	end

end

local function LockAbility(forAlien, techId)

	local mapName = LookupTechData(techId, kTechDataMapName)
	if mapName and forAlien:GetIsAlive() then

		local tierWeapon = forAlien:GetWeapon(mapName)
		local activeWeapon = forAlien:GetActiveWeapon()
		local activeWeaponMapName = nil

		if activeWeapon ~= nil then
			activeWeaponMapName = activeWeapon:GetMapName()
		end

		if tierWeapon then
			forAlien:RemoveWeapon(tierWeapon)
		end

		if activeWeaponMapName == mapName then
			forAlien:SwitchWeapon(1)
		end

	end

end

function UpdateAbilityAvailability(forAlien, tierOneTechId, tierTwoTechId, tierThreeTechId)

	local time = Shared.GetTime()
	if forAlien.timeOfLastNumHivesUpdate == nil or (time > forAlien.timeOfLastNumHivesUpdate + 0.5) then

		local team = forAlien:GetTeam()
		if team and team.GetTechTree then

			local hasOneHiveNow = GetGamerules():GetAllTech() or (tierOneTechId ~= nil and tierOneTechId ~= kTechId.None and GetIsTechUnlocked(forAlien, tierOneTechId))
			local hadOneHive = forAlien.oneHive
			forAlien.oneHive = hasOneHiveNow

			if hadOneHive ~= hasOneHiveNow then
				if hasOneHiveNow then
					UnlockAbility(forAlien, tierOneTechId)
				else
					LockAbility(forAlien, tierOneTechId)
				end
			end

			local hasTwoHivesNow = GetGamerules():GetAllTech() or (tierTwoTechId ~= nil and tierTwoTechId ~= kTechId.None and GetIsTechUnlocked(forAlien, tierTwoTechId))
			local hadTwoHives = forAlien.twoHives
			forAlien.twoHives = hasTwoHivesNow

			if hadTwoHives ~= hasTwoHivesNow then
				if hasTwoHivesNow then
					UnlockAbility(forAlien, tierTwoTechId)
				else
					LockAbility(forAlien, tierTwoTechId)
				end
			end

			local hasThreeHivesNow = GetGamerules():GetAllTech() or (tierThreeTechId ~= nil and tierThreeTechId ~= kTechId.None and GetIsTechUnlocked(forAlien, tierThreeTechId))
			local hadThreeHives = forAlien.threeHives
			forAlien.threeHives = hasThreeHivesNow
			
			if hadThreeHives ~= hasThreeHivesNow then
				if hasThreeHivesNow then
					UnlockAbility(forAlien, tierThreeTechId)
				else
					LockAbility(forAlien, tierThreeTechId)
				end
			end

		end

		forAlien.timeOfLastNumHivesUpdate = time

	end

end

