
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do -- show hats in fisrt person
    if v.ClassName == "Accessory" and v.Handle:IsA("BasePart") then
    
        v.Handle:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
            v.Handle.LocalTransparencyModifier = v.Handle.Transparency
        end)
        
        v.Handle.LocalTransparencyModifier = v.Handle.Transparency
        
    end
end
