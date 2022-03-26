-- Hexa Game

local guilib = ngstloader:AddMenu("Hexa")
guilib = guilib:AddTab("Main")
guilib:CreateButton({name='Instant Cookie'}, function()
    local u2 = require(game.ReplicatedStorage.Network);
    for i,hitPart in pairs(workspace.Cookies:GetChildren()) do
        if ((hitPart.CameraPart.CFrame.p - workspace.CurrentCamera.CFrame.p).Magnitude) == 0 then
            for i,part in pairs(hitPart.Checker:GetChildren()) do
                u2:InvokeServer("Verf", part.Position, part)
                wait(.1)
            end
        end
    end
end)

guilib:CreateToggle({name='Pull Rope'}, function(state)
    _G.PRState = state
    while _G.PRState and wait(.04) do game:GetService("ReplicatedStorage").RE.Pull:FireServer() end
end)

guilib:CreateButton({name='Name Fake Glasses'}, function()
    for i,v in pairs(game:GetService("Workspace").Glass:GetDescendants()) do
        if v.ClassName == "TouchTransmitter" then
            local BillboardGui = Instance.new("BillboardGui")
            local TextLabel = Instance.new("TextLabel")

            BillboardGui.Parent = v.Parent
            BillboardGui.AlwaysOnTop = true
            BillboardGui.LightInfluence = 1
            BillboardGui.Size = UDim2.new(0, 50, 0, 50)
            BillboardGui.StudsOffset = Vector3.new(0, 2, 0)

            TextLabel.Parent = BillboardGui
            TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Text = "FakeGlass"
            TextLabel.TextColor3 = Color3.new(1, 0, 0)
            TextLabel.TextScaled = true
        end
    end
end)

guilib:CreateButton({name='Punch Reach'}, function() -- Credits: https://v3rmillion.net/member.php?action=profile&uid=1594530
    while wait() do
        pcall(function()
            for i, v in next, game.Players:GetChildren() do
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= game.Players.LocalPlayer then
                    local punch = game.Players.LocalPlayer.Character.Punch
                    firetouchinterest(punch.Handle, v.Character.HumanoidRootPart, 0)
                    firetouchinterest(punch.Handle, v.Character.HumanoidRootPart, 1)
                end
            end
        end)
    end
end)

guilib:CreateButton({name='Platform'}, function()
    local part = Instance.new("Part")
    part.Parent = game.Workspace.Glass["1"].RealGlass;
    part.CFrame = CFrame.new(-54.05, -15.2, -367.15);
    part.Size = Vector3.new(100, .2, 225);
    part.Transparency = .3;
    part.Anchored = true;
    part.CanCollide = true;
    part.Material = "ForceField";
end)
