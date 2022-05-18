-- Ragdoll Engine 

local menu = getgenv().ngstloader:AddMenu("Ragdoll Engine")
local tab1 = menu:AddTab("General")

btn = {[1]=nil,[2]=nil}

local plr = game:GetService("Players").LocalPlayer

btn[1] = tab1:CreateToggle({name="Toggle Ragdoll",exec=true},function(state)
    local rg = plr.Character:FindFirstChild("RagdollMe")
    local rg1 = plr.Character:FindFirstChild("StartRagdoll")
    
    if rg ~= nil and rg1 ~= nil then
        rg.Disabled = not state
        rg1.Disabled = not state
    else
        btn[1]:Change({name="Reset character",state=false})
        wait(1)
        btn[1]:Change({name="Toggle Ragdoll"})
    end
    
end)
btn[2] = tab1:CreateToggle({name="Toggle FirstPerson",exec=true}, function(state)
    local fp = plr.Character:FindFirstChild("FirstPerson")
    
    if fp ~= nil then
        fp.Disabled = not state
    else
        btn[2]:Change({name="Reset character",state=false})
        wait(1)
        btn[2]:Change({name="Toggle FirstPerson"})
    end
end)
tab1:CreateSlider({name = "WalkSpeed",min=1,def=16},function(_)
    plr.Character.Humanoid.WalkSpeed = _
    
end)
