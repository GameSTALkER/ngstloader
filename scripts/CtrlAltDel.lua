local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

if _G.PYSSIDESTOIER then _G.PYSSIDESTOIER:Disconnect() end

_G.PYSSIDESTOIER = Mouse.Button1Down:connect(function()
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftAlt) then
        if not Mouse.Target then return end
        local obj = Mouse.Target
        if obj.Transparency == 0 then 
            obj.Transparency = 0.8
            obj.CanCollide = false 
        else 
            obj.Transparency = 0
            obj.CanCollide = true 
        end
    elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
        if not Mouse.Target then return end
        Mouse.Target:Destroy()
    end
end)