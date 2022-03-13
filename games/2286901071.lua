-- Cube Defence - Lobby

local bmain = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/synapse.luas/main/UiLibs/GUiLibRewrite.lua"))():CreateWin("Cube Defence","Lobby.nmMzP8vv2q")

local gmain = bmain:CreateTab({name="General"})
local ginfo = bmain:CreateTab({name="Info"})

local scriptvar = {}
local me = game.Players.LocalPlayer

local teleportpanel = {}

teleportpanel['deftp'] = gmain:CreateList({btn={"Spawn","Tower Shop","Skin Shop","Secret Skin Shop","Trial of Xovuso","NIGHTMARE 50+"}, oncreate=false, desc="Teleport to place..."}, function(_) 
    teleportpanel['deftp']:Change({desc="Selected: ".._})
    local pos
    if _ == "Spawn" then pos = CFrame.new(24.2095222, 36.1979942, 391.402924, 0.999994993, -5.37788614e-09, 0.0031623682, 5.52792168e-09, 1, -4.74352078e-08, -0.0031623682, 4.74524526e-08, 0.999994993)
    elseif _ == "Tower Shop" then pos = CFrame.new(-142.904877, -127.100929, 283.737213, 0.658367217, 7.3587664e-08, 0.752696931, -3.00176684e-09, 1, -9.51397467e-08, -0.752696931, 6.03774666e-08, 0.658367217)
    elseif _ == "Skin Shop" then pos = CFrame.new(269.159119, -127.000984, 362.294464, 0.770384729, 6.37920294e-08, -0.637579322, -1.26895761e-09, 1, 9.85202036e-08, 0.637579322, -7.50894031e-08, 0.770384729)
    elseif _ == "Secret Skin Shop" then pos = CFrame.new(1196.22681, -336.001007, 1163.58032, 0.791624188, 6.36473843e-08, 0.611008286, -7.24000415e-08, 1, -1.03660787e-08, -0.611008286, -3.60309862e-08, 0.791624188)
    elseif _ == "Trial of Xovuso" then pos = CFrame.new(-16783.9121, 28.9962368, 441.417725, 0.504641891, 5.68074405e-08, 0.863328755, -6.37242648e-10, 1, -6.5427983e-08, -0.863328755, 3.2467554e-08, 0.504641891)
    elseif _ == "NIGHTMARE 50+" then pos = CFrame.new(15565.2812, 677.557617, 321.335419, 0.695368648, 2.08851159e-08, -0.718653262, 1.99942765e-08, 1, 4.84079195e-08, 0.718653262, -4.80303015e-08, 0.695368648)
    end
    me.Character.HumanoidRootPart.CFrame = pos
end)

if game:GetService("ReplicatedStorage").ChristmasEventOpen.Value then
    local _TEMP = {"Skin Shop","Path 1","Path 2","Path 3","Path 4","Path 5","Winter Trial"}
    teleportpanel['eventtp'] = gmain:CreateList({btn=_TEMP, oncreate=false, desc="Christmas Event Teleports"}, function(_) 
        teleportpanel['eventtp']:Change({desc="Selected: ".._})
        if _ == "Skin Shop" then pos = CFrame.new(-9.08201408, 57.7167625, -2254.44287, 0.573815048, -4.6741949e-08, 0.818984926, 2.76135133e-08, 1, 3.77258473e-08, -0.818984926, 9.67391833e-10, 0.573815048)
        elseif _ == "Path 1" then pos = CFrame.new(834.571838, 57.4042435, -2768.14795, -0.999994159, -9.98157077e-08, 0.00342297251, -9.99762904e-08, 1, -4.67423327e-08, -0.00342297251, -4.70842743e-08, -0.999994159)
        elseif _ == "Path 2" then pos = CFrame.new(-1359.50647, 65.6686935, -3846.58374, 0.866283119, 6.4766482e-08, 0.499553323, -8.18625026e-08, 1, 1.23102408e-08, -0.499553323, -5.1558839e-08, 0.866283119)
        elseif _ == "Path 3" then pos = CFrame.new(810.937805, 57.3886185, -3302.98682, 0.999992847, -1.56482329e-08, 0.00378600112, 1.54769513e-08, 1, 4.52701521e-08, -0.00378600112, -4.52112339e-08, 0.999992847)
        elseif _ == "Path 4" then pos = CFrame.new(24.7394352, 57.6667442, -2904.50195, 0.999919832, 8.39330649e-09, -0.0126640247, -7.81787524e-09, 1, 4.54877274e-08, 0.0126640247, -4.53850753e-08, 0.999919832)
        elseif _ == "Path 5" then pos = CFrame.new(107.039169, 477.861206, -5041.98438, 0.999995291, 1.04705677e-09, 0.00306565012, -7.8215262e-10, 1, -8.64116245e-08, -0.00306565012, 8.64088179e-08, 0.999995291)
        elseif _ == "Winter Trial" then pos = CFrame.new(77.3250504, -73.1619873, -6784.30713, -0.500025392, 5.92606808e-09, 0.866010725, -1.78214399e-09, 1, -7.87194132e-09, -0.866010725, -5.47952617e-09, -0.500025392)
        end
        me.Character.HumanoidRootPart.CFrame = pos
    end)
end

gmain:CreateInput({desc="Inviter Name",text=""}, function(_) scriptvar["InviterName"] = _ end)
gmain:CreateList({btn={"Placed Name","Friends"}, desc="Accepting from..."}, function(_) scriptvar["AcceptigTypes"] = _ end)
gmain:CreateToggle({name="Accept invite", desc="Auto accept invite"}, function(_)
    scriptvar["Toggle1"] = _
    if scriptvar["Toggle1"] then
        spawn(function()
            while wait(3) do
                if not scriptvar["Toggle1"] then break end
                if scriptvar["AcceptigTypes"] == "Placed Name" then
                    game:GetService("ReplicatedStorage").Events.SendPartyInviteEvent:FireServer(unpack({[1] = scriptvar["InviterName"]}))
                elseif scriptvar["AcceptigTypes"] == "Friends" then
                    for i,v in pairs(game.Players:GetChildren()) do
                        if v:IsFriendsWith(me.UserId) then
                            game:GetService("ReplicatedStorage").Events.SendPartyInviteEvent:FireServer(unpack({[1] = v.Name}))
                        end
                    end
                end
            end
        end)
    end
end)

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
