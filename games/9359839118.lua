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
getgenv().is_executed = false

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
    if getgenv().fuel_cars == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().fuel_cars == true and getgenv().is_executed == false do
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
    if getgenv().clean_spots == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().clean_spots == true and getgenv().is_executed == false do
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
    if getgenv().clean_windows == true and getgenv().is_executed == false then
        spawn(function()
            while wait(wait_time) and getgenv().clean_windows == true and getgenv().is_executed == false do
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
page1:CreateButton({name="execute script by TheSynapseGuy",desc=[[P - Auto refuel
L - Auto cashier
M - Auto clean
Z - Auto restock
https://discord.gg/bCfdyG3SMz]]},function()
    if getgenv().is_executed == true then return end
    getgenv().is_executed = true
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/AureusBp2/GasStation/main/Stock.lua'),true))()
    --[[
    
       Gas Station Simulator Autofarm
    
       Made by TheSynapseGuy on V3rm
       modified for the latest updates by Meta
       Last tested for V1.0.3b
       https://discord.gg/bCfdyG3SMz for support! (bugs n shit) -updates
    
       Default kebyinds
        P - Auto refuel
        L - Auto cashier
        M - Auto clean
        Z - Auto restock - restock works by detecting when a item is taken and replaces it
    
       VV Settings below VV
    ]]
    
    local TravelSpeed = 20 -- going too fast might get you kicked
    
    local ToggleFuelKey = Enum.KeyCode.P
    local ToggleCleanKey = Enum.KeyCode.M
    local ToggleCashierKey = Enum.KeyCode.L
    local ToggleRestockKey = Enum.KeyCode.Z
    
    local AllowFuelBuy = true -- For auto refuel
    local AllowItemsBuy = true -- For auto restocking
    
    local MoneySource = "Station" -- Choose "Station" or "Client"
    local AllowSecondarySource = true
    local SecondaryMoneySource = "Client" -- If Primary Money source does not have enough it will use this
    local AllowStationSpendingDuringBankruptcy = false -- If enabled it allows the bot to purchase using station money even when near bankruptcy
    
    
    
    
    
    
    -- Ignore everything below here
    local GasEnabled = false
    local CleaningEnabled = false
    local RestockEnabled = false
    local CashierEnabled = false
    local ItemRestockQueue = {}
    local ReplicatedStorage = game:GetService("ReplicatedStorage"); local Players = game:GetService("Players"); local LocalPlayer = Players.LocalPlayer; local RunService = game:GetService("RunService")
    local ActionRemote = ReplicatedStorage:WaitForChild("Remote")
    local PumpsFolder = workspace:WaitForChild("Pumps")
    local StorageFolder = workspace:WaitForChild("Storage")
    local ShelvesFolder = workspace:WaitForChild("Shelves")
    local StatsHolder = require(ReplicatedStorage:WaitForChild("StatHolder"))
    local InputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    
    local function GetPlayerCharacter() return LocalPlayer.Character or LocalPlayer.CharacterAdded:wait(); end
    local function GetStoreGasoline() return PumpsFolder:GetAttribute("Gasoline"); end
    local function GetMoneyOfSource(Source : StringValue) if Source == "Station" then return workspace.Station:GetAttribute("Money") elseif Source == "Client" then return LocalPlayer:GetAttribute("Money") end end
    local function FindItemCatergory(ItemName : StringValue)
       local ShopTable = StatsHolder.Shops
       for FirstName,FirstCatergory in pairs(ShopTable) do
           if FirstCatergory ~= "Syntin Petrol Co" then
               for SecondName,SecondCatergory in pairs(FirstCatergory) do
                   if SecondCatergory[ItemName] ~= nil then
                       return {
                           ["Item"] = ItemName,
                           ["ItemProvider"] = FirstName,
                           ["ItemCatergory"] = SecondName,
                           ["ItemPrice"] = SecondCatergory[ItemName][2]
                       }
                   end
               end
           end
       end
    end
    local function DecideSource(MinimumMoneyNeeded : IntValue)
       local PrimarySourceMoney = GetMoneyOfSource(MoneySource)
       if MoneySource == "Client" then
           if PrimarySourceMoney >= MinimumMoneyNeeded then
               return MoneySource
           end
       else
           local StationBankrupt = not (workspace.Station:GetAttribute("Money") > workspace.Station:GetAttribute("EstBills"))
           if (StationBankrupt and AllowStationSpendingDuringBankruptcy) or (not StationBankrupt) then
               if LocalPlayer:GetAttribute("Contributions") >= MinimumMoneyNeeded then
                   if #game.Teams.Manager:GetPlayers() > 0 then
                       if LocalPlayer.Team == game.Teams.Manager then
                           return MoneySource
                       end
                   else
                       return MoneySource
                   end
               end
           end
       end
       if AllowSecondarySource then
           local SecondarySourceMoney = GetMoneyOfSource(SecondaryMoneySource)
           if SecondaryMoneySource == "Client" then
               if SecondarySourceMoney >= MinimumMoneyNeeded then
                   return SecondaryMoneySource
               end
           else
               local StationBankrupt = not (workspace.Station:GetAttribute("Money") > workspace.Station:GetAttribute("EstBills"))
               if (StationBankrupt and AllowStationSpendingDuringBankruptcy) or (not StationBankrupt) then
                   if LocalPlayer:GetAttribute("Contributions") >= MinimumMoneyNeeded then
                       if #game.Teams.Manager:GetPlayers() > 0 then
                           if LocalPlayer.Team == game.Teams.Manager then
                               return SecondaryMoneySource
                           end
                       else
                           return SecondaryMoneySource
                       end
                   end
               end
           end
       end
       return MoneySource
    end
    local function BuyFuel()
       ActionRemote:FireServer("BuyItem","Syntin Petrol Co","Gasoline 87", 1,DecideSource(9));
    end
    local function GetPlayerStamina() return LocalPlayer:GetAttribute("Stamina"); end
    
    if _G.dAAcG3fvBqVoPzVnAFk == nil then _G.dAAcG3fvBqVoPzVnAFk = "" end function notify(a,b,c)local d=c or function()return end;local e=b or false;if a==_G.dAAcG3fvBqVoPzVnAFk and e==false then return end;spawn(function()for f,g in pairs(game.CoreGui:GetChildren())do spawn(function()if g.Name=="MNotify"then pcall(function()g.ImageButton.ZIndex=58;g.ImageButton.TextLabel.ZIndex=59;g.ImageButton:TweenPosition(UDim2.new(0.01,0,1,0),"Out","Quint",.7,true)game:GetService("TweenService"):Create(g.ImageButton.TextLabel,TweenInfo.new(0.8,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0,false,0),{TextTransparency=1})wait(1)g:Destroy()end)end end)end;_G.dAAcG3fvBqVoPzVnAFk=a;local d=c or function()return end;local function h(i,j)local k=Instance.new(i)for f,g in pairs(j)do k[f]=g end;return k end;local l=h('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='MNotify',Parent=game.CoreGui})local m=h('ImageButton',{Image='rbxassetid://1051186612',ImageColor3=Color3.new(0.129412,0.129412,0.129412),ImageRectOffset=Vector2.new(0,0),ImageRectSize=Vector2.new(0,0),ImageTransparency=0,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(20,20,20,20),AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882,0.164706,0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.00999999978,0,1,0),Rotation=0,Selectable=true,Size=UDim2.new(0,234,0,40),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=60,Name='ImageButton',Parent=l})local n=h('TextLabel',{Font=Enum.Font.SourceSansLight,FontSize=Enum.FontSize.Size24,Text=a,TextColor3=Color3.new(0.807843,0.807843,0.807843),TextScaled=false,TextSize=24,TextStrokeColor3=Color3.new(0,0,0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882,0.164706,0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.132478639,0,0,0),Rotation=0,Selectable=false,Size=UDim2.new(0,174,0,40),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=61,Name='TextLabel',Parent=m})local o=h('UIListLayout',{Padding=UDim.new(0,0),FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=Enum.HorizontalAlignment.Center,SortOrder=Enum.SortOrder.Name,VerticalAlignment=Enum.VerticalAlignment.Top,Name='UIListLayout',Parent=m})local p=1;if string.len(a)<=49 then m.Size=UDim2.new(0,game:GetService("TextService"):GetTextSize(a,24,Enum.Font.SourceSansLight,Vector2.new(500,900)).X+57,0,40)elseif string.len(a)>49 then p=math.ceil(string.len(string.sub(a,49))/9)m.Size=UDim2.new(0,game:GetService("TextService"):GetTextSize(a,24,Enum.Font.SourceSansLight,Vector2.new(500+p*100,900)).X+57,0,40)end;m:TweenPosition(UDim2.new(0.01,0,1,-60),"Out","Quint",.7,true)spawn(function()wait(6.7)pcall(function()m.ZIndex=58;n.ZIndex=59;m:TweenPosition(UDim2.new(0.01,0,1,0),"Out","Quint",.7,true)_G.dAAcG3fvBqVoPzVnAFk=""wait(1)l:Destroy()end)end)m.MouseButton1Up:Connect(function()if c==nil then return end;spawn(function()pcall(function()m.ZIndex=58;n.ZIndex=59;m:TweenPosition(UDim2.new(0.01,0,1,0),"Out","Quint",.7,true)_G.dAAcG3fvBqVoPzVnAFk=""wait(1)l:Destroy()end)end)d()end)end)end
    function roundNumber(num, numDecimalPlaces) -- https://devforum.roblox.com/t/rounding-to-1-decimal-point/673504
     return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
    end
    notify("Welcomem @"..game.Players.LocalPlayer.Name.."!")
    
    local function TravelToCFrame(TargetCFrame : CFrame)
       local PlayerCharacter = GetPlayerCharacter()
       if PlayerCharacter then
           local DistanceBetweenPoints = ( PlayerCharacter.HumanoidRootPart.Position - TargetCFrame.Position ).Magnitude
           local TimeNeeded = roundNumber(DistanceBetweenPoints / TravelSpeed, 3)
           local Tween = TweenService:Create(
               PlayerCharacter.HumanoidRootPart,
               TweenInfo.new(
                   TimeNeeded,
                   Enum.EasingStyle.Linear,
                   Enum.EasingDirection.Out
               ),
               {
                   CFrame = TargetCFrame
               }
           )
           Tween:Play()
           task.wait(TimeNeeded)
       end
    end
    
    local function RestoreEnergy(MinimumEnergy : IntValue)
       notify("Resting",true)
       local PlayerCharacter = GetPlayerCharacter()
       local PreviousCFrame = PlayerCharacter.HumanoidRootPart.CFrame
       TravelToCFrame(workspace.Ceilings.Sofa.Seat.CFrame)
       task.wait(2)
       while true do
           if GetPlayerStamina() >= MinimumEnergy then
               break
           end
           task.wait(0.5)
       end
       PlayerCharacter.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
       TravelToCFrame(PreviousCFrame)
    end
    
    local function FindPumpToCar(CarModel : Instance)
       local CarPosition = CarModel.PrimaryPart.Position
       local Pump
       local PumpDistance = 999
       for _,v in pairs(PumpsFolder:GetChildren()) do
           local DistanceBetweenPump = (CarPosition - v.Screen.Position).Magnitude
           if DistanceBetweenPump < PumpDistance then
               Pump = v
               PumpDistance = DistanceBetweenPump
           end
       end
       return Pump
    end
    
    local function DoesPumpNeedToBeTakenOut(CarModel : Instance)
       if CarModel:FindFirstChild("Lid") then
           if CarModel.Lid:FindFirstChild("FinishFuel") then
               return true
           end
       end
       return false
    end
    
    local function RefuelCar(CarModel : Instance)
       local CarPump = FindPumpToCar(CarModel)
       if DoesPumpNeedToBeTakenOut(CarModel) then
           TravelToCFrame(CarModel.Lid.CFrame)
           ActionRemote:FireServer("FinishFuel", CarModel, CarPump)
           return
       end
       if CarModel:GetAttribute("IsRefueld") or CarModel:GetAttribute("IsRefilling") then return end
       local RequiredFuel = CarModel:GetAttribute("RequiredFuel")
       local TotalAttempts = 0
       if AllowFuelBuy then
           while true do
               TotalAttempts += 1
               local StoreFuel = GetStoreGasoline()
               if StoreFuel >= RequiredFuel then
                   break
               end
               notify("Attempting to buy 15L of fuel",true)
               BuyFuel()
               task.wait(1)
               if TotalAttempts > 10 then
                   break
               end
           end
       end
       if GetPlayerStamina() < 5 then
           RestoreEnergy(95)
       end
       local StoreFuel = GetStoreGasoline()
       if StoreFuel >= RequiredFuel then
           if CarModel.Lid:FindFirstChild("Refuel") then
               TravelToCFrame(CarModel.Lid.CFrame)
               notify("Refilling "..CarModel.Name,true)
               ActionRemote:FireServer("FuelCustomer", CarModel, CarPump)
               task.wait(4)
           end
       end
    end
    local PreviousItem
    local function ScanItem(Item : Instance, CashierModel : Instance)
       if GetPlayerStamina() < 5 then
           RestoreEnergy(95)
       end
       if Item ~= PreviousItem then
           local DistanceFromItem = ( Item.Root.Position - GetPlayerCharacter().HumanoidRootPart.Position ).Magnitude
           if DistanceFromItem > 10 then
               notify("Too far away from cash register",true)
               TravelToCFrame(CFrame.new(1.46752572, 3, -6.53523779, 0.726744831, -4.74023416e-08, 0.68690753, 9.53963948e-08, 1, -3.19205924e-08, -0.68690753, 8.87266296e-08, 0.726744831))
           end
           if Item.Root:FindFirstChild("Scan") then
               if Item.Root:FindFirstChild("Scan").Enabled then
                   if not CashierModel:GetAttribute("InUse") then
                       notify("Scanning "..Item.Name,true)
                       ActionRemote:FireServer("ScanItem",Item,CashierModel)
                       Item.Root:FindFirstChild("Scan").Enabled = false
                       PreviousItem = Item
                       task.wait(3)
                   end
               end
           end
       end
    end
    InputService.InputBegan:Connect(function(input, gameProcessedEvent)
       if not gameProcessedEvent then
           if input.KeyCode == ToggleFuelKey then
               GasEnabled = not GasEnabled
               notify("Fuel enabled: "..tostring(GasEnabled),true)
           end
           if input.KeyCode == ToggleCashierKey then
               CashierEnabled = not CashierEnabled
               notify("Cashier enabled: "..tostring(CashierEnabled),true)
           end
           if input.KeyCode == ToggleCleanKey then
               CleaningEnabled = not CleaningEnabled
               notify("Cleaning enabled: "..tostring(CleaningEnabled),true)
           end
           if input.KeyCode == ToggleRestockKey then
               RestockEnabled = not RestockEnabled
               notify("Restocking enabled: "..tostring(RestockEnabled),true)
               if not RestockEnabled then
                   ItemRestockQueue = {}
               end
           end
       end
    end)
    
    local function ItemRemoved(Item : Instance, Shelf : Instance)
       if RestockEnabled then
           table.insert(ItemRestockQueue,{
               ["ItemShelf"] = Shelf,
               ["ItemType"] = Item.Name,
               ["ItemCFrame"] = Item.PrimaryPart.CFrame - Vector3.new(0,Item.PrimaryPart.Size.Y/2,0)
           })
       end
    end
    local function NewShelfAdded(shelf : Instance)
       if shelf:FindFirstChild("Content") then
           shelf.Content.ChildRemoved:connect(function(Item)
               ItemRemoved(Item,shelf)
           end)
       end
    end
    
    for _,v in pairs(ShelvesFolder:GetChildren()) do
       NewShelfAdded(v)
    end
    ShelvesFolder.ChildAdded:Connect(NewShelfAdded)
    
    while true do
       task.wait(0.1)
       
       if CashierEnabled then
           pcall(function()
               for _,v in pairs(workspace.Checkouts:GetChildren()) do
                   for _,h in pairs(v.Items:GetChildren()) do
                       ScanItem(h,v)
                   end
               end
           end)
       end
       if GasEnabled then
           pcall(function()
               for _,v in pairs(workspace:GetChildren()) do
                   if v.Name:sub(1,4) == "Car_" then
                       RefuelCar(v)
                       task.wait(1)
                   end
               end
           end)
       end
       if CleaningEnabled then
           pcall(function()
               if GetPlayerStamina() < 5 then
                   RestoreEnergy(95)
               end
               for _,v in pairs(workspace.Windows:GetChildren()) do
                   if v:FindFirstChild("Attachment") then
                       if v.Attachment.Clean.Enabled then
                           notify("Cleaning window",true)
                           TravelToCFrame(v.CFrame)
                           ActionRemote:FireServer("Clean",v.Attachment.Clean)
                           task.wait(4)
                       end
                   end
               end
               for _,v in pairs(workspace.Solar.Panels:GetChildren()) do
                   if v.Stand:FindFirstChild("CleanPosition") then
                       if v.Stand.CleanPosition.Clean.Enabled then
                           notify("Cleaning Solarpanel",true)
                           TravelToCFrame(v.Stand.CFrame)
                           ActionRemote:FireServer("Clean",v.Stand.CleanPosition.Clean)
                           task.wait(4)
                       end
                   end
               end
               for _,v in pairs(workspace:GetChildren()) do
                   if v.Name == "Spot" then
                       notify("Cleaning spot")
                       TravelToCFrame(v.CFrame + Vector3.new(0,3,0))
                       ActionRemote:FireServer("Clean",v.Clean)
                       task.wait(1)
                   end
               end
           end)
       end
       if RestockEnabled then
           pcall(function()
           if #ItemRestockQueue >= 1 then
               local ItemRestockQueueCache = ItemRestockQueue
               ItemRestockQueue = {}
               for _, iteminfo in pairs(ItemRestockQueueCache) do
                   if GetPlayerStamina() < 5 then
                       RestoreEnergy(95)
                   end
                   if StorageFolder:FindFirstChild(iteminfo["ItemType"]) then
                       local RemainingItems = StorageFolder:FindFirstChild(iteminfo["ItemType"]):GetAttribute("Storage")
                       if RemainingItems <= 0 then
                           if AllowItemsBuy then
                               ItemShopInfo = FindItemCatergory(iteminfo["ItemType"])
                               local Attempts = 0
                               while true do
                                   Attempts += 1
                                   RemainingItems = StorageFolder:FindFirstChild(iteminfo["ItemType"]):GetAttribute("Storage")
                                   if RemainingItems > 0 then
                                       break
                                   end
                                   if Attempts > 5 then
                                       break
                                   end
                                   notify("Attempting to buy "..iteminfo["ItemType"],true)
                                   ActionRemote:FireServer("BuyItem",ItemShopInfo["ItemProvider"],ItemShopInfo["ItemCatergory"], iteminfo["ItemType"],DecideSource(ItemShopInfo["ItemPrice"]));
                                   task.wait(1.5)
                               end
                           end
                       end
                       RemainingItems = StorageFolder:FindFirstChild(iteminfo["ItemType"]):GetAttribute("Storage")
                       if RemainingItems > 0 then
                           --TravelToCFrame(iteminfo["ItemShelf"].PrimaryPart.CFrame) not really needed
                           ActionRemote:FireServer("PlaceProduct",iteminfo["ItemType"],iteminfo["ItemCFrame"])
                           notify("Restocked "..iteminfo["ItemType"],true)
                       else
                           notify("Failed to restock "..iteminfo["ItemType"]..", not enough stock",true)
                       end
                   end
               end
           end
           end)
       end
    end
end)
