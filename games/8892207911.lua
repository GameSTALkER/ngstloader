-- Ragdoll Engine 

local menu = getgenv().ngstloader:AddMenu("Ragdoll Engine")
local tab1 = menu:AddTab("General")

local plr = game:GetService("Players").LocalPlayer

tab1:CreateToggle({name="Toggle Ragdoll",exec=true},function(state)
    for i,v in pairs(plr.Character:GetChildren()) do
        if (v.ClassName == "LocalScript" or v.ClassName == "Script") and v.Name == "RagdollMe" then 
            v.Disabled = not state
            
        end
        
    end
    
end)
tab1:CreateSlider({name = "WalkSpeed",min=1,def=16},function(_)
    plr.Character.Humanoid.WalkSpeed = _
    
end)
