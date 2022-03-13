-- Pet Simulator X

-- Pepsi Was Here [Petsi X]

local petsiversion = "0.031"
local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)("Pepsi's UI Library")
local Wait = Library.subs.Wait
local Players = game:GetService("Players")
local LP = Players.LocalPlayer or Library.LP
if shared.debugmode == 2 then
	local pc = pcall
	function pcall(...)
		local t = {pc(...)}
		if t[1] and t[2] then
			warn(t[2])
		end
		return unpack(t, 2)
	end
end
local GameData, GetCoins, GetOrbs, CollectOrb, SelectCoin, GetEquippedPets, GetSaveData, GetLootBags, CollectLootBag, ToggleHoverBoard = {}, nil, nil, nil, nil, nil, nil, nil, nil, nil
do
	local GameScripts = LP:WaitForChild("PlayerScripts"):WaitForChild("Scripts"):WaitForChild("Game")
	local syn_secure_call = (syn and syn.secure_call) or function(f, y, ...)
		return setfenv(function(...)
			return f(...)
		end, (y and y.Env) or (getrenv or getfenv)(1))(...)
	end
	local common_script = GameScripts:WaitForChild("Upgrade Machine Animation")
	local debug_info, GetMeta = debug.info, nil
	function GetMeta(t)
		local cache = setmetatable({}, {
			__mode = "kv"
		})
		return {
			__index = function(_, k)
				if rawequal(k, "__cache") then
					return cache
				end
				local thing = rawget(t, k)
				if thing then
					do
						local thing = cache[thing]
						if thing then
							return thing
						end
					end
					local type_thing = type(thing)
					if type_thing == "table" then
						local proxy = setmetatable({
							__self = thing
						}, GetMeta(thing))
						cache[thing] = proxy
						return proxy
					elseif type_thing == "function" then
						local Script = (function()
							local q, e = pcall(function()
								return rawget(getfenv(thing), "script")
							end)
							return (q and e and typeof(e) == "Instance" and e:IsA("LuaSourceContainer") and e) or common_script
						end)()
						local call_args = {
							Script = Script,
							LineNumber = debug_info(thing, "l"),
							Environment = (function()
								local q, e = pcall(getsenv, Script)
								return (q and e) or setmetatable({
									script = Script
								}, {
									__index = getrenv()
								})
							end)()
						}
						local proxy = setmetatable({
							__self = thing,
							__args = call_args
						}, {
							__call = function(_, ...)
								return syn_secure_call(thing, call_args, ...)
							end
						})
						cache[thing] = proxy
						return proxy
					end
				end
				return thing
			end
		}
	end
	do
		local t = assert(debug.getupvalues(assert(rawget(getsenv(common_script), "UseAnimation"), "GameScripts.UpgradeMachineAnimation.UseAnimation missing?"))[2], "GameData table not found")
		GameData.__self = t
		shared.GameData = setmetatable(GameData, GetMeta(t))
		if GameData then
			local LootBags = GameData.Things.Lootbags
			function GetLootBags()
				return LootBags:GetChildren()
			end
			local CollectLootR = assert(rawget(getsenv(GameScripts:WaitForChild("Lootbags")), "Collect"), "Couldn't get lootbag data")
			local CollectLootT = setmetatable({}, GetMeta({
				SpoofMe = CollectLootR
			})).SpoofMe
			function CollectLootBag(...)
				return CollectLootT(...)
			end
		end
	end
	do
		local debug_getupvalues = debug.getupvalues
		do
			local CollectOrbR = assert(rawget(getsenv(GameScripts:WaitForChild("Orbs")), "Collect"), "Couldn't get orb data")
			local CollectOrbT = setmetatable({}, GetMeta({
				SpoofMe = CollectOrbR
			})).SpoofMe
			function CollectOrb(...)
				return CollectOrbT(...)
			end
			function GetOrbs()
				return debug_getupvalues(CollectOrbR)[1]
			end
		end
		local invokecoins = assert(rawget(getsenv(GameScripts:WaitForChild("Coins")), "InvokeCoins"), "Couldn't get coin data")
		function GetCoins()
			return debug_getupvalues(invokecoins)[2]
		end
		local NetworkUpdate = assert(rawget(getsenv(GameScripts:WaitForChild("Pets")), "NetworkUpdate"), "Couldn't get Pets.NetworkUpdate")
		local GetEquippedPetsT = GameData.PetCmds.GetEquipped
		function GetEquippedPets(...)
			local pets = {}
			local all = debug_getupvalues(NetworkUpdate)[1]
			for slot, dat in next, GetEquippedPetsT(...) do
				dat = all[rawget(dat, "uid")] or dat
				pets[slot] = setmetatable({
					__self = dat
				}, GetMeta(dat))
			end
			return pets
		end
		function shared.GetEquippedPets(...)
			return GetEquippedPets(...)
		end
		pcall(function()
			local SaveData = rawget(debug.getupvalues(rawget(getsenv(game:GetService("ReplicatedStorage"):WaitForChild("Framework", 6):WaitForChild("Modules", 5):WaitForChild("Client", 4):WaitForChild("4 | Save", 3)), "ProcessChanges"))[1], LP)
			do
				local t = rawget(SaveData, "save")
				local Data = t and setmetatable({
					__self = t
				}, GetMeta(t))
				function GetSaveData()
					if not Data then
						t = rawget(SaveData, "save")
						Data = t and setmetatable({
							__self = t
						}, GetMeta(t))
					end
					return Data
				end
			end
			shared.GetSaveData = GetSaveData
		end)
	end
	local SelectCoinT = setmetatable({}, GetMeta({
		SpoofMe = assert(rawget(getsenv(assert(GameScripts:WaitForChild("Select Coins"), "GameScripts.SelectCoins mising?")), "SelectCoin"), "GameScripts.SelectCoins.SelectCoin missing?")
	})).SpoofMe
	function SelectCoin(...)
		return SelectCoinT(...)
	end
end
local Libraryflags = Library.flags
local CoinsFolder = workspace:WaitForChild("__THINGS"):WaitForChild("Coins")
local GetSortedCoins, GetUnlockedCoins, FindFirstChild, BuyEgg, NetworkInvoke = nil, nil, nil, nil, nil
do
	local HasArea = assert(GameData.WorldCmds.HasArea, "WorldCmds.hasArea missing?")
	local CoinData = assert(GameData.Directory.Coins, "Directory.Coins missing?")
	FindFirstChild = CoinsFolder.FindFirstChild
	local CoinHP, CoinCurrency = {}, {}
	for name, dat in next, GameData.Directory.Coins.__self do
		CoinHP[name] = rawget(dat, "health")
		CoinCurrency[name] = rawget(dat, "currencyType")
	end
	function GetUnlockedCoins()
		local coins = {}
		for id, dat in next, GetCoins() do
			local coin = CoinData[rawget(dat, "n")]
			if coin and coin.area and FindFirstChild(CoinsFolder, id) and HasArea(coin.area) then
				coins[id] = dat
			end
		end
		return coins
	end
	do
		local table_sort = table.sort
		local getdist = LP.DistanceFromCharacter
		function GetSortedCoins()
			local wanted = {}
			local checkdist = Libraryflags.checkdistance and Libraryflags.maxcoindistance
			local checksize = Libraryflags.ignorebigtargets
			for id, dat in next, GetUnlockedCoins() do
				local coin = FindFirstChild(CoinsFolder, id)
				if coin then
					local pos = rawget(dat, "p")
					local cdist = getdist(LP, pos)
					local rawcoin = checksize and coin:FindFirstChild("Coin")
					local csize = rawcoin and rawcoin.Size.Magnitude
					if (not checkdist or not cdist or cdist < checkdist) and (not csize or csize < 30) then
						local name = rawget(dat, "n")
						local hp = CoinHP[name]
						local t = wanted[hp] or {}
						wanted[hp] = t
						t[1 + #t] = {
							Id = id,
							Data = dat,
							MaxHealth = CoinHP[name],
							Currency = CoinCurrency[name],
							Position = pos,
							Dist = cdist,
							Coin = coin,
							Pets = rawget(dat, "pets"),
							Name = name
						}
					end
				end
			end
			local sorted = {}
			do
				local function sort(a, b)
					return a.Dist < b.Dist
				end
				for hp, coins in next, wanted do
					table_sort(coins, sort)
					sorted[1 + #sorted] = {hp, coins}
				end
			end
			table_sort(sorted, function(a, b)
				if Libraryflags.targetselection ~= "Most Health" then
					a, b = b, a
				end
				return a[1] > b[1]
			end)
			local coins = {}
			for _, v in next, sorted do
				for _, v in next, v[2] do
					coins[1 + #coins] = v
				end
			end
			return coins
		end
		function shared.GetSortedCoins(...)
			return GetSortedCoins(...)
		end
	end
	NetworkInvoke = GameData.Network.Invoke
	shared.NetworkInvoke = NetworkInvoke
	function BuyEgg(EggType)
		if EggType and EggType ~= "Disabled" then
			pcall(function()
				NetworkInvoke("Buy Egg", EggType, false)
			end)
		end
	end
end
local PetsiXWindow = Library:CreateWindow({
	Name = "Petsi X",
	Themeable = {
		Credit = false,
		Info = {"Library & GUI by Pepsi#5229", "Discord Server: VzYTJ7Y"}
	},
	DefaultTheme = shared.petsixtheme or "{\"__Designer.Colors.main\":\"2BC6FF\"}"
})
local FarmingTab = PetsiXWindow:CreateTab({
	Name = "Farming"
})
local FarmingSection = FarmingTab:CreateSection({
	Name = "Farming"
})
local lastcoin = nil
do
	local math_min = math.min
	local ques = {}
	local donttouchcoins = setmetatable({}, {
		__mode = "kv"
	})
	local temptable = setmetatable({}, {
		__index = donttouchcoins,
		__newindex = function(_, k, v)
			donttouchcoins[k] = v
			if v ~= nil then
				local num = (ques[k] or 0) + 1
				ques[k] = num
				delay(2, function()
					if ques[k] == num then
						ques[k], donttouchcoins[k] = nil
					end
				end)
			end
		end
	})
	FarmingSection:AddToggle({
		Name = "Farming",
		Flag = "farming",
		Value = false,
		Callback = function(active)
			if active then
				while (not GetEquippedPets or not GetSortedCoins or not SelectCoin) and Wait(1) do
				end
				while Wait() and Libraryflags.farming do
					pcall(function()
						local slaves = GetEquippedPets()
						local losers = {}
						for _, v in next, slaves do
							losers[v.uid] = true
						end
						local oops = 0
						local coins = GetSortedCoins()
						if coins and #coins > 0 then
							for _, v in next, slaves do
								if Wait() and not v.farming and Libraryflags.farming then
									local icoin, fallback = nil, nil
									local targetdiamonds = Libraryflags.targetdiamonds
									local multitarget = Libraryflags.multitarget
									for _, coin in next, coins do
										icoin = coin.Coin
										if icoin and not temptable[icoin] and icoin.Parent then
											local valid_coin = true
											if multitarget then
												for _, slave_id in next, coin.Pets do
													if losers[slave_id] then
														temptable[icoin] = 1
														icoin, valid_coin = nil
														break
													end
												end
											end
											if valid_coin then
												if not targetdiamonds or coin.Currency == "Diamonds" then
													break
												else
													fallback = fallback or (valid_coin and icoin)
												end
											elseif icoin then
												icoin = nil
											end
										elseif icoin then
											icoin = nil
										end
									end
									icoin = icoin or fallback
									if icoin and icoin.Parent then
										temptable[icoin] = 1
										lastcoin = FindFirstChild(icoin, "Coin")
										if multitarget then
											SelectCoin(icoin, false)
											if not Wait(0.05) or not Libraryflags.farming then
												return
											end
										else
											SelectCoin(icoin, true)
											break
										end
									end
								end
							end
						elseif not Wait(0.1) then
							return
						end
					end)
				end
			end
		end
	})
end
FarmingSection:AddToggle({
	Name = "Multi Target",
	Flag = "multitarget",
	Value = true
})
FarmingSection:AddToggle({
	Name = "Prioritize Diamonds",
	Flag = "targetdiamonds",
	Value = false
})
FarmingSection:AddToggle({
	Name = "Ignore Big Targets",
	Flag = "ignorebigtargets"
})
FarmingSection:AddToggle({
	Name = "Distance Limit",
	Flag = "checkdistance"
})
FarmingSection:AddSlider({
	Name = "Max Coin Distance",
	Flag = "maxcoindistance",
	Min = 0,
	Max = 400,
	Value = 200,
	Format = "Farm Distance: %sm",
	Textbox = true,
	IllegalInput = true
})
FarmingSection:AddDropdown({
	Name = "Coin Selection",
	Flag = "targetselection",
	List = {"Most Health", "Least Health"}
})
do
	local orbfolder = workspace:WaitForChild("__THINGS"):WaitForChild("Orbs")
	local GetChildren = orbfolder.GetChildren
	local math_max = math.max
	local orbtog = nil
	orbtog = FarmingSection:AddToggle({
		Name = "Collect Orbs",
		Flag = "collectorbs",
		Value = false,
		Callback = function(x)
			if x then
				while (not CollectOrb or not GetOrbs) and Wait(0.1) do
				end
				while Wait(0.1) and CollectOrb and GetOrbs and Libraryflags.collectorbs do
					pcall(function()
						local x = 0
						for orb, dat in next, GetOrbs() do
							if orb.Parent then
								x = (1 + x) % 12
								if (x ~= 0 or Wait()) and Libraryflags.collectorbs then
									pcall(CollectOrb, orb, dat)
								else
									return
								end
							end
						end
					end)
				end
			end
		end
	})
end
do
	FarmingSection:AddToggle({
		Name = "Collect Lootbags",
		Flag = "collectlootbags",
		Value = false,
		Callback = function(x)
			if x then
				while (not CollectOrb or not GetOrbs) and Wait(0.1) do
				end
				while Wait(0.1) and CollectLootBag and GetLootBags and Libraryflags.collectlootbags do
					pcall(function()
						local x = 0
						for _, bag in next, GetLootBags() do
							x = (1 + x) % 12
							if (x ~= 0 or Wait()) and Libraryflags.collectlootbags then
								pcall(CollectLootBag, bag)
							else
								return
							end
						end
					end)
				end
			end
		end
	})
end
if NetworkInvoke then
	local Random = Random.new()
	local Random_NextNumber = Random.NextNumber
	FarmingSection:AddToggle({
		Name = "Collect Rank Rewards",
		Flag = "collectrewards",
		Callback = function(x)
			if x then
				while Wait(5) and Libraryflags.collectrewards do
					local s, e = pcall(NetworkInvoke, "Redeem Rank Rewards")
					if s and not e and not Wait(15 + Random_NextNumber(Random, -1, 5)) then
						return
					end
				end
			end
		end
	})
end
do
	local Random = Random.new()
	local ni = Random.NextNumber
	FarmingSection:AddToggle({
		Name = "Equip Best Pets",
		Flag = "equipstrongestpets",
		Callback = function(x)
			if x then
				pcall(function()
					while Wait(5 + ni(Random, 0, 3)) and Libraryflags.equipstrongestpets do
						pcall(NetworkInvoke, "Equip Best Pets")
					end
				end)
			end
		end
	})
end
FarmingSection:AddButton({
	Name = "Unlock Some Gamepasses",
	Callback = function()
		local Bypasser = require(game:GetService("ReplicatedStorage").Framework.Modules.Client["5 | Gamepasses"])
        	Bypasser.Owns = function() return true end
    	end
})
FarmingSection:AddButton({
	Name = "Remove Hatch animation",
	Callback = function()
		for i,v in pairs(getgc(true)) do
			if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
				v.OpenEgg = function()
					return
				end
			end
		end
	end
})
local EggSection = FarmingTab:CreateSection({
	Name = "Eggs & Machines",
	Side = "Right"
})
do
	local Eggs = {}
	for egg, dat in next, GameData.Directory.Eggs.__self do
		if rawequal(rawget(dat, "hatchable"), true) then
			Eggs[1 + #Eggs] = egg
		end
	end
	table.sort(Eggs, Library.defaultSort)
	EggSection:AddSearchBox({
		Name = "Egg Select",
		Flag = "eggtype",
		Nothing = "Disabled",
		List = Eggs
	})
end
EggSection:AddSlider({
	Name = "Buy Rate",
	Flag = "eggbuyrate",
	Min = 0,
	Max = 10,
	Value = 1,
	Textbox = true,
	Format = "Buy Rate: %s",
	Precise = 2,
	IllegalInput = true
})
do
	local function OpenEgg()
		local eggtype = Libraryflags.eggtype
		if eggtype and eggtype ~= "Disabled" then
			BuyEgg(eggtype)
		end
	end
	do
		local clock = os.clock
		local lastbuy = 0
		EggSection:AddToggle({
			Name = "Auto Buy",
			Flag = "eggautobuy",
			Callback = function(x)
				if x then
					while Wait() and Libraryflags.eggautobuy do
						local now = clock()
						if now - lastbuy > Libraryflags.eggbuyrate then
							lastbuy = now
							OpenEgg()
						end
					end
				end
			end
		})
	end
	EggSection:AddButton({
		Name = "Buy Egg",
		Callback = OpenEgg
	})
end
do
	local table_sort = table.sort
	local table_clear = table.clear
	local SaveData, SlaveData, AllSlaves, SlaveSelf = nil, nil, nil, nil
	local function Sort(a, b)
		return #a > #b
	end
	for block = 1, 3 do
		local block1 = block == 1
		local block2 = block == 2
		local block3 = block == 3
		local flagname = (block1 and "goldm") or (block2 and "rainbowm") or (block3 and "darkmatterm") or error("Invalid block: " .. tostring(block))
		local networkString = (block1 and "Use Golden Machine") or (block2 and "Use Rainbow Machine") or (block3 and "Convert To Dark Matter")
		EggSection:AddToggle({
			Name = (block1 and "Auto Gold Convert") or (block2 and "Auto Rainbow Convert") or (block3 and "Auto Dark Matter Convert"),
			Flag = flagname,
			Callback = function(x)
				if x then
					while not GetSaveData and Wait(1) do
					end
					while Wait(0.1) and Libraryflags[flagname] do
						SaveData = GetSaveData()
						AllSlaves = SaveData.Pets
						SlaveSelf = AllSlaves.__self
						SlaveData = GameData.Directory.Pets
						local softoverride = nil
						local Types = {}
						for k in next, SlaveSelf do
							local Slave = AllSlaves[k]
							if Slave and not Slave.dm and (block2 or not Slave.g) and (block3 or not Slave.r) then
								local SlaveId = Slave.id
								local SlaveData = SlaveData[SlaveId]
								if SlaveData and not SlaveData.isPremium and SlaveData.rarity ~= "Exclusive" then
									local uid = Slave.uid
									if block3 then
										softoverride = uid
										break
									end
									local Type = Types[SlaveId] or {
										ID = SlaveId
									}
									Types[SlaveId] = Type
									Type[1 + #Type] = uid
								end
							end
						end
						if next(Types) or softoverride then
							local Candidates = {}
							if not softoverride then
								for k, v in next, Types do
									if not v or #v < 6 then
										Types[k] = (table_clear(v) and nil) or nil
									else
										v.ID = nil
										Candidates[1 + #Candidates] = v
									end
								end
							else
								Candidates[1] = {softoverride}
							end
							if #Candidates > 0 then
								if not block3 then
									table_sort(Candidates, Sort)
								end
								Candidates = {unpack(Candidates[1], 1, 6)}
								if Libraryflags[flagname] and #Candidates == ((block3 and 1) or 6) then
									pcall(NetworkInvoke, networkString, Candidates)
									wait(0.5)
								end
							end
						else
							if not Wait(2) then
								return
							end
						end
					end
				end
			end
		})
	end
	do
		local getostime = nil
		do
			local cahced = nil
			local cachetime = 0
			local nan = tonumber("nan")
			function getostime()
				if not cahced or not cachetime then
					for _ = 1, 5 do
						local succ, val = pcall(NetworkInvoke, "Get OSTime")
						if succ and val then
							cachetime = time()
							cahced = val
							return val
						elseif not Wait(0.15) then
							return 0
						end
					end
				else
					return cahced + (time() - cachetime)
				end
				return nan
			end
		end
		local os_clock = os.clock
		EggSection:AddToggle({
			Name = "Redeem Dark Matter Pets",
			Flag = "redeemdarkmatterm",
			Callback = function(x)
				if x then
					while not GetSaveData and Wait(1) do
					end
					while Wait(0.1) and Libraryflags.redeemdarkmatterm do
						local SaveData = GetSaveData()
						for slave_tag, slave_stats in next, SaveData.DarkMatterQueue.__self do
							if not Wait(((((rawget(slave_stats, "readyTime") + 60) - (getostime() + (os_clock() - time()))) <= 1) and NetworkInvoke("Redeem Dark Matter Pet", slave_tag) and 1) or 0.1) then
								return
							end
						end
					end
				end
			end
		})
	end
end
local PlayerSection = FarmingTab:CreateSection({
	Name = "Player Settings",
	Side = "Right"
})
local function GetHuman()
	local h = LP.Character
	h = h and (h:FindFirstChild("Humanoid") or h:FindFirstChildWhichIsA("Humanoid"))
	return h or workspace.CurrentCamera.CameraSubject
end
PlayerSection:AddToggle({
	Name = "Set Walk Speed",
	Flag = "usewalkspeed",
	Callback = function(x)
		if x then
			local h = GetHuman()
			local oldws = h and h.WalkSpeed
			if oldws then
				pcall(function()
					h.WalkSpeed = Libraryflags.walkspeed or oldws or 16
					while Wait(0.1) and Libraryflags.usewalkspeed do
						h.WalkSpeed = Libraryflags.walkspeed or oldws or 16
					end
				end)
				h.WalkSpeed = oldws or 16
			end
		end
	end
})
PlayerSection:AddSlider({
	Name = "Speed",
	Flag = "walkspeed",
	Min = 0,
	Max = 128,
	Value = 48,
	Textbox = true,
	Format = "Walking Speed: %s",
	IllegalInput = true
})
PlayerSection:AddToggle({
	Name = "Set Jump Power",
	Flag = "usejumppower",
	Callback = function(x)
		if x then
			local h = GetHuman()
			local oldjp = h and h.JumpPower
			if oldjp then
				pcall(function()
					h.JumpPower = Libraryflags.jumppower or oldjp or 50
					while Wait(0.1) and Libraryflags.usejumppower do
						h.JumpPower = Libraryflags.jumppower or oldjp or 50
					end
				end)
				h.JumpPower = oldjp or 50
			end
		end
	end
})
PlayerSection:AddSlider({
	Name = "Power",
	Flag = "jumppower",
	Min = 0,
	Max = 256,
	Value = 60,
	Textbox = true,
	Format = "Jumping Power: %s",
	IllegalInput = true
})
PlayerSection:AddButton({
	Name = "TP to Pet",
	Callback = function()
		if lastcoin then
			workspace.CurrentCamera.CameraSubject.RootPart.CFrame = CFrame.new(Vector3:new(lastcoin.Size.Y + 3.5) + lastcoin.Position)
		end
	end
})
FarmingTab:CreateSection({
	Name = "Profiles"
}):AddPersistence({
	Name = "Save & Load",
	Workspace = "Petsi-X",
	Suffix = "File",
	Flags = 2
}).Parent:AddLabel(("Version: %s"):format(petsiversion))
do
	local vu = game:GetService("VirtualUser")
	local vn = Vector2.new()
	local afk = nil
	if not getconnections or type(getconnections) ~= "function" or not next(getconnections(LP.Idled) or {}) then
		afk = LP.Idled:Connect(function()
			vu:Button2Down(vn)
			wait(0.15)
			vu:Button2Up(vn)
		end)
	else
		local connections = {}
		for _, v in next, getconnections(LP.Idled) do
			if v.State then
				v:Disable()
				connections[v] = 1
			end
		end
		afk = {
			Disconnect = function()
				for s in next, connections do
					s:Enable()
				end
			end
		}
	end
	function Library.UnloadCallback()
		Library.ResetAll()
		afk = (afk and afk:Disconnect() and nil) or nil
	end
end
if shared.debugmode then
	local stuff = {}
	for k, v in next, {debug.info(1, "slna")} do
		v = tostring(v)
		if #v > 0 then
			stuff[1 + #stuff] = string.format("%s-%s", (k == 1 and "S") or (k == 2 and "L") or (k == 3 and "N") or ((k == 4 or k == 5) and "A") or tostring(k), v)
		end
	end
	stuff[1 + #stuff] = string.format("Func: 0x%x", tonumber(string.match(tostring(debug.info(1, "f")), "0x%x+")))
	local dat = debug.traceback(table.concat(stuff, "\n"))
	warn(dat)
	pcall(pcall, setclipboard, dat)
end
