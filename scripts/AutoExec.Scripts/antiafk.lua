-- anti-afk
if game.PlaceId == 2768379856 then return end
local main = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/synapse.luas/main/UiLibs/NotifyLib.lua"))()
if _G.antiafklel228jopa ~= nil then _G.antiafklel228jopa:Disconnect() end

local vu = game:GetService("VirtualUser")
_G.antiafklel228jopa = game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    main:GenNotify(1,"BottomRight","Dark",nil,"Fade","Anti-AFK","BEGAN",.8)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    main:GenNotify(1,"BottomRight","Dark",nil,"Fade","Anti-AFK","OK",1)
end)
