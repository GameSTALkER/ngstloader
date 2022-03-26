-- Tower of Hell

local gui = ngstloader:AddMenu("ToHell")
gui = gui:AddTab("General")
-- Services
local TweenService = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
-- vars
if getgenv().ToHellVars == nil then getgenv().ToHellVars = {gm=false,dae=false} end

local function TpToFin()
    isteleporting = true
    plr.Character:WaitForChild("KillScript").Disabled = true
    TweenService:Create(plr.Character.HumanoidRootPart,TweenInfo.new(3),{CFrame = game:GetService("Workspace"):WaitForChild("tower").sections.finish.FinishGlow.CFrame}):Play()
    wait(3)
    plr.Character:WaitForChild("KillScript").Disabled = getgenv().ToHellVars.gm
    isteleporting = false
    
end

local isteleporting = false
gui:CreateButton({name="Tp to finish"},function()
    if isteleporting then return end
    TpToFin()
    
end)
gui:CreateToggle({name="GodMode",state=getgenv().ToHellVars.gm,exec=true},function(_)
    if isteleporting then return end
    getgenv().ToHellVars.gm = _
    plr.Character:WaitForChild("KillScript").Disabled = _
    
end)
gui:CreateToggle({name="Disable Annoying events",state=getgenv().ToHellVars.dae,exec=true,desc="Disables: 'Bunnyhop' event"},function(_)
    if isteleporting then return end
    getgenv().ToHellVars.dae = _
    plr.Character:WaitForChild("bunnyJump").Disabled = _
    
end)

-- return all on spawn
if getgenv().deathplayer_con ~= nil then getgenv().deathplayer_con:Disconnect() end
getgenv().deathplayer_con = plr.CharacterAdded:Connect(function()
    plr.Character:WaitForChild("KillScript").Disabled = getgenv().ToHellVars.gm
    plr.Character:WaitForChild("bunnyJump").Disabled = getgenv().ToHellVars.dae

end)
