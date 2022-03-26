-- Criminal Russia

local _gui = ngstloader:AddMenu("AutoFarm GUi")
local _works = _gui:AddTab("AutoFarm works")
_G.FarmWorks = false

local plr = game.Players.LocalPlayer
local mychar = plr.Character
local tw = game:GetService("TweenService")

_works:CreateButton({name='Выключить Фармер', desc="Выключить Фарм денег."},function() _G.FarmWorks = false end)
_works:CreateButton({name="Начать зарабатывать за Грузчика."},function()
    _G.FarmWorks = false
    repeat wait() until not mychar:FindFirstChild("Коробка") or _G.FarmWorks == false
    _G.FarmWorks = true
    while _G.FarmWorks == true do
        tw:Create(mychar.HumanoidRootPart,TweenInfo.new(.1),{CFrame = CFrame.new(250.106094, 7.70937681, -476.749908, -0.997748017, 2.4991861e-08, -0.0670735016, 2.80118613e-08, 1, -4.40847501e-08, 0.0670735016, -4.58643257e-08, -0.997748017)}):Play()
        repeat fireclickdetector(game.Workspace.BoxModel.BOXGIVE.ClickDetector, 15);wait() until mychar:FindFirstChild("Коробка") or _G.FarmWorks == false
        tw:Create(mychar.HumanoidRootPart,TweenInfo.new(.5),{CFrame = CFrame.new(255.866577, 7.78127909, -528.569946, 0.978993595, -3.60204702e-08, -0.20389092, 3.88910024e-08, 1, 1.00719255e-08, 0.20389092, -1.77898727e-08, 0.978993595)}):Play()
        repeat wait() until not mychar:FindFirstChild("Коробка") or _G.FarmWorks == false
    
    end

end)
_works:CreateButton({name="Начать зарабатывать на Заводе."},function()
    _G.FarmWorks = false
    repeat wait() until not plr.Backpack:FindFirstChild("Лом") or _G.FarmWorks == false
    _G.FarmWorks = true
    local function _temp(qq)
        if qq == nil then return false end
        for i,v in pairs(qq:GetChildren()) do 
            if v.Name == "ClickDetector" then 
                return true 
            end 
            return false 
        end 
    end
    while _G.FarmWorks == true do
        local lom = game.Workspace.JobsFolder.FactoryFolder.Parts:FindFirstChild("CrowbarPart")
        wait()
        if _temp(lom) == true then
            tw:Create(mychar.HumanoidRootPart,TweenInfo.new(.25),{CFrame = lom.CFrame}):Play()
            repeat fireclickdetector(lom.ClickDetector, 15);wait() until plr.Backpack:FindFirstChild("Лом") or _G.FarmWorks == false
            tw:Create(mychar.HumanoidRootPart,TweenInfo.new(.25),{CFrame = CFrame.new(379.710693, 8.03203773, -3970.22534, -0.999973059, 5.62270719e-09, 0.00733828871, 5.6322258e-09, 1, 1.27648225e-09, -0.00733828871, 1.31777877e-09, -0.999973059)}):Play()
            repeat fireclickdetector(game.Workspace.JobsFolder.FactoryFolder:FindFirstChild("PlacementPart").ClickDetector, 15);wait() until not plr.Backpack:FindFirstChild("Лом") or _G.FarmWorks == false
        end
        
    end

end)
