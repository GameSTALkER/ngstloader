-- Fling Things and People

local gui = ngstloader:AddMenu("FTaP")
gui = gui:AddTab("General")

local LocalPlayer = game:GetService("Players").LocalPlayer

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

Int()
LocalPlayer.CharacterAdded:Connect(function()
    repeat wait() until LocalPlayer.Character
    repeat wait() until LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    repeat wait() until LocalPlayer.Character:FindFirstChild("GrabbingScript")
    Int()
end)

gui:CreateSlider({name="Throw power", min=750, def=throw_limit, max=10000}, function(_)
    throw_limit = _
    debug.setconstant(throw[1], throw[2], throw_limit)

end)
