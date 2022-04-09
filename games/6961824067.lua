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
local isserverlagging = false
gui:CreateToggle({name="Lag players (press multiple times)", desc="Lag players(you don't get lags)\nRejoin to remove lag"}, function(_)
    isserverlagging = _
    if _ then
        spawn(function()
            for i,v in pairs(game.workspace:GetDescendants()) do
                game:GetService("ReplicatedStorage").CharacterEvents.Beam:FireServer(unpack({[1] = "make",[2] = v,[3] = Vector3.new(0,0,0)}))
                wait()
                if not isserverlagging then break end
            end
        end)
    else
        spawn(function()
            for i,v in pairs(game.workspace:GetDescendants()) do
                game:GetService("ReplicatedStorage").CharacterEvents.Beam:FireServer(unpack({[1] = "destroy",[2] = v}))
                wait()
                if isserverlagging then break end
            end
        end)
    end
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
                    wait()
                end
                wait()
            end
        end)
    end
end)
