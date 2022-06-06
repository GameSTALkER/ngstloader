-- GAS STATION
local main = ngstloader:AddMenu("Gas Station")
local page1 = main:AddTab("Main")

-- SETTINGS
local wait_time = 0.5
local wait_item = { -- wait time before start clean next thing
    windows = 1.5;
    solar_panels = 0.5;
    spots = 0.5;
    cashier = 0.5;
    fuel_car = 2.5;
}
local minimun_energy = 70 -- minimal energy to start work again
getgenv().fuel_cars = false
getgenv().clean_spots = false
getgenv().clean_windows = false
getgenv().clean_solars = false
getgenv().cashier = false

getgenv().restock_items = true -- restock items if don't have | if off will stop farm
getgenv().use_client_money = false -- if not enough money at station bank, use client money?
getgenv().is_executed = false
getgenv().is_out_of_energy = false

-- dont change this pls
getgenv().last_position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
getgenv().last_buy_item = "fuel"

-- SOURCE

local elements = {}
local Tween = game:GetService("TweenService")
local function To(part)
    if part.ClassName ~= "Part" then
        for i,v in pairs(part:GetChildren()) do
            if v.ClassName == "Part" then
                part = v
                break
            end
        end
    end
    local me = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    Tween:Create(me,TweenInfo.new(.3),{CFrame = part.CFrame}):Play()
    wait(.3)
end
local function RMe(a)
    local me = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    if a == 1 then
        getgenv().last_position = me.CFrame
    else
        Tween:Create(me,TweenInfo.new(.3),{CFrame = getgenv().last_position}):Play()
        wait(.3)
    end
end
local function Buy(item_name,cashby)
    local function item(a,b)
        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "BuyItem",[2] = a,[3] = b,[4] = 1,[5] = cashby}))

    end
    if item_name == "fuel" then
        getgenv().last_buy_item = "fuel"
        item("Syntin Petrol Co","Gasoline 87")
    end
end
local function wait_for_energy()
    if getgenv().is_out_of_energy == true then
        while getgenv().is_out_of_energy == true do
            wait(1)
        end
    end
end
local function Energy()
    local percent = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stamina.Bar.Amount.Text:gsub("%\%","")
    if tonumber(percent) <= minimun_energy and getgenv().is_out_of_energy == true then
        local me = game:GetService("Players").LocalPlayer.Character
        RMe(1)
        Tween:Create(me.HumanoidRootPart,TweenInfo.new(.3),{CFrame = game:GetService("Workspace").Ceilings.Sofa.Seat.CFrame}):Play()
        wait(.3)
        while tonumber(percent) <= minimun_energy and getgenv().is_out_of_energy == true do
            wait(1.5)
            percent = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stamina.Bar.Amount.Text:gsub("%\%","")
        end
        me.Humanoid:ChangeState(3) -- jump
        getgenv().is_out_of_energy = false
        RMe(0)
    end
end
game:GetService("Players").LocalPlayer.Character.Humanoid.StateChanged:Connect(function(o,n)
	if n == Enum.HumanoidStateType.Seated and getgenv().is_out_of_energy == false then
        game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(3)
    end

end)

-- fault cathcer
spawn(function()
    game:GetService("Players").LocalPlayer.PlayerGui.NotificationUI.Notifications.ActiveNotifications.ChildAdded:Connect(function(a)
        local text = a.Primary.BodyText.Text
        local title = a.Primary["1"].HeaderHolder.Header.Text
        if text == "Not enough fuel to refill this car. Buy more and try again." then
            if getgenv().restock_items == true then
                Buy("fuel","Station")
            else
                elements[1]:Change({state=false})
            end
        elseif text == "Gas Station can not afford this purchase." and getgenv().use_client_money == true then
            Buy(getgenv().last_buy_item,"Client")
        elseif text == "Only the Manager can purchase more stock when one is present." then
            elements[4]:Change({state=false})
        elseif title == "Out of Energy" then
            getgenv().is_out_of_energy = true
            Energy()
        end
        
    end)
end)

elements[1] = page1:CreateToggle({state=getgenv().fuel_cars,name="Fuel cars"},function(t)
    getgenv().fuel_cars = t
    if getgenv().fuel_cars == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().fuel_cars == true and getgenv().is_executed == false do
                wait_for_energy()
                local wrk = game:GetService("Workspace")
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.ClassName == "Model" and string.find(v.Name:lower(),"car_") then
                        spawn(function()
                            local promt = v.Lid:FindFirstChild("Refuel") or v.Lid:FindFirstChild("FinishFuel") or v.Lid:WaitForChild("FinishFuel")
                            RMe(1)
                            To(v)
                            fireproximityprompt(promt, 3)
                            RMe(0)
                            if promt.Name == "Refuel" then
                                promt = car.Lid:WaitForChild("FinishFuel")
                                RMe(1)
                                To(v)
                                fireproximityprompt(promt, 3)
                                RMe(0)
                            end
                        end)
                        wait(wait_item['fuel_car'])
                    end
                end
            end
        end)
    end
end)
elements[7] = page1:CreateToggle({state=getgenv().cashier,name="Cashier"},function(t)
    getgenv().cashier = t
    if getgenv().cashier == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().cashier == true and getgenv().is_executed == false do
                wait_for_energy()
                for i,v in pairs(game:GetService("Workspace").Checkouts:GetChildren()) do
                    for q,w in pairs(v.Items:GetChildren()) do
                        pcall(function()
                            repeat wait(.1) until w.Root.Scan.Enabled == true
                            game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "ScanItem",[2] = w,[3] = v}))
                            wait(wait_item["cashier"])
                        end)
                    end

                end
            
            end
            
        end)
        
    end
end)
elements[2] = page1:CreateToggle({state=getgenv().clean_spots,name="Clean spots"},function(t)
    getgenv().clean_spots = t
    if getgenv().clean_spots == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().clean_spots == true and getgenv().is_executed == false do
                wait_for_energy()
                pcall(function()
                    local thespot = game:GetService("Workspace").Stains:FindFirstChild("Spot") or nil
                    if thespot ~= nil then
                        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Clean",[2] = thespot.Clean}))
                        wait(wait_item['spots'])
                    end
                end)
            
            end
            
        end)
        
    end
end)
elements[3] = page1:CreateToggle({state=getgenv().clean_windows,name="Clean windows"},function(t)
    getgenv().clean_windows = t
    if getgenv().clean_windows == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().clean_windows == true and getgenv().is_executed == false do
                wait_for_energy()
                for i,v in pairs(game:GetService("Workspace").Windows:GetChildren()) do
                    if v.Attachment.Clean.Enabled == true then
                        RMe(1)
                        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Clean",[2] = v.Attachment.Clean}))
                        RMe(0)
                        wait(wait_item["windows"])
                        
                    end
                    
                end
            
            end
            
        end)
        
    end
end)
elements[6] = page1:CreateToggle({state=getgenv().clean_solars,name="Clean Solar panels"},function(t)
    getgenv().clean_solars = t
    if getgenv().clean_solars == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().clean_solars == true and getgenv().is_executed == false do
                wait_for_energy()
                for i,v in pairs(game:GetService("Workspace").Solar.Panels:GetChildren()) do
                    if v.Stand.CleanPosition.Clean.Enabled == true then
                        RMe(1)
                        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Clean",[2] = v.Stand.CleanPosition.Clean}))
                        RMe(0)
                        wait(wait_item["solar_panels"])
                        
                    end
                    
                end

            end

        end)

    end

end)
elements[4] = page1:CreateToggle({state=getgenv().restock_items,name="Restock items",desc="Restock items (fuel)"},function(t)
    getgenv().restock_items = t
end)
elements[5] = page1:CreateToggle({state=getgenv().use_client_money,name="Use client money",desc="If station have not enough money will use your money"},function(t)
    getgenv().use_client_money = t
end)
