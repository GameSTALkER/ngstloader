-- Fling Things and People

local gui = ngstloader:AddMenu("FTaP")
gui = gui:AddTab("General")

local LocalPlayer = game:GetService("Players").LocalPlayer
local plrs = game:GetService("Players")

local throw = {}

local throw_limit = 1350

function Int()
    for i,v in pairs(debug.getregistry()) do
        pcall(function()
            if type(v) == "function" and not is_synapse_function(v) then
                local Values = debug.getupvalues(v)
                for a,b in pairs(Values) do
                    if type(b) == "number" and b == 20 then
                        debug.setupvalue(v, a, 30)
                    end
                end
     
                local Constants = debug.getconstants(v)
                for Number,Value in pairs(Constants) do
                    if type(Value) == "number" then
                        if Value == 100 then
                            debug.setconstant(v, Number, 5000)
                        end
                        if Value == 750 then
                            throw = {v, Number}
                            debug.setconstant(v, Number, throw_limit)
                        end
                    end
                end
            end
        end)
    end
end

gui:CreateButton({name="Activate Throw power hack"}, function() Int() end)
gui:CreateSlider({name="Throw power", min=750, def=throw_limit, max=10000}, function(_)
    throw_limit = _
    debug.setconstant(throw[1], throw[2], throw_limit)

end)
gui:CreateButton({name="Lag players", desc="Lags players(you don't get lags)"}, function()
    spawn(function()
        for i,v in pairs(game.workspace:GetDescendants()) do
            game:GetService("ReplicatedStorage").CharacterEvents.Beam:FireServer(unpack({[1] = "make",[2] = v,[3] = Vector3.new(0,0,0)}))
            wait()
        end
    end)
end)
getgenv().getgoodgetlaydog = false
gui:CreateToggle({name="Make everyone around you lay", desc="Really funny :)"},function(_)
    getgenv().getgoodgetlaydog = _
    if getgenv().getgoodgetlaydog then 
        spawn(function()
            while getgenv().getgoodgetlaydog do
                for i,v in pairs(plrs:GetChildren()) do
                    pcall(function()
                        if v.Name ~= plrs.LocalPlayer.Name then
                            game:GetService("ReplicatedStorage").GrabEvents.SetNetworkOwner:FireServer(unpack({[1] = v.Character.HumanoidRootPart,[2] = "player"}))
                        end
                    end)
                end
                wait()
            end
        end)
    end
end)
gui:CreateBind({name="Lay (for escape only)", key="Q",loop=true},function()
    game:GetService("ReplicatedStorage").GrabEvents.SetNetworkOwner:FireServer(unpack({[1] = plrs.LocalPlayer.Character.HumanoidRootPart,[2] = "player"}))
    game:GetService("ReplicatedStorage").CharacterEvents.Beam:FireServer(unpack({[1] = "destroy",[2] = plrs.LocalPlayer.Character.HumanoidRootPart}))

end)
gui:CreateToggle({name="Auto casino",desc="Automaticly collect cash from casino"},function(_)
    getgenv().autofarming = _

    if not getgenv().autofarming then return end
    spawn(function()
        while getgenv().autofarming do
            
            local mychar = game.Players.LocalPlayer.Character
            local pos = mychar.HumanoidRootPart.CFrame
            local casino = game.workspace.Slots.Slots.SlotHandle.Handle
            local timel = game:GetService("Workspace").Slots.Slots.Screen.SlotGui.TimeLeftFrame.TimeText
            
            repeat wait(1) until timel.Text == "0:00" or getgenv().autofarming == false
            if getgenv().autofarming then
                game:GetService("TweenService"):Create(mychar.HumanoidRootPart,TweenInfo.new(.1),{CFrame = casino.CFrame}):Play()
                wait(0.5)
                game:GetService("ReplicatedStorage").GrabEvents.SetNetworkOwner:FireServer(unpack({[1] = casino,[2] = "player"}))
                wait(0.3)
                game:GetService("TweenService"):Create(mychar.HumanoidRootPart,TweenInfo.new(.1),{CFrame = pos}):Play()
            end
        
        end
    end)
end)
