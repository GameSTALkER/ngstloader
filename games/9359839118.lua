-- GAS STATION
local main = ngstloader:AddMenu("Gas Station")
local page1 = main:AddTab("Main")

-- SETTINGS
local wait_time = 0.5
local wait_item = { -- wait time before start clean next thing
    spots = 0.5;
    cashier = 1;
    fuel_car = 2.5;
}
local minimun_energy = 70 -- minimal energy to start work again
local client_money_limit = 14
if getgenv().fuel_cars == nil then getgenv().fuel_cars = false end
if getgenv().clean_spots == nil then getgenv().clean_spots = false end
if getgenv().cashier == nil then getgenv().cashier = false end

if getgenv().restock_items == nil then getgenv().restock_items = false end -- restock items if don't have | if off will stop farm
if getgenv().use_client_money == nil then getgenv().use_client_money = false end -- if not enough money at station bank, use client money?
if getgenv().off_lights == nil then getgenv().off_lights = false end -- turn off lights on station close
if getgenv().restock_energy == nil then getgenv().restock_energy = true end

-- dont change this pls
getgenv().last_position = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
getgenv().last_buy_item = "fuel"
getgenv().is_out_of_energy = false
getgenv().is_already_moving = false

local is_waiting_for_fuel = false
local is_noclippin = true
-- connections
if getgenv().connection == nil then getgenv().connection = {} end
if getgenv().trash_cons == nil then getgenv().trash_cons = {} end
for i,v in pairs(getgenv().connection) do
   getgenv().connection[i]:Disconnect()
   getgenv().connection[i] = nil
end
for i,v in pairs(getgenv().trash_cons) do
   getgenv().trash_cons[i]:Disconnect()
   getgenv().trash_cons[i] = nil
end

-- SOURCE

-- getting some needed stuff
local power_buttons = {["Shop A/C"] = nil, ["Shop Lights"] = nil}
spawn(function()
    for i,v in pairs(game:GetService("Workspace").Ceilings.This:GetDescendants()) do
        if v.ClassName == "SurfaceGui" then
            if v.TextLabel.Text == "Shop A/C" or v.TextLabel.Text == "Shop Lights" then
                v.Parent.Name = "Title"
                power_buttons[v.TextLabel.Text] = v.Parent.Parent.Part.Power
            end
        end
    end
end)


local elements = {}
local me = game:GetService("Players").LocalPlayer
local Tween = game:GetService("TweenService")

local myspeed = {}
game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Sprinting",[2] = true}));wait(0.5);myspeed["true"] = me.Character.Humanoid.WalkSpeed
game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Sprinting",[2] = false}));wait(0.5);myspeed["false"] = me.Character.Humanoid.WalkSpeed

-- for actions
local function wait_for_energy()
    if getgenv().is_out_of_energy == true then
        while getgenv().is_out_of_energy == true do
            wait(1)
        end
    end
end
local function interact(promt)
    if promt.Parent then
        promt = promt.Parent:FindFirstChild(promt.Name)
        if promt then
            if promt.Enabled then
                print("Interacted with: "..promt.Name)
                fireproximityprompt(promt, 3)
            end
        else print("Interaction failed.")
        end
    else print("Interaction failed.")
    end
end
-- movement
local function Sprint(worker,state)
    if worker:lower() ~= "client" then
        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "Sprinting",[2] = state}))
        wait(0.5)
        if me.Character.Humanoid.WalkSpeed == myspeed[tostring(not state)] then myspeed[tostring(state)] = me.Character.Humanoid.WalkSpeed end
    elseif state == true then me.Character.Humanoid.WalkSpeed = myspeed["true"]
    else me.Character.Humanoid.WalkSpeed = myspeed["false"] end
end
local function moveTo(targetPoint, promt) -- https://developer.roblox.com/en-us/api-reference/function/Humanoid/MoveTo
    repeat wait(1) until getgenv().is_already_moving == false
    if promt == nil then promt = 0 end
    wait_for_energy()
	local targetReached = false
	getgenv().is_already_moving = true
    local humanoid = me.Character.Humanoid
    --is_noclippin = true
    
	-- listen for the humanoid reaching its target
	local con_walk
	con_walk = humanoid.MoveToFinished:Connect(function(reached)
		targetReached = true
		con_walk:Disconnect()
		con_walk = nil
		if promt and promt ~= 0 then interact(promt) end
	end)
 
	-- start walking
	--Sprint("Client",true)
	humanoid:MoveTo(targetPoint)
 
	-- execute on a new thread so as to not yield function
	while not targetReached do
	    wait_for_energy()
		-- does the humanoid still exist?
		if not (humanoid and humanoid.Parent) then
			break
		end
		-- has the target changed?
		if humanoid.WalkToPoint ~= targetPoint then
			break
		end
		
		if getgenv().is_already_moving == false then
		    break
		end
    
        if promt and promt ~= 0 then
            if not promt.Enabled then print("promt disabled");break end
        else print("promt is nil");break end
    
		-- refresh the timeout
		--Sprint("Client",true)
		humanoid:MoveTo(targetPoint)
		wait(1)
	end
	--is_noclippin = false
    --Sprint("Client",false)
    humanoid:MoveTo(me.Character:FindFirstChild('HumanoidRootPart').Position)
    getgenv().is_already_moving = false
	
	-- disconnect the connection if it is still connected
	if con_walk then
		con_walk:Disconnect()
		con_walk = nil
	end
end
local function RMe(a)
    if a == 1 then
        getgenv().last_position = me.Character.HumanoidRootPart.CFrame
    else
        Tween:Create(me.Character.HumanoidRootPart,TweenInfo.new(.3),{CFrame = getgenv().last_position}):Play()
        wait(.3)
    end
end
-- economy
local function ClientMoney(needed)
    if needed > client_money_limit then return false end
    local money = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stats.Money.Money.Text:gsub("%$","")
    if tonumber(money) >= needed and getgenv().use_client_money == true then return true else return false end
end
local function BankMoney(needed)
    local bank = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stats.Bank.Bank.Text:gsub("%$","")
    local bills = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stats.Bills.Bills.Text:gsub("%$","")
    local commision = game:GetService("Workspace").CommisionTable.SurfaceGui.Content[me.Name].Amount.Text:gsub("%$","")
    if tonumber(bank)-tonumber(bills) >= needed and tonumber(commision) >= needed then return true else return false end
end
local function Buy(item_name,cashby)
    local function item(a,b,c)
        game:GetService("ReplicatedStorage").Remote:FireServer(unpack({[1] = "BuyItem",[2] = a,[3] = b,[4] = c,[5] = cashby}))

    end
    if item_name == "fuel" then
        getgenv().last_buy_item = "fuel"
        local bought = false
        if BankMoney(350) or ClientMoney(350) then
            item("Syntin Petrol Co","Gasoline 87",7);bought = true
        elseif BankMoney(200) or ClientMoney(200) then
            item("Syntin Petrol Co","Gasoline 87",6);bought = true
        elseif BankMoney(100) or ClientMoney(100) then
            item("Syntin Petrol Co","Gasoline 87",5);bought = true
        elseif BankMoney(46) or ClientMoney(46) then
            item("Syntin Petrol Co","Gasoline 87",4);bought = true
        elseif BankMoney(26) or ClientMoney(26) then
            item("Syntin Petrol Co","Gasoline 87",3);bought = true
        elseif BankMoney(14) or ClientMoney(14) then
            item("Syntin Petrol Co","Gasoline 87",2);bought = true
        else repeat wait(1) until (BankMoney(9) or ClientMoney(9)) or getgenv().restock_items == false
            if getgenv().restock_items == true then item("Syntin Petrol Co","Gasoline 87",1);bought = true end
        end
        if bought == true then is_waiting_for_fuel = false end
    end
end

-- for actions | avoid stucks
table.insert(getgenv().connection,game:GetService("Players").LocalPlayer.Character.Humanoid.StateChanged:Connect(function(o,n)
	if n == Enum.HumanoidStateType.Seated and getgenv().is_out_of_energy == false and (getgenv().fuel_cars or getgenv().clean_spots or getgenv().cashier) then
        game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(3)
    else Sprint("Server",false)
    end

end))
table.insert(getgenv().connection,game:GetService("Players").LocalPlayer.Character.Head.Touched:connect(function(obj)
	if obj ~= workspace.Terrain then
		if is_noclippin == true then
			obj.CanCollide = false
		else
			obj.CanCollide = true
		end
	end
end))
table.insert(getgenv().connection,game:GetService("Players").LocalPlayer.Character.Torso.Touched:connect(function(obj)
	if obj ~= workspace.Terrain then
		if is_noclippin == true then
			obj.CanCollide = false
		else
			obj.CanCollide = true
		end
	end
end))


local function Energy()
    local percent = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stamina.Bar.Amount.Text:gsub("%\%","")
    local came = false
    if tonumber(percent) <= minimun_energy and getgenv().is_out_of_energy == true then
        while tonumber(percent) <= minimun_energy and getgenv().is_out_of_energy == true do
            if getgenv().restock_energy == true and came == false then Sprint("Server",true);moveTo(game:GetService("Workspace").Ceilings.Sofa.Seat.Position);came = true end
            percent = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stamina.Bar.Amount.Text:gsub("%\%","")
            wait(1.5)
        end
        if getgenv().restock_energy == true then 
            me.Character.Humanoid:ChangeState(3) -- jump
        end
        getgenv().is_out_of_energy = false
    end
end

-- element[1, 2]
table.insert(getgenv().connection,game:GetService("Workspace").ChildAdded:Connect(function(v)
    spawn(function()
        --wait(wait_item['fuel_car'])
        if getgenv().fuel_cars == true and v.ClassName == "Model" and string.find(v.Name:lower(),"car_") then
            local lid = v:WaitForChild("Lid")
            local promt = lid:WaitForChild("Refuel") or lid:WaitForChild("FinishFuel")
            if promt ~= nil then 
                repeat wait(0.1) until is_waiting_for_fuel == false
                moveTo(v.Root.Position,promt);wait_for_energy()
                wait(1)
                if is_waiting_for_fuel == true then
                    repeat wait(0.1) until is_waiting_for_fuel == false
                    moveTo(v.Root.Position,promt);wait_for_energy()
                end
            end
            local promt = lid:WaitForChild("FinishFuel")
            if promt ~= nil then 
                moveTo(v.Root.Position,promt);wait_for_energy()
            end
        end
    end)
end))

for i,v in pairs(game:GetService("Workspace").Windows:GetChildren()) do
    table.insert(getgenv().trash_cons,v.Attachment.Clean.Changed:Connect(function()
        if v.Attachment.Clean.Enabled and getgenv().clean_spots == true then moveTo(v.Position,v.Attachment.Clean) end
    end))
end
for i,v in pairs(game:GetService("Workspace").Solar.Panels:GetChildren()) do
    table.insert(getgenv().trash_cons,v.Stand.CleanPosition.Clean.Changed:Connect(function()
        if v.Stand.CleanPosition.Clean.Enabled == true and getgenv().clean_spots == true then
            RMe(1);interact(v.Stand.CleanPosition.Clean);RMe(0)
            wait(wait_item["spots"])
        end
    end))
end
table.insert(getgenv().connection,game:GetService("Workspace").Stains.ChildAdded:Connect(function(v)
    if getgenv().clean_spots == true and v.ClassName == "Part" and v.Name == "Spot" then
        moveTo(v.Position,v.Clean)
    end
end))
table.insert(getgenv().connection,game:GetService("Workspace").Windows.ChildAdded:Connect(function(v)
    v.Attachment.Clean.Changed:Connect(function()
        if v.Attachment.Clean.Enabled and getgenv().clean_spots == true then moveTo(v.Position,v.Clean) end
    end)
end))
-- notifications hook
table.insert(getgenv().connection,game:GetService("Players").LocalPlayer.PlayerGui.NotificationUI.Notifications.ActiveNotifications.ChildAdded:Connect(function(a)
    local text = a.Primary.BodyText.Text
    local title = a.Primary["1"].HeaderHolder.Header.Text
    warn("Notification Title: "..title.." | text: "..text)
    if text == "Not enough fuel to refill this car. Buy more and try again." then
        if getgenv().restock_items == true then
            is_waiting_for_fuel = true
            Buy("fuel","Station")
        else
            is_waiting_for_fuel = true
        end
    elseif string.find(text:lower(),"gasoline") then
        is_waiting_for_fuel = false
    elseif text == "Gas Station can not afford this purchase." and getgenv().use_client_money == true then
        Buy(getgenv().last_buy_item,"Client")
    elseif text == "Only the Manager can purchase more stock when one is present." then
        elements[4]:Change({state=false})
    elseif title == "Out of Energy" then
        getgenv().is_out_of_energy = true
        Energy()
    elseif text == "Station is now closed!" and getgenv().off_lights == true then
        if tostring(power_buttons["Shop Lights"].Parent.BrickColor) == "Sea green" then
            RMe(1)
            Tween:Create(me.Character.HumanoidRootPart,TweenInfo.new(.3),{CFrame = power_buttons["Shop Lights"].Parent.CFrame}):Play();wait(.35)
            interact(power_buttons["Shop Lights"])
            wait(.3)
            RMe(0)
        end
    elseif text == "Station is now open!" and getgenv().off_lights == true then
        if tostring(power_buttons["Shop Lights"].Parent.BrickColor) == "Persimmon" then
            RMe(1)
            Tween:Create(me.Character.HumanoidRootPart,TweenInfo.new(.3),{CFrame = power_buttons["Shop Lights"].Parent.CFrame}):Play();wait(.35)
            interact(power_buttons["Shop Lights"])
            wait(.3)
            RMe(0)
        end
    end
end))

-- UI + Actions start
elements[1] = page1:CreateToggle({state=getgenv().fuel_cars,name="Fuel cars"},function(t)
    getgenv().fuel_cars = t
    if getgenv().fuel_cars == true then
        spawn(function()
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if getgenv().fuel_cars == true and v.ClassName == "Model" and string.find(v.Name:lower(),"car_") then
                    spawn(function()
                        local lid = v:WaitForChild("Lid")
                        local promt = lid:FindFirstChild("Refuel") or lid:WaitForChild("FinishFuel",10);wait_for_energy()
                        if promt ~= nil then 
                            repeat wait(0.1) until is_waiting_for_fuel == false
                            moveTo(v.Root.Position,promt)
                            if promt.Name == "Refuel" then
                                local promt = lid:WaitForChild("FinishFuel",10);wait_for_energy()
                                if promt ~= nil then 
                                    moveTo(v.Root.Position,promt)
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
end)
elements[7] = page1:CreateToggle({state=getgenv().cashier,name="Cashier"},function(t)
    getgenv().cashier = t
    if getgenv().cashier == true then
        spawn(function()
            while wait(wait_time) and getgenv().cashier == true do
                wait_for_energy()
                for i,v in pairs(game:GetService("Workspace").Checkouts:GetChildren()) do
                    for q,w in pairs(v.Items:GetChildren()) do
                        pcall(function()
                            repeat wait(.1) until w.Root.Scan.Enabled == true
                            interact(w.Root.Scan)
                            wait(wait_item["cashier"])
                        end)
                    end
                    
                end
            
            end
            
        end)
        
    end
end)
local is_working_now = false
elements[2] = page1:CreateToggle({state=getgenv().clean_spots,name="Clean spots"},function(t)
    getgenv().clean_spots = t
    if getgenv().clean_spots == true then
        spawn(function()
            for i,v in pairs(game:GetService("Workspace").Stains:GetChildren()) do
                moveTo(v.Position,v.Clean)
            end
            for i,v in pairs(game:GetService("Workspace").Windows:GetChildren()) do
                if v.Attachment.Clean.Enabled then moveTo(v.Position,v.Attachment.Clean) end
            end
            for i,v in pairs(game:GetService("Workspace").Solar.Panels:GetChildren()) do
                if v.Stand.CleanPosition.Clean.Enabled then
                    RMe(1);interact(v.Stand.CleanPosition.Clean);RMe(0)
                    wait(wait_item["spots"])
                end
            end
        end)
    end
end)
elements[4] = page1:CreateToggle({state=getgenv().restock_items,name="Restock items",desc="Restock items (fuel)"},function(t)
    getgenv().restock_items = t
end)
elements[9] = page1:CreateToggle({state=getgenv().restock_energy,name="Restock energy"},function(t)
    getgenv().restock_energy = t
end)
elements[5] = page1:CreateToggle({state=getgenv().use_client_money,name="Use client money",desc="If station have not enough money will use your money"},function(t)
    getgenv().use_client_money = t
end)
elements[8] = page1:CreateToggle({state=getgenv().off_lights,name="Off/On lights on station close/open"},function(t)
    getgenv().off_lights = t
end)
