-- TTD3

local main = ngstloader:AddMenu("TTD3")
main = main:AddTab("Main")

lp = game:GetService("Players").LocalPlayer
_G.stat = false
main:CreateToggle({name="AutoFarm"},function(state)
	_G.stat = state
	spawn(function()
		local session = getgenv().ScriptSession(1)
		while session == getgenv().ScriptSession() and _G.stat do
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
end)
