-- Beatland

local gui = ngstloader:AddMenu("Beatland")
gui = gui:AddTab("General")

local me = 	game.Players.LocalPlayer.Character.HumanoidRootPart

gui:CreateToggle({name="Farm 'B' Coins | can lag",state=_G.analsex},function(_)
	_G.analsex = _
	if _G.analsex == false then return end
	spawn(function()
	while _G.analsex == true do
		for i,v in pairs(game:GetService("Workspace").CurrencyPickups:GetChildren()) do
			v.BeatCoin.CFrame = me.CFrame
			wait(0.1)

		end
		wait(5)
	end end)

end)

zxc = gui:CreateButton({name="Collect words"},function()
	num = string.gsub(game:GetService("Players").sashlar777.PlayerGui.ScavengerHuntUI.MainFrame.TopTextFrame.DaysCompleted.CounterText.Text,"/5","")

	for q,w in pairs(game:GetService("Workspace").Scavengerhunt["Day0"..num]:GetChildren()) do
		w.Letter.RotationLetter.LetterSpecialMesh.CFrame = me.CFrame
		wait(0.1)

	end
	
	zxc:Change({name="Day "..num.." completed."})
end)
