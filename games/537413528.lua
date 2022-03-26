
local menu = ngstloader:AddMenu("AutoFarm")
menu = menu:AddTab("General")
 -- Services
local TweenService = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local delay = 3
local toggle = false

local function Farm()
    if not toggle then return end
    spawn(function()
        local part = plr.Character.HumanoidRootPart
        TweenService:Create(part,TweenInfo.new(0.25),{CFrame = CFrame.new(-47.542923, 54.6088257, 250.486557, -0.999938786, 8.84945257e-05, 0.0110667115, -8.72156747e-09, 0.999968052, -0.00799699314, -0.0110670654, -0.00799650326, -0.999906778)}):Play()
        wait(0.25)
        TweenService:Create(part,TweenInfo.new(10),{CFrame = CFrame.new(-55.6942902, 49.5068893, 8545.71973, -0.999928236, 0.000995930051, -0.0119377384, 9.57954516e-09, 0.996538103, 0.0831374153, 0.0119792102, 0.0831314474, -0.996466577)}):Play()
        wait(10)
        TweenService:Create(part,TweenInfo.new(1),{CFrame = CFrame.new(-55.6263809, -357.989746, 9490.38965, -0.0730219856, 1.28200156e-07, -0.997330308, -4.29345391e-07, 1, 1.59978896e-07, 0.997330308, 4.39881148e-07, -0.0730219856)}):Play()
        wait(1)
    end)
end

getgenv().CharacterAddedlel = plr.CharacterAdded:Connect(function()
    wait(delay)
    Farm()
    
end)

menu:CreateToggle({name="AutoFarm",state=toggle},function(_)
    toggle = _
    Farm()
    
end)

menu:CreateSlider({name="Delay",min=1,def=delay,max=30},function(_)
    delay = _ 
end)

