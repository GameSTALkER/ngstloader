-- Beatland

local gui = ngstloader:AddMenu("Beatland")
gui = gui:AddTab("General")

local function TpMe(part)
	game:GetService("TweenService"):Create(part,TweenInfo.new(.1),{CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame}):Play()

end

gui:CreateToggle({name="Farm 'B' Coins | can lag",state=_G.analsex},function(_)
	_G.analsex = _
	if _G.analsex == false then return end
	spawn(function()
	while _G.analsex == true do
		for i,v in pairs(game:GetService("Workspace").CurrencyPickups:GetChildren()) do
			TpMe(v.BeatCoin)
			wait(0.1)

		end
		wait(5)
	end end)

end)

zxc = gui:CreateButton({name="Collect words"},function()

	local day = 0
	for i,v in pairs(game:GetService("Workspace").Scavengerhunt:GetChildren()) do
		if v.ClassName == "Folder" and v.Name ~= "Letters" then
			day = day + 1
			for q,w in pairs(v:GetChildren()) do
				TpMe(w.Letter.RotationLetter.LetterSpecialMesh)
				wait(0.1)

			end
			zxc:Change({name="Day "..day.." letters teleported."})
			
		end
		
	end
	wait(1)
	zxc:Change({name="All available words for now you successfully get."})
	wait(3)
	zxc:Change({name="Collect words"})
	
end)

gui:CreateButton({name="Get 5 UGC"},function()
	game:GetService("ReplicatedStorage").TGSItemShops_BuyItem:InvokeServer(unpack({[1] = "UGC_Boombox",[2] = 0}))
	game:GetService("ReplicatedStorage").TGSItemShops_BuyItem:InvokeServer(unpack({[1] = "UGC_FrogHat",[2] = 0}))
	game:GetService("ReplicatedStorage").TGSItemShops_BuyItem:InvokeServer(unpack({[1] = "UGC_Wings",[2] = 0}))
	game:GetService("ReplicatedStorage").TGSItemShops_BuyItem:InvokeServer(unpack({[1] = "UGC_DanceMove",[2] = 0}))
	game:GetService("ReplicatedStorage").TGSItemShops_BuyItem:InvokeServer(unpack({[1] = "UGC_PeaceSign",[2] = 0}))
	
end)
