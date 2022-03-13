
loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/UtilLib.lua"))()
     
local _gui = getgenv().ngstloader:AddMenu("AnimHub")

local _R6 = _gui:AddTab("R6")
local _R15 = _gui:AddTab("R15")
local _uni = _gui:AddTab("Universal")
local dir = {["r6"] = "https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/R6/", ["r15"] = "https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/R15/", ["uni"] = "https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/Universal/"}

_R6:CreateLabel({name="Join discord.gg/CDePpv6fKg/",copy="discord.gg/CDePpv6fKg/",desc="On this discord server you can get ids for hats and support if you getting some errors"})
_R15:CreateLabel({name="Join discord.gg/CDePpv6fKg/",copy="discord.gg/CDePpv6fKg/",desc="On this discord server you can get ids for hats and support if you getting some errors"})
_uni:CreateLabel({name="Join discord.gg/CDePpv6fKg/",copy="discord.gg/CDePpv6fKg/",desc="On this discord server you can get ids for hats and support if you getting some errors"})
-- R6
-- hand ~ R6
_R6:CreateButton({name="Execute \"Hand\" script",desc="KeyBinds:\nZ, Q, X, E, C, V, F, R, G, Y, T, B, H, J, U"},function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        --nlib:CreateNotify({title="ERROR",desc='Change your characters RigType to R6 in roblox avatar editor and reset character',sleep=30,textscale=13})
        return
    elseif neededhats({"Nagamaki","Robloxclassicred",'Pal Hair','Pink Hair','Hat1','Kate Hair','LavanderHair','Bedhead','BlockheadBaseballCap',"MessyHair"},"string") ~= true then
        print("^ for Hand ^")
        --nlib:CreateNotify({title="ERROR",desc='Check console what you forgot to wear (must turn on warns)',sleep=30,textscale=13})
        return
    end
          
    loadstring(game:HttpGet(dir['uni'].."hatshow.lua"))()
    loadstring(game:HttpGet(dir['uni'].."netless.lua"))()
    loadstring(game:HttpGet(dir['r6'].."Hand.lua"))()
end)

-- Sex Doll ~ R6
_R6:CreateButton({name='Execute "Sex Doll" script',desc='KeyBinds:\nZ, Q, X, E, C, R'},function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        --nlib:CreateNotify({title="ERROR",desc='Change your characters RigType to R6 in roblox avatar editor and reset character',sleep=30,textscale=13})
        return
    elseif neededhats({"Robloxclassicred","Pal Hair",'LavanderHair','Pink Hair','HairAccessory','International Fedora','MeshPartAccessory','BrownCharmerHair','MessyHair'},"string") ~= true then
        print("^ for Sex Doll ^")
        --nlib:CreateNotify({title="ERROR",desc='Check console what you forgot to wear (must turn on warns)',sleep=30,textscale=13})
        return
    end
    
    loadstring(game:HttpGet(dir['uni'].."hatshow.lua"))()
    loadstring(game:HttpGet(dir['uni'].."netless.lua"))()
    loadstring(game:HttpGet(dir['r6'].."Doll.lua"))()
end)

-- Penis ~ R6
_R6:CreateButton({name='Execute "Penis"(R15 too) script',desc='KeyBinds:\n1, 2, 3, 4, 5, 6, 7, 8, 9, 0, E\nQ - switch modes'},function()
    if neededhats({{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"}},"string") ~= true then
        print("^ for Penis ^")
        --nlib:CreateNotify({title="ERROR",desc='Check console what you forgot to wear (must turn on warns)',sleep=30,textscale=13})
        return
    end
    --if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        --nlib:CreateNotify({title="ERROR",desc='Recommend you chage RigType to R6',sleep=30,textscale=13}) end
          
    loadstring(game:HttpGet(dir['uni'].."hatshow.lua"))()
    loadstring(game:HttpGet(dir['uni'].."netless.lua"))()
    loadstring(game:HttpGet(dir['r6'].."Penis.lua"))()
end)

-- spider man
_R6:CreateButton({name='Execute "Spider Man" script',desc='Keybinds:\nQ, E'},function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        --nlib:CreateNotify({title="ERROR",desc='Change your characters RigType to R6 in roblox avatar editor and reset character',sleep=30,textscale=13})
        return
    end
    
    loadstring(game:HttpGet(dir['r6'].."spiderman.lua"))()
end)

-- amogus
_R6:CreateButton({name='Execute "Amogus" script',desc='Keybinds:\nF, E, C, Q'},function()
    if neededhats({"Robloxclassicred","Pal Hair","Kate Hair","Hat1","Pink Hair","LavanderHair","Necklace"},"string") ~= true then
        print("^ for Amogus ^")
        --nlib:CreateNotify({title="ERROR",desc='Check console what you forgot to wear (must turn on warns)',sleep=30,textscale=13})
        return
    end
    --if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        --nlib:CreateNotify({title="ERROR",desc='Change your characters RigType to R6 in roblox avatar editor and reset character',sleep=30,textscale=13}) end

    loadstring(game:HttpGet(dir['uni'].."hatshow.lua"))()
    loadstring(game:HttpGet(dir['r6'].."amogus.lua"))()
end)

-- R15
-- small avatar ~ R15
_R15:CreateButton({name='Execute "Small avatar" script',desc="Needed avatar proportions:\nHeight = 90%\nWidth = 70%\nHead = 100%\nProportions = 0%\nBody Type = 0%"},function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        --nlib:CreateNotify({title="ERROR",desc='Change your characters RigType to R15 in roblox avatar editor and reset character',sleep=30,textscale=13})
        return
    end
    loadstring(game:HttpGet(dir['r15'].."small-avatar.lua"))()
end)

-- big avatar
_R15:CreateButton({name='Execute "Big avatar" script',desc="Needed avatar proportions:\nHeight = 105%\nWidth = 100%\nHead = 100%\nProportions = 0%\nBody Type = 100%"},function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
        --nlib:CreateNotify({title="ERROR",desc='Change your characters RigType to R15 in roblox avatar editor and reset character',sleep=30,textscale=13})
        return
    end
    loadstring(game:HttpGet(dir['r15'].."big-avatar.lua"))()
end)

-- hamster
_uni:CreateButton({name='Execute "Hamster Ball" script'},function()
    loadstring(game:HttpGet(dir['uni'].."hamster-ball.lua"))()
end)

-- bang
_uni:CreateInput({name="Write Player Name to bang", ac={game:GetService("Players"):GetChildren(),{"Name","DisplayName"}}},function(_)
    _G.choosenbang = ""
    if _G.notfunny ~= nil then _G.notfunny:Stop();_G.notfunny = nil end
    _G.choosenbang = _
    local resp = 0
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Name == _G.choosenbang or v.DisplayName == _G.choosenbang then
            _G.choosenbang = v.Name
            loadstring(game:HttpGet(dir['uni'].."bang-bang.lua"))()
            resp = 1
            break
        end
    end
    --if resp == 0 then nlib:CreateNotify({title="ERROR",desc='Invatid player name',sleep=15,textscale=16}) end
end)
_G.notfunnyspeed = 8
_uni:CreateSlider({desc="Bang animation speed", min=1, def=8, max=100},function(_) _G.notfunnyspeed = tonumber(_) end)
_uni:CreateButton({name='Stop "Bang" script'},function()
    _G.choosenbang = ""
    if _G.notfunny ~= nil then _G.notfunny:Stop();_G.notfunny = nil end
end)
