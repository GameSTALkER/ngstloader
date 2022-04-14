-- Vans World

local gui = ngstloader:AddMenu("Vans World")
gui = gui:AddTab("General")

local me = game.Players.LocalPlayer.Character.HumanoidRootPart

-- umbrella
gui:CreateButton({name="Get Umbrella"},function()
    pcall(function()
        me.CFrame = game:GetService("Workspace").Umbrella["UmbrellaGlow_Roof (2)"].CFrame
        wait(0.2)
        fireproximityprompt(game:GetService("Workspace").Umbrella["UmbrellaGlow_Roof (2)"].UmbrellaProximityPrompt, 30)
    end)
end)

-- rat
gui:CreateButton({name="Get Pigeon"},function()
    for i,v in pairs(game:GetService("Workspace").ScavengerHunt.NeverCatchPigeons:GetChildren()) do
        pcall(function() 
            if v.ClassName == "Model" then
                me.CFrame = v.Collider.CFrame
                wait(0.5)
            end 
        end)
    end
end)

