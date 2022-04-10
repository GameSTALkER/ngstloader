-- Captive: Redux

local gui = ngstloader:AddMenu("Captive")
local main = gui:AddTab("General")
local sa = gui:AddTab("Abilities")

local players = game:GetService("Players")

local function playbeastsound(name)
    for i,v in pairs(game.Players:GetChildren()) do
        for q,w in pairs(v.Character:GetChildren()) do
            if w.ClassName == "Tool" then
                w.HammerAnimating.Audios:FireServer(unpack({[1] = name}))
                break
                
            end
            
        end
        
    end
end
local function player(fire)
    for i,v in pairs(players:GetChildren()) do
        if v.Name ~= players.LocalPlayer.Name then
            if fire == "RagdollPlr" then
                game:GetService("ReplicatedStorage").ProjectGemma.Remotes.ragdollEvent:FireServer(unpack({[1] = "RagdollPlr",[2] = v.Name}))
            elseif fire == "RopePlr" then
                game:GetService("ReplicatedStorage").ProjectGemma.Remotes.ragdollEvent:FireServer(unpack({[1] = "RopePlr",[2] = v.Name}))
            elseif fire == "FreezePlayer" then
                game:GetService("ReplicatedStorage").ProjectGemma.Remotes.rEvent:FireServer(unpack({[1] = "FreezePlayer",[2] = v.Name})) 
            end
        end
    end
    
end
local function iambeast()
    for i,v in pairs(players.LocalPlayer.Character:GetChildren()) do
        if v.ClassName == "Tool" then
            return true
            
        end
        
    end
    return false
end

-- for all
main:CreateBind({loop=true,name="Instant open the door",key="F"},function(_,tick)
    if tick == 1 then
        game:GetService("ReplicatedStorage").ProjectGemma.Remotes.rEvent:FireServer(unpack({[1] = "DoorState"}))
    elseif tick > 10 then -- like wait before spam that shit, idk
        game:GetService("ReplicatedStorage").ProjectGemma.Remotes.rEvent:FireServer(unpack({[1] = "DoorState"}))
    end

end)
-- survival
main:CreateBind({name="Fail PC hacking",key="F"},function()
    game:GetService("ReplicatedStorage").ProjectGemma.Remotes.rEvent:FireServer(unpack({[1] = "HackFailed"}))

end)

-- beast
 -- have ac
main:CreateBind({name="Hook(any distance) + freeze(must be close)",key="R"},function()
    if not iambeast() then return end
    player("RopePlr")
    player("FreezePlayer")
end)
main:CreateBind({name="Silent punch (like Aim)",key="F"},function()
    if not iambeast() then return end
    playbeastsound("Smack")
    player("RagdollPlr")
end)

-- sounds from beast (annoy him)
for i,v in pairs({"Smack","Woosh"}) do
    main:CreateButton({name='Play "'..v..'" sound (from beast)'}, function() playbeastsound(v) end)
end

for i,v in pairs({"Stealth","Speed","Radar","Invisibility"}) do
    sa:CreateBind({name="Use Ability \""..v.."\""},function()
        if iambeast() then return end
        game:GetService("ReplicatedStorage").AbilitiesShared.net.Cancel:FireServer(unpack({[1] = v}))
        game:GetService("ReplicatedStorage").AbilitiesShared.net.Request:FireServer(unpack({[1] = v}))
        wait()
        game:GetService("ReplicatedStorage").AbilitiesShared.net.Request:FireServer(unpack({[1] = v}))
    end)
end
for i,v in pairs({"SuperSpeed","Radar","WeaponThrow","ShapeShifter"}) do
    sa:CreateBind({name="Use Ability \""..v.."\""},function()
        if not iambeast() then return end
        game:GetService("ReplicatedStorage").AbilitiesShared.net.Cancel:FireServer(unpack({[1] = v}))
        game:GetService("ReplicatedStorage").AbilitiesShared.net.Request:FireServer(unpack({[1] = v}))
        wait()
        game:GetService("ReplicatedStorage").AbilitiesShared.net.Request:FireServer(unpack({[1] = v}))
    end)
end
--[[ maybe will use in future (dont have limits(anti-cheat))
game:GetService("ReplicatedStorage").ProjectGemma.Remotes.ragdollEvent:FireServer(unpack({[1] = "RopePlr",[2] = plr.Name}))
game:GetService("ReplicatedStorage").ProjectGemma.Remotes.ragdollEvent:FireServer(unpack({[1] = "UnhookPlr",[2] = plr.Name}))
]]
