-- Tower Defense Simulator | Match

local maingui = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/UIs/DarkGUi.lua"))():CreateWin("Tower defence sim.", "Match.jf7qwSdf")
local tab1 = maingui:CreateTab({name="General"})

local me = game:GetService("Players").LocalPlayer
local scriptvar = {}

local function callrmethod(meth) -- dump thing but working.
    local obj = me:GetMouse().Target
    local function powihsg(ooo)
        if tostring(ooo.Owner.Value) == me.Name then
            if meth == "Upg" then game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack({[1] = "Troops",[2] = "Upgrade",[3] = "Set",[4] = {["Troop"] = ooo}}))
            elseif meth == "Sell" then game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack({[1] = "Troops",[2] = "Sell",[3] = {["Troop"] = ooo}}))
            end
        end
    end
    if obj.Parent.Name == "Towers" and obj.ClassName == "Model" then
        powihsg(obj)
    elseif obj.Parent.Parent.Name == "Towers" and obj.Parent.ClassName == "Model" then
        powihsg(obj.Parent)
    elseif obj.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.ClassName == "Model" then
        powihsg(obj.Parent.Parent)
    elseif obj.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.ClassName == "Model" then
        powihsg(obj.Parent.Parent.Parent)
    elseif obj.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.ClassName == "Model" then
        powihsg(obj.Parent.Parent.Parent.Parent)
    elseif obj.Parent.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.Parent.ClassName == "Model" then
        powihsg(obj.Parent.Parent.Parent.Parent.Parent)
    elseif obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.Parent.Parent.ClassName == "Model" then
        powihsg(obj.Parent.Parent.Parent.Parent.Parent.Parent)
    elseif obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Name == "Towers" and obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent.ClassName == "Model" then
        powihsg(obj.Parent.Parent.Parent.Parent.Parent.Parent.Parent)
    end
end

tab1:CreateBind({name="Upg Key", desc="Upgrade troop on key"}, function()
    callrmethod("Upg")
end)

tab1:CreateBind({name="Sell Key", desc="Sell troop on key"}, function()
    callrmethod("Sell")
end)
