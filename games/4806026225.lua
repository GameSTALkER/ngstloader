-- Defender's Depot

-- settings
_G.autoGrabCrate = true

-- vars
local me = game.Players.LocalPlayer
local Main = me.PlayerGui.MainGui.Frame

spawn(function()
    while true do
        wait(5)
        Main.Results:TweenSize(UDim2.new(0,0,0,0),"InOut","Sine",.5)
        Main.InsufficientFunds:TweenSize(UDim2.new(0,0,0,0),"InOut","Sine",.5)
        me.PlayerGui.CrateGui.Enabled = false
        me.PlayerGui.PowerUpGui.Frame:TweenSize(UDim2.new(.22,0,1,0),"InOut","Sine",.5)
    end
end)

-- apply gamepasses
for i,v in pairs(me:WaitForChild("Info"):WaitForChild("Gamepasses"):GetDescendants()) do
    if v.Value == false then v.Value = true end
end

-- crate grabber
local player = game.Players.LocalPlayer.Character.HumanoidRootPart
if _G.autoGrabCrateInt == nil then _G.autoGrabCrateInt = 0 end
if _G.autoGrabCrate then _G.autoGrabCrateInt = _G.autoGrabCrateInt + 1 end
spawn(function()
    while _G.autoGrabCrate do
        wait(1)
        local num = true
        for i,v in ipairs(game.Workspace:GetChildren()) do
            if v.Name == "Basic" and _G.autoGrabCrate then
                num = false
                v.CanCollide = false
                v.CFrame = player.CFrame
                wait(.5)
                
            elseif not _G.autoGrabCrate or _G.autoGrabCrateInt > 1 then
                _G.autoGrabCrateInt = _G.autoGrabCrateInt - 1
                break
                
            end
        end
    end
end)
