-- GAS STATION
local main = ngstloader:AddMenu("Gas Station")
local page1 = main:AddTab("Main")

-- SETTINGS
local wait_time = 0.5
getgenv().fuel_cars = false
getgenv().clean_spots = false
getgenv().clean_windows = false

getgenv().restock_items = false -- restock items if don't have | if off will stop farm
getgenv().use_client_money = false -- if not enough money at station bank, use client money?


-- dont change this pls
getgenv().last_position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
getgenv().last_buy_item = "fuel"


-- SOURCE

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

-- fault cathcer
spawn(function()
    game:GetService("Players").SeemlySasha.PlayerGui.NotificationUI.Notifications.ActiveNotifications.ChildAdded:Connect(function(a)
        local text = a.Primary.BodyText.Text
        if text == "Not enough fuel to refill this car. Buy more and try again." then
            if getgenv().restock_items == true then
                Buy("fuel","Station")
            else
                getgenv().fuel_cars = false
            end
        elseif text == "Gas Station can not afford this purchase." and getgenv().use_client_money == true then
            Buy(getgenv().last_buy_item,"Client")
        end
        
    end)
end)

page1:CreateToggle({state=getgenv().fuel_cars,name="Fuel cars"},function(t)
    getgenv().fuel_cars = t
    if getgenv().fuel_cars == true then
        spawn(function()
            while wait(wait_time) and getgenv().fuel_cars == true do
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
                    end
                end
            end
        end)
    end
end)

page1:CreateToggle({state=getgenv().clean_spots,name="Clean spots"},function(t)
    getgenv().clean_spots = t
    if getgenv().clean_spots == true then
        spawn(function()
            while wait(wait_time) and getgenv().clean_spots == true do
                local thespot = game:GetService("Workspace"):FindFirstChild("Spot") or nil
                if thespot ~= nil then
                    game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Clean",[2] = thespot.Clean}))
                end
            
            end
            
        end)
        
    end
end)
page1:CreateToggle({state=getgenv().clean_windows,name="Clean windows"},function(t)
    getgenv().clean_windows = t
    if getgenv().clean_windows == true then
        spawn(function()
            while wait(wait_time) and getgenv().clean_windows == true do
                for i,v in pairs(game:GetService("Workspace").Windows:GetChildren()) do
                    if v.Attachment.Clean.Enabled == true then
                        RMe(1)
                        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Clean",[2] = v.Attachment.Clean}))
                        RMe(0)
                        
                    end
                    
                end
            
            end
            
        end)
        
    end
end)
page1:CreateToggle({name="Restock items",desc="Restock items (fuel)"},function(t)
    getgenv().restock_items = t
end)
page1:CreateToggle({name="Use client money",desc="If station have not enough money will use your money"},function(t)
    getgenv().use_client_money = t
end)
