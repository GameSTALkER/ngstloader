-- Cube Defense - Match

local scriptvars = {}

local bmain = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/UIs/DarkGUi.lua"))():CreateWin("Cube Defence","Match.nmMzP8vv2q")
local main = bmain:CreateTab({name="General"})
local afkmain = bmain:CreateTab({name="AFK"})
local towermain = bmain:CreateTab({name="Towers"})
local ginfo = bmain:CreateTab({name="Info"})

local assets = {t = {F = 8, O = 2}, minCash = 250,color={bad='#bfbfbf',normal='#db8400',good='#c70000',op='#ff00e1',support='#0900b8',cash="#07c700",unknown="#919191"}} -- F - factories, O - Oils

local me = game:GetService("Players").LocalPlayer
local Mouse = me:GetMouse()
local myPart = game.Workspace[me.Name].HumanoidRootPart

local sTween = game:GetService("TweenService")

local function getCashValue()
    local cashVal = me.MainStats.Cash.Value
    return tonumber(cashVal)
end
local function gettowerY(name) -- offsets for 'any tower placement'
    if table.find({"Golden Light Turret","Light Turret","Bubble Tower","Plantation","Wall","Heavy Turret","Gold Mine","Santa's Sleigh","Missile Launcher"},name) then return 1.98
    elseif table.find({"Plasma Tower","Campfire","Rail Minigun","Sea Battery","Railgun","Mounted Flame Thrower","Orbital Satellite","Battleship"},name) then return 3.3
    elseif table.find({"Jolly Gatling","Frost Rail"},name) then return 3.2
    elseif table.find({"Glue Gun","Golden Glue Gun"},name) then return 4.62
    elseif table.find({"Poseidon's Tomb","Bucket"},name) then return 3
    elseif table.find({"Spike Trap","Gold Spike Trap"},name) then return 1.06
    elseif name == "Enhancer" then return 3.6
    elseif name == "Star of Xovuso" then return 2.04
    elseif name == "Sun Temple" then return 6.85755
    elseif name == "Orbital Cannon" then return 5.35
    elseif name == "Mortar" then return 1.855
    elseif name == "Lord Xovuso" then return 2.62
    elseif name == "Sun Temple MK2" then return 4.17382
    elseif name == "Garrison" then return 2.08
    elseif name == "Shocker" then return 2.12187
    elseif name == "Mounted Minigun" then return 2.8
    elseif name == "Blade Spinner" then return 2
    elseif name == "Egg Fabricator" then return 2.29049
    elseif name == "Factory" then return 4.29503
    elseif name == "Anti Cube Defense" then return 3.75
    elseif name == "Oil Rig" then return 6.45889
    elseif name == "Stealth Bomber" then return 0.78
    elseif name == "Submarine" then return 1.06624
    elseif name == "Defabricator" then return 2.775
    elseif name == "Dat Ice" then return 0.62
    elseif name == "Pool" then return 1.52784
    elseif name == "Haunted Manor" then return 6.72
    elseif name == "Pumpkin Launcher" then return 3.42
    elseif name == "Blazefall" then return 6.2
    elseif name == "Raft" then return 1.76584
        
    --elseif table.find({""},name) then return 
    else return 0
    end
end
local function gettowerCol(name)
    if table.find({"Light Turret","Plasma Tower","Bubble Tower","Sea Battery","Egg Fabricator"},name) then return assets.color.bad -- bad 
    elseif table.find({"Heavy Turret","Mounted Minigun","Shocker","Battleship","Stealth Bomber","Missile Launcher","Mounted Flame Thrower","Santa's Sleigh","Mortar","Jolly Gatling","Blade Spinner"},name) then return assets.color.normal -- normal
    elseif table.find({"Railgun","Frost Rail","Submarine","Orbital Cannon", "Garrison","Poseidon's Tomb","Anti Cube Defence","Lord Xovuso","Sun Temple"},name) then return assets.color.good -- good
    elseif table.find({"Rail Minigun","Star of Xovuso","Orbital Satellite","Sun Temple MK2","Golden Light Turret"},name) then return assets.color.op -- OP
    elseif table.find({"Defabricator","Raft","Pool","Glue Gun","Enhancer","Dat Ice","Wall","Gold Spike Trap","Spike Trap","Golden Glue Gun","Campfire"},name) then return assets.color.support -- support
    elseif table.find({"Factory","Plantation","Oil Rig","Gold Mine","Bucket"},name) then return assets.color.cash -- cash
    else return assets.color.unknown
    end
end
local function gettowertoupg()
    local obj = Mouse.Target
    if obj.Parent.Name == "Towers" and obj.ClassName == "Model" then
        return obj
    elseif obj.Parent.Parent.Name == "Towers" and obj.Parent.ClassName == "Model" then
        return obj.Parent
    elseif obj.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.ClassName == "Model" then
        return obj.Parent.Parent
    elseif obj.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.ClassName == "Model" then
        return obj.Parent.Parent.Parent
    elseif obj.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.ClassName == "Model" then
        return obj.Parent.Parent.Parent.Parent
    elseif obj.Parent.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.Parent.ClassName == "Model" then
        return obj.Parent.Parent.Parent.Parent.Parent
    elseif obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.Parent.Parent.ClassName == "Model" then
        return obj.Parent.Parent.Parent.Parent.Parent.Parent
    elseif obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent.ClassName == "Model" then
        return obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent
    end
end
local iueasehfoa
local sfdjlasdg = false
iueasehfoa = main:CreateToggle({name="Cash collector", desc="Automaticly collects cash"}, function(_)
    scriptvars["ACC1"] = _
    if scriptvars["ACC1"] and not sfdjlasdg then
        spawn(function()
            while wait() do
                local _TEMP = false
                for i,v in pairs(game.Workspace:GetChildren()) do
                    if scriptvars["ACC1"] and v.Name == "CashDrop" then -- money collector
                        if (v.Position - myPart.Position).magnitude <= 20 then
                            sTween:Create(v,TweenInfo.new(.12),{CFrame = myPart.CFrame}):Play()
                            if iswindowactive then
                                if iswindowactive() then _TEMP = true
                                else wait(.1);fireproximityprompt(v:FindFirstChild("ProximityPrompt"), 3) end
                            elseif fireproximityprompt then wait(.1);fireproximityprompt(v:FindFirstChild("ProximityPrompt"), 3)
                            elseif keypress and keyrelease then keypress(0x46);wait(.12);keyrelease(0x46) 
                            else iueasehfoa:Change({name="Unsupported on your executor :(",state=false});sfdjlasdg=true;break end
                        end
                    elseif not scriptvars["ACC1"] then break end
                end
                if _TEMP then keypress(0x46);wait(.12);keyrelease(0x46) end
            end
        end)
    end
end)
main:CreateBind({name="Bind", desc="Upgrade Tower"}, function()
	local obj = gettowertoupg()
    if obj.Settings.TowerValues.Owner.Value == me.Name then
        game:GetService("ReplicatedStorage").Events:FindFirstChild("Upgrade Structure"):InvokeServer(unpack({[1] = obj}))
    end
end)
main:CreateBind({name="Bind", desc="Sell Tower"}, function()
	local obj = gettowertoupg()
    if obj.Settings.TowerValues.Owner.Value == me.Name and tostring(me.PlacingTowerName.Value) == '' then 
        game:GetService("ReplicatedStorage").Events:FindFirstChild("Sell Structure"):FireServer(unpack({[1] = obj}))
    end
end)

main:CreateBind({name="Bind", loop=true, desc="Drop Cash"}, function(Key, _) 
    if _ == 1 then
        game:GetService("ReplicatedStorage").Events.CashDropEvent:FireServer() 
    elseif _ > 12 then 
        game:GetService("ReplicatedStorage").Events.CashDropEvent:FireServer() 
    end

end)
local CRTLDEL = nil
main:CreateToggle({name="Ctrl Del", state=_G.CtrlDelete, desc="Delete object (Ctrl + MouseButton1)"}, function(_)
    scriptvars["CTRLDEL1"] = _
    if scriptvars["CTRLDEL1"] then
		CRTLDEL = Mouse.Button1Down:connect(function() -- ctrl del
			if scriptvars["CTRLDEL1"] then
				if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
				if not Mouse.Target then return end
				Mouse.Target:Destroy()
			end
		end)
	else CRTLDEL:Disconnect() end
end)
scriptvars["2o3wieth"] = main:CreateList({btn={"Gold Coins"}, multi=true, desc="Automaticly collects items"}, function(_)
	-- common things
    scriptvars["AIGC1"] = table.find(_,"Gold Coins")
    if scriptvars["AIGC1"] then
        spawn(function()
            while wait() do
                for i,v in pairs(game.Workspace.Map.Misc:GetChildren()) do
                    if v.Name == "GoldCoin" and scriptvars["AIGC1"] then
                        sTween:Create(v,TweenInfo.new(.12),{Position = myPart.Position}):Play()
                    elseif not scriptvars["AIGC1"] then break end
                end
            end
        end)
    end
    -- events
    if game:GetService("ReplicatedStorage").ChristmasEventOpen.Value == true then
        scriptvars["AIG1"] = table.find(_,"Christmas Presents")
        if scriptvars["AIG1"] then
            spawn(function()
                while wait() do
                    for i,v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "EventChallengePresent" and scriptvars["AIG1"] then
                            v.CanCollide = false
                            sTween:Create(v,TweenInfo.new(.12),{Position = myPart.Position}):Play()
                        elseif not scriptvars["AIG1"] then break end
                    end
                end
            end)
        end
    end
end)
if game:GetService("ReplicatedStorage").ChristmasEventOpen.Value == true then scriptvars["2o3wieth"]:Change({add={"Christmas Presents"}}) end

main:CreateToggle({name="Auto collect", desc="Auto collect item from killed boss"}, function(_)
    scriptvars["ACK1"] = _
    if scriptvars["ACK1"] then
        spawn(function()
            while wait(3) do 
                if not scriptvars["ACK1"] then break end
                for i,v in pairs(game.Workspace:GetChildren()) do
                    if string.find(v.Name,"Key") then
                        sTween:Create(v.Base,TweenInfo.new(.12),{Position = myPart.Position}):Play()
                        break
                    end
                end
            end
        end)
    end
end)

afkmain:CreateToggle({name="Auto Drop Cash", state=false, cfg=false, desc="Automaticly dropping cash"}, function(_)
    scriptvars["ADC1"] = _
    spawn(function()
        while wait() do 
            if scriptvars["ADC1"] and getCashValue() > (assets.minCash - 1) then
                game:GetService("ReplicatedStorage").Events.CashDropEvent:FireServer()
            elseif not scriptvars["ADC1"] then break end
        end
    end)
end)
afkmain:CreateInput({text="Place name", desc="Place Cash receiver name"}, function(_)
    scriptvars["CashReceiver"] = _
end)
afkmain:CreateToggle({name="Chase",state=false,cfg=false,desc="Chase the cash receiver"}, function(_)
    scriptvars["ChasingTarget"] = _
    local oldpos = myPart.CFrame
    if scriptvars["ChasingTarget"] then
        spawn(function()
            while wait() do
                if not scriptvars["ChasingTarget"] then break end
                if getCashValue() > (assets.minCash - 1) then
                    local tpMe = game.Players.LocalPlayer.Character.Humanoid
                    local function _TEMPTEL(sec,to)
                        spawn(function()
                            local gg = sTween:Create(myPart,TweenInfo.new(sec),{CFrame = to}):Play()
                            wait(sec+0.1)
                            game:GetService("ReplicatedStorage").Events.CashDropEvent:FireServer()
                        end)
                    end
                    repeat _TEMPTEL(.1,game.Players[scriptvars["CashReceiver"]].Character.HumanoidRootPart.CFrame);wait() until getCashValue() < 250 or scriptvars["ChasingTarget"] == false
                    _TEMPTEL(.1,oldpos)
                end
            end
        end)
    end
end)

local mytowers = {}
local btntowers = {}
for i,v in pairs(me.MainData.Towers:GetChildren()) do
    local text = ""
    if gettowerY(v.Name) == 0 then text = " (no asset)" end
    table.insert(btntowers, "<font color='"..gettowerCol(v.Name).."'>"..v.Name..text.."</font>")
	table.insert(mytowers, v.Name)
end
for i,v in pairs(me.PlayerGui.MainHUD.MainFrame.SlotFrame:GetChildren()) do
    if v.ClassName ~= "UIListLayout" and v:FindFirstChild("InsertedBox") then
        local remt = v.InsertedBox.Icon.ViewportImage:GetChildren()[1].Name
        local tnum = 0
        for i,v in pairs(mytowers) do
            tnum = tnum + 1
            if string.find(v,remt) then
                table.remove(mytowers,tnum)
                table.remove(btntowers,tnum)
            end
        end
    end
end
local selectedtower = nil
local rotationtower = 0
scriptvars["u2qnfdi"] = towermain:CreateList({btn=btntowers, desc="Choose Tower..."}, function(_) 
    local name = _
    if string.find(name,assets.color.bad) then name = name:gsub("%<font color='"..assets.color.bad.."'>", "")
    elseif string.find(name,assets.color.normal) then name = name:gsub("%<font color='"..assets.color.normal.."'>", "")
    elseif string.find(name,assets.color.good) then name = name:gsub("%<font color='"..assets.color.good.."'>", "")
    elseif string.find(name,assets.color.op) then name = name:gsub("%<font color='"..assets.color.op.."'>", "")
    elseif string.find(name,assets.color.support) then name = name:gsub("%<font color='"..assets.color.support.."'>", "")
    elseif string.find(name,assets.color.cash) then name = name:gsub("%<font color='"..assets.color.cash.."'>", "")
    elseif string.find(name,assets.color.unknown) then name = name:gsub("%<font color='"..assets.color.unknown.."'>", "") end
    name = name:gsub("%</font>", "")
    selectedtower = name
    scriptvars["u2qnfdi"]:Change({desc="Choosen: "..tostring(_)})
end)
towermain:CreateBind({name="Place Key", desc="Bind + MousePos to place selected tower"}, function()
	local Y = me:GetMouse().Hit.Position + Vector3.new(0,gettowerY(selectedtower) / 2 - 0.09,0)
	game:GetService("ReplicatedStorage").Events:FindFirstChild("Place Structure"):FireServer(unpack({[1] = selectedtower,[2] = Y,[3] = rotationtower}))
end)
towermain:CreateSlider({min=0, def=0, max=3, cfg=false, desc="Tower Rotation"}, function(_) rotationtower = _ end)

local infopanel = {}
local Onlplayers = {}
local text = ""
for i,v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(Onlplayers,v.Name)
end
infopanel["playerselector"] = ginfo:CreateList({btn=Onlplayers, cfg=false, desc="Choose player"}, function(_) 
    Onlplayers = {}
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(Onlplayers,v.Name)
    end
    infopanel["playerselector"]:Change({remove="all",add=Onlplayers,desc="Selected: ".._.." ("..game:GetService("Players")[_].MainData.Data.Level.Value..")"})
    local ownt = ""
    local thow = 0
    for i,v in pairs(game:GetService("Players")[_].MainData.Towers:GetChildren()) do
        thow = thow + 1
        ownt = ownt .. v.Name .. "\n"
    end
    local oaiwef = ""
    local isoedg = 0
    for i,v in pairs(game:GetService("Players")[_].MainData.Data:GetChildren()) do
        isoedg = isoedg + 1
        oaiwef = oaiwef .. v.Name .. ": " .. tostring(v.Value) .. ";\n\n"
    end
    if game.PlaceId == 2286901071 then
        local qwra
        if game:GetService("Players")[_].CurrentParty.Value == "" then qwra = 'false*' else qwra = game:GetService("Players")[_].CurrentParty.Value end
        infopanel["CPatry"]:Change({desc=qwra})
    end
    local dasgweoag = game:GetService("Players")[_].MainData.Data.EasyWins.Value + game:GetService("Players")[_].MainData.Data.MediumWins.Value + game:GetService("Players")[_].MainData.Data.HardWins.Value + game:GetService("Players")[_].MainData.Data.ChaosWins.Value + game:GetService("Players")[_].MainData.Data.NightmareWins.Value + game:GetService("Players")[_].MainData.Data.CompetitiveWins.Value
    infopanel["OWTowers"]:Change({fdesc = ownt,desc="Have "..thow.." towers"})
    infopanel["MoneyInfo"]:Change({desc='$'..game:GetService("Players")[_].MainData.Data.Gold.Value})
    infopanel["MintInfo"]:Change({desc=tostring(game:GetService("Players")[_].MainData.Data.Mints2021.Value)})
    infopanel["Wins"]:Change({desc="Won "..dasgweoag.." times",fdesc="<font color='#00ff00'>Easy wins:</font> "..game:GetService("Players")[_].MainData.Data.EasyWins.Value.."\n<font color='#00aaff'>Medium wins:</font> "..game:GetService("Players")[_].MainData.Data.MediumWins.Value.."\n<font color='#ff5500'>Hard wins:</font> "..game:GetService("Players")[_].MainData.Data.HardWins.Value.."\n<font color='#ff0000'>Chaos wins:</font> "..game:GetService("Players")[_].MainData.Data.ChaosWins.Value.."\n<font color='#cc00ff'>NIGHTMARE wins:</font> "..game:GetService("Players")[_].MainData.Data.NightmareWins.Value.."\n<font color='#0046af'>Competitive wins:</font> "..game:GetService("Players")[_].MainData.Data.CompetitiveWins.Value})
    infopanel["rawdata"]:Change({desc=isoedg.." items in raw-data",fdesc=oaiwef})
end)
if game.PlaceId == 2286901071 then infopanel["CPatry"] = ginfo:CreateLabel({text="In Party",desc="select player^"}) end
infopanel["MoneyInfo"] = ginfo:CreateLabel({text="Gold",desc="select player^"})
infopanel["MintInfo"] = ginfo:CreateLabel({text="Mints2021",desc="select player^"})
infopanel["Wins"] = ginfo:CreateLabel({text="Wins",desc="select player^"})
infopanel["OWTowers"] = ginfo:CreateLabel({text="Owned Towers",desc="select player^"})
infopanel["rawdata"] = ginfo:CreateLabel({text="Raw data",desc="select player^"})
