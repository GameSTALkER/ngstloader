-- Legends Of Speed

local me = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart


if _G.HoopFarm then _G.HoopFarm = false; wait(1) end
if _G.OrbFarm then _G.OrbFarm = false; wait(1) end
if _G.GemFarm then _G.GemFarm = false; wait(1) end
if _G.AutoRebirth then _G.AutoRebirth = false; wait(1) end

-- gui
local guilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/synapse.luas/main/UiLibs/GUILib.lua"))():CreateWindow("Legends Of Speed", nil)
guilib:CreateToggle('Hoop Farm', function(state)
    _G.HoopFarm = not _G.HoopFarm
    if _G.HoopFarm then
        spawn(function()
            while _G.HoopFarm do
                for i,v in pairs(game:GetService("Workspace").Hoops:GetChildren()) do
                    if not _G.HoopFarm then break end
                    firetouchinterest(v, me, 0)
                    wait()
                    firetouchinterest(v, me, 1)
                end
                wait(5)
            end
        end)
    end
end)
guilib:CreateToggle('Orb Farm', function(state)
    _G.OrbFarm = not _G.OrbFarm
    if _G.OrbFarm then
        spawn(function()
            while _G.OrbFarm do
                for i,v in pairs(game:GetService("Workspace").orbFolder:GetChildren()) do
                    for q,w in pairs(v:GetChildren()) do
                        if not _G.OrbFarm then break end
                        if table.find({"Yellow Orb","Blue Orb","Orange Orb", "Red Orb"}, w.Name) then w.outerOrb.CFrame = me.CFrame end
                        wait()
                    end
                end
                wait(5)
            end
        end)
    end
end)
guilib:CreateToggle('Gem Farm', function(state)
    _G.GemFarm = not _G.GemFarm
    if _G.GemFarm then
        spawn(function()
            while _G.GemFarm do
                for i,v in pairs(game:GetService("Workspace").orbFolder:GetChildren()) do
                    for q,w in pairs(v:GetChildren()) do
                        if not _G.GemFarm then break end
                        if w.Name == "Gem" then w.outerGem.CFrame = me.CFrame end
                        wait()
                    end
                end
                wait(5)
            end
        end)
    end
end)
guilib:CreateToggle('Auto Rebirth', function(state)
    _G.AutoRebirth = not _G.AutoRebirth
    if _G.AutoRebirth then
        spawn(function()
            while _G.AutoRebirth do
                if not _G.AutoRebirth then break end
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack({[1] = "rebirthRequest"}))
                wait(10)
            end
        end)
    end
end)
