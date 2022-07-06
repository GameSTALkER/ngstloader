-- TTD3
lp = game:GetService("Players").LocalPlayer
ngstloader:CreateToggle({name="AutoFarm"},function(state)

  session = getgenv().ScriptSession(1)
  while session == getgenv().ScriptSession() and state do
    for i,v in pairs(lp.PlayerGui.EmoteUI.MainFrame.Emotes:GetChildren()[1]:GetChildren()) do
      if v.ClassName == "Frame" then
        game:GetService("ReplicatedStorage").AFKEvent:FireServer(false)
        game:GetService("ReplicatedStorage").EmoteSystemEvent:FireServer("DoEmote",v.Name)
        wait(3)
        if session ~= getgenv().ScriptSession() then
          break
        end
      end

    end

  end
end)
