local stupid = Instance.new('Animation')
if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then stupid.AnimationId = 'rbxassetid://148840371'
else stupid.AnimationId = 'rbxassetid://5918726674' end
local hummy = game:GetService("Players").LocalPlayer.Character.Humanoid
_G.notfunny = hummy:LoadAnimation(stupid)
_G.notfunny:Play()
spawn(function()
    while hummy.Parent.Parent ~= nil and _G.choosenbang ~= "" do
        wait()
        game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(.1),{CFrame = game.Players[_G.choosenbang].Character.HumanoidRootPart.CFrame}):Play()
        _G.notfunny:AdjustSpeed(_G.notfunnyspeed)
    end
end)
