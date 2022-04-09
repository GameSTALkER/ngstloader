local lib = {}
function lib:CreateWin(title, configid)

    local function configSave(loc, var, val)
        if configid == nil then return "unsupported" end
        local HttpService = game:GetService("HttpService")
        local rr = readfile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json")
        
        if not isfolder("GUiLibRewrite") then makefolder("GUiLibRewrite") end
        if loc == "Local" then 
            if not isfolder("GUiLibRewrite/"..game.PlaceId) then makefolder("GUiLibRewrite/"..game.PlaceId) end
            if not isfile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json") then writefile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json", "{}") end
            rr = readfile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json")
        elseif loc == "Global" then 
            if not isfile("GUiLibRewrite/General.json") then writefile("GUiLibRewrite/General.json", "{}") end 
            rr = readfile("GUiLibRewrite/General.json")
        end

        local json = HttpService:JSONDecode(rr)
        json[var] = val
        local tosave = HttpService:JSONEncode(json)
        
        if loc == "Local" then writefile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json",tosave)
        elseif loc == "Global" then writefile("GUiLibRewrite/General.json",tosave) end
        return "saved"
    end
    local function configGet(loc, var,retval)
        if configid == nil then return retval end
        local HttpService = game:GetService("HttpService")
        local rr
        
        if not isfolder("GUiLibRewrite") then makefolder("GUiLibRewrite") end
        if loc == "Local" then 
            if not isfolder("GUiLibRewrite/"..game.PlaceId) then makefolder("GUiLibRewrite/"..game.PlaceId) end
            if not isfile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json") then writefile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json", "{}") end
            rr = readfile("GUiLibRewrite/"..game.PlaceId.."/"..title.."-"..configid..".json")
        elseif loc == "Global" then 
            if not isfile("GUiLibRewrite/General.json") then writefile("GUiLibRewrite/General.json", "{}") end 
            rr = readfile("GUiLibRewrite/General.json")
        end

        local json = HttpService:JSONDecode(rr)
		if json[var] == nil then json[var] = retval end
		
        return json[var]
    end
    local function removeShit()
        if _G.nGSTGUi ~= nil then
		    for i=1,_G.nGSTGUi["Tabless"],1 do
		    	if _G.nGSTGUi[i.."BindNum"] > 0 then
					for q=1,_G.nGSTGUi[i.."BindNum"],1 do
						_G.nGSTGUi[i.."Bind"..q]:Disconnect()
						_G.nGSTGUi[i.."Bind"..q] = nil
						_G.nGSTGUi[i.."BindLoop"..q]:Disconnect()
						_G.nGSTGUi[i.."BindLoop"..q] = nil
					end
				end
		    end
	    end
    end
    local function changeTab(id,obj)
        for i,v in pairs(obj:GetChildren()) do
            if "Table "..id == v.Name or id == v.Name then v.Visible = true
            else v.Visible = false end
        end
    end
    local sTween = game:GetService("TweenService")
    local function _App(int, obj)
        if int == 1 then
            for i,v in pairs(obj:GetDescendants()) do
                if table.find({"ImageLabel","ImageButton"},v.ClassName) then sTween:Create(v,TweenInfo.new(0.6),{ImageTransparency = int}):Play() end
                if table.find({"TextLabel","TextButton","TextBox"},v.ClassName) then sTween:Create(v,TweenInfo.new(0.6),{TextTransparency = int}):Play() end
            end
            wait(1)
        else
	    if configid then
            	sTween:Create(obj,TweenInfo.new(0.6),{Position = UDim2.new(0,configGet("Global", "positionX",300),0,configGet("Global", "positionY",200))}):Play()
	    else sTween:Create(obj,TweenInfo.new(0.6),{Position = UDim2.new(0.5,0,0.313,0)}):Play() end
        end
    end

    local tablenum = 0
    local MenuDragging = false
    local SelectingTabs = false

    local function RandomID(count)
        local indificator = ""
        local symbols = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m","1","2","3","4","5","6","7","8","9","0","!","@","#","$","%","^","&","*"}
        for i = 1,count do indificator = indificator .. symbols[math.random(#symbols)] end
        return indificator
    end

    if _G.nGSTGUi == nil then _G.nGSTGUi = {} end
    _G.nGSTGUi['Id'] = RandomID(21)
    local UIS = game:GetService("UserInputService")

    local ScreenGui = Instance.new("ScreenGui")
     local Main = Instance.new("TextButton")
      local bgMain = Instance.new("ImageLabel")
      local Title = Instance.new("TextLabel")
      local close = Instance.new("ImageButton")
       local bgclose = Instance.new("ImageLabel")
      local hide = Instance.new("ImageButton")
       local bghide = Instance.new("ImageLabel")
     local popup_tip = Instance.new("TextLabel") 
      local tip_bg = Instance.new("ImageLabel")

     local Body = Instance.new("ImageLabel")

     local dark = Instance.new("ImageLabel")
      local tab_limiter = Instance.new("Frame")
       local tabs = Instance.new("ImageLabel")
        local tabsFrame = Instance.new("ScrollingFrame")
         local TUIGridLayout = Instance.new("UIGridLayout")
    -- 

    ScreenGui.Name = _G.nGSTGUi['Id']
     if syn then
         syn.protect_gui(ScreenGui)
         ScreenGui.Parent = game:GetService("CoreGui")
     elseif get_hidden_gui or gethui then
         ScreenGui.Parent = gethui()
     else
         ScreenGui.Parent = game:GetService("CoreGui")
     end
     ScreenGui.ResetOnSpawn = false
     Main.Name = "Main"
      Main.Parent = ScreenGui
      Main.AnchorPoint = Vector2.new(0.5, 0.5)
      Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
      Main.BackgroundTransparency = 1
      Main.BorderSizePixel = 0
      Main.Position = UDim2.new(0.5, 0, 1.3, 0)
      Main.Size = UDim2.new(0, 555, 0, 30)
      Main.Font = Enum.Font.SourceSans
      Main.Text = ""
      Main.Localize = false
      Main.TextColor3 = Color3.fromRGB(0, 0, 0)
      Main.TextSize = 14
      bgMain.Name = "bg"
       bgMain.Parent = Main
       bgMain.Active = true
       bgMain.AnchorPoint = Vector2.new(0.5, 0.5)
       bgMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       bgMain.BackgroundTransparency = 1
       bgMain.Position = UDim2.new(0.5, 0, 0.5, 0)
       bgMain.Selectable = true
       bgMain.Size = UDim2.new(1, 0, 1, 0)
       bgMain.Image = "rbxassetid://3570695787"
       bgMain.ImageColor3 = Color3.fromRGB(20, 20, 20)
       bgMain.ScaleType = Enum.ScaleType.Slice
       bgMain.SliceCenter = Rect.new(100, 100, 100, 100)
       bgMain.SliceScale = 0.040
      Title.Name = "Title"
       Title.Parent = Main
       Title.AnchorPoint = Vector2.new(0, 0.5)
       Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       Title.BackgroundTransparency = 1
       Title.BorderSizePixel = 0
       Title.Position = UDim2.new(0.046846848, 0, 0.332282007, 0)
       Title.Size = UDim2.new(0, 250, 0, 19)
       Title.Font = Enum.Font.GothamBold
       Title.Text = title
       Title.Localize = false
       Title.TextColor3 = Color3.fromRGB(255, 255, 255)
       Title.TextSize = 18
       Title.TextXAlignment = Enum.TextXAlignment.Left
      close.Name = "close"
       close.Parent = Main
       close.AnchorPoint = Vector2.new(0.5, 0.5)
       close.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
       close.BackgroundTransparency = 1
       close.BorderSizePixel = 0
       close.Position = UDim2.new(0.980180204, 0, 0.300000012, 0)
       close.Size = UDim2.new(0.0342342332, 0, 0.633333325, 0)
       close.ZIndex = 2
       close.Image = "rbxassetid://3926305904"
       close.ImageRectOffset = Vector2.new(284, 4)
       close.ImageRectSize = Vector2.new(24, 24)
       bgclose.Name = "bg"
        bgclose.Parent = close
        bgclose.AnchorPoint = Vector2.new(0.5, 0.5)
        bgclose.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bgclose.BackgroundTransparency = 1
        bgclose.Position = UDim2.new(0.5, 0, 0.5, 0)
        bgclose.Size = UDim2.new(1, 0, 1, 0)
        bgclose.Image = "rbxassetid://3570695787"
        bgclose.ImageColor3 = Color3.fromRGB(30, 30, 30)
        bgclose.ScaleType = Enum.ScaleType.Slice
        bgclose.SliceCenter = Rect.new(100, 100, 100, 100)
        bgclose.SliceScale = 0.040
      hide.Name = "hide"
       hide.Parent = Main
       hide.AnchorPoint = Vector2.new(0.5, 0.5)
       hide.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
       hide.BackgroundTransparency = 1
       hide.BorderSizePixel = 0
       hide.Position = UDim2.new(0.93603605, 0, 0.300000012, 0)
       hide.Size = UDim2.new(0.0342342332, 0, 0.633333325, 0)
       hide.ZIndex = 2
       hide.Image = "rbxassetid://3926307971"
       hide.ImageRectOffset = Vector2.new(884, 284)
       hide.ImageRectSize = Vector2.new(36, 36)
       bghide.Name = "bg"
        bghide.Parent = hide
        bghide.AnchorPoint = Vector2.new(0.5, 0.5)
        bghide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bghide.BackgroundTransparency = 1
        bghide.Position = UDim2.new(0.5, 0, 0.5, 0)
        bghide.Size = UDim2.new(1, 0, 1, 0)
        bghide.Image = "rbxassetid://3570695787"
        bghide.ImageColor3 = Color3.fromRGB(30, 30, 30)
        bghide.ScaleType = Enum.ScaleType.Slice
        bghide.SliceCenter = Rect.new(100, 100, 100, 100)
        bghide.SliceScale = 0.040
      Body.Name = "Body"
       Body.Parent = Main
       Body.AnchorPoint = Vector2.new(0.5, 0)
       Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       Body.BackgroundTransparency = 1
       Body.Position = UDim2.new(0.500239491, 0, 0.664564013, 0)
       Body.Size = UDim2.new(1,0,0,0)
       Body.Image = "rbxassetid://3570695787"
       Body.ImageColor3 = Color3.fromRGB(10, 10, 10)
       Body.ScaleType = Enum.ScaleType.Slice
       Body.SliceCenter = Rect.new(100, 100, 100, 100)
       Body.SliceScale = 0.040
       popup_tip.Name = "Tip"
        popup_tip.Parent = ScreenGui
        popup_tip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        popup_tip.BackgroundTransparency = 1
        popup_tip.BorderSizePixel = 0
        popup_tip.Position = UDim2.new(0.303095788, 0, 0.372391582, 0)
        popup_tip.Size = UDim2.new(0, 110, 0, 35)
        popup_tip.ZIndex = 100
        popup_tip.Font = Enum.Font.GothamBold
        popup_tip.Text = " "
        popup_tip.Localize = false
        popup_tip.TextTransparency = 1
        popup_tip.TextColor3 = Color3.fromRGB(255, 255, 255)
        popup_tip.TextSize = 14
        popup_tip.TextXAlignment = Enum.TextXAlignment.Left
        tip_bg.Name = "bg"
         tip_bg.Parent = popup_tip
         tip_bg.AnchorPoint = Vector2.new(0.5, 0.5)
         tip_bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         tip_bg.BackgroundTransparency = 1
         tip_bg.ZIndex = 99
         tip_bg.Position = UDim2.new(0.5, 0, 0.5, 0)
         tip_bg.Size = UDim2.new(1, 0, 1, 0)
         tip_bg.Image = "rbxassetid://3570695787"
         tip_bg.ImageColor3 = Color3.fromRGB(30, 30, 30)
         tip_bg.ImageTransparency = 1
         tip_bg.ScaleType = Enum.ScaleType.Slice
         tip_bg.SliceCenter = Rect.new(100, 100, 100, 100)
         tip_bg.SliceScale = 0.040
      dark.Name = "dark"
       dark.Parent = Main
       dark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       dark.BackgroundTransparency = 1
       dark.BorderSizePixel = 0
       dark.Position = UDim2.new(0.0128521342, 0, 1, 0)
       dark.Size = UDim2.new(0, 540, 0, 281)
       dark.ZIndex = 5
       dark.Image = "rbxassetid://3570695787"
       dark.ImageColor3 = Color3.fromRGB(0, 0, 0)
       dark.ImageTransparency = 1
       dark.ScaleType = Enum.ScaleType.Slice
       dark.SliceCenter = Rect.new(100, 100, 100, 100)
       dark.SliceScale = 0.040
       tab_limiter.Name = "tab_limiter"
        tab_limiter.Parent = dark
        tab_limiter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tab_limiter.BackgroundTransparency = 1
        tab_limiter.BorderSizePixel = 0
        tab_limiter.ClipsDescendants = true
        tab_limiter.Position = UDim2.new(-0.0132091381, 0, 0, 0)
        tab_limiter.Size = UDim2.new(0, 157, 0, 281)
        tabs.Name = "tabs"
         tabs.Parent = tab_limiter
         tabs.Active = true
         tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         tabs.BackgroundTransparency = 1
         tabs.ClipsDescendants = true
         tabs.Position = UDim2.new(-0.96, 0, 0, 0)
         tabs.Size = UDim2.new(0, 158, 0, 281)
         tabs.ZIndex = 8
         tabs.Image = "rbxassetid://3570695787"
         tabs.ImageColor3 = Color3.fromRGB(35, 35, 35)
         tabs.ScaleType = Enum.ScaleType.Slice
         tabs.SliceCenter = Rect.new(100, 100, 100, 100)
         tabs.SliceScale = 0.040
         tabsFrame.Parent = tabs
          tabsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          tabsFrame.BackgroundTransparency = 1
          tabsFrame.Position = UDim2.new(0.0883534104, 0, 0.0249110311, 0)
          tabsFrame.Size = UDim2.new(0, 136, 0, 230)
          tabsFrame.ScrollBarThickness = 0
          tabsFrame.CanvasSize = UDim2.new(0,0,0,0)
          tabsFrame.ZIndex = 10
          TUIGridLayout.Parent = tabsFrame
           TUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
           TUIGridLayout.CellSize = UDim2.new(1, 0, 0, 25)
    --
    local tip_timer = false
    local tip_db = false
    local function tip_setting(type, _T)
        local _ = UIS:GetMouseLocation()
        if SelectingTabs or MenuDragging then 
            tip_bg.ImageTransparency = 1
            popup_tip.TextTransparency = 1
            return 
        end
        if type == 1 then
            popup_tip.Text = " ".._T
            popup_tip.Position = UDim2.new(0,_.X+5,0,_.Y-20)
            popup_tip.Size = UDim2.new(0,string.len(_T)*8.5,0,35)
            if not tip_db then
                tip_db = true
                tip_timer = true
                wait(1)
                if tip_timer then
                    sTween:Create(tip_bg,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                    sTween:Create(popup_tip,TweenInfo.new(.05),{TextTransparency = 0}):Play()
                end
                tip_db = false
            end
        elseif type == 2 then
            tip_timer = true
            sTween:Create(popup_tip,TweenInfo.new(.1),{Position = UDim2.new(0,_.X+5,0,_.Y-20)}):Play()
        elseif type == 3 then
            sTween:Create(popup_tip,TweenInfo.new(.05),{TextTransparency = 1}):Play()
            sTween:Create(tip_bg,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            tip_timer = false
        end
    end
    do
	    tabs.MouseEnter:Connect(function()
            SelectingTabs = true

			tabsFrame.CanvasSize = UDim2.new(0,0,0,30*tablenum)
	    	sTween:Create(tabs,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(20,20,20)}):Play()
        
	    	sTween:Create(tabs,TweenInfo.new(.25),{Position = UDim2.new(-0.043,0,0,0)}):Play()
	    	sTween:Create(dark,TweenInfo.new(.15),{ImageTransparency = 0.3}):Play()
	    end)
	    tabs.MouseLeave:Connect(function()
            SelectingTabs = false
	    	sTween:Create(tabs,TweenInfo.new(.25),{Position = UDim2.new(-0.96,0,0,0)}):Play()
	    	sTween:Create(dark,TweenInfo.new(.15),{ImageTransparency = 1}):Play()
        
	    	sTween:Create(tabs,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
	    end)
    end
    do
    	Main.MouseButton1Down:Connect(function()
    		MenuDragging = true
    	end)
    	UIS.InputEnded:Connect(function(key)
    		if key.UserInputType == Enum.UserInputType.MouseButton1 then
    			MenuDragging = false
    		end
    	end)
    	UIS.InputChanged:Connect(function()
    		if MenuDragging then
    			local MousePos = UIS:GetMouseLocation()
                local X = MousePos.X
                local Y = MousePos.Y - 30
    			sTween:Create(Main,TweenInfo.new(.25),{Position = UDim2.new(0,X,0,Y)}):Play()
                configSave("Global", "positionX",X)
                configSave("Global", "positionY",Y)
    		end
    	end)
    end
    do
	    local pressed = false
        local clicks = 0
	    close.MouseButton1Up:Connect(function()
	    	if not pressed then
                clicks = clicks + 1
	    		pressed = true
                if clicks > 1 then
                    spawn(function() tip_setting(1,"Click Mouse Right Button") end)
                end
	    		sTween:Create(close,TweenInfo.new(.08),{Rotation = -25}):Play()
	    		wait(.1)
	    		sTween:Create(close,TweenInfo.new(.08),{Rotation = 25}):Play()
	    		wait(.1)
	    		sTween:Create(close,TweenInfo.new(.08),{Rotation = 0}):Play()

	    		pressed = false
	    	end
	    end)
	    close.MouseButton2Down:Connect(function()
	    	if not pressed then
	    	    sTween:Create(close,TweenInfo.new(.1),{Size = UDim2.new(0,15,0,15)}):Play()
            end
	    end)
	    close.MouseButton2Up:Connect(function()
	    	if not pressed then
	    		pressed = true
	    		sTween:Create(close,TweenInfo.new(.1),{Size = UDim2.new(0,19,0,19)}):Play()
            
	    		wait(.05)
                removeShit()
                _App(1,ScreenGui)
	    		ScreenGui:Destroy()
	    		pressed = false
	    	end
	    end)
	    close.MouseEnter:Connect(function()
	    	sTween:Create(close,TweenInfo.new(.3),{ImageColor3 = Color3.fromRGB(175,0,0)}):Play()
	    end)
	    close.MouseMoved:Connect(function()
            tip_setting(2)
	    end)
	    close.MouseLeave:Connect(function()
            clicks = 0
            tip_setting(3)
	    	sTween:Create(close,TweenInfo.new(.3),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
        
	    	sTween:Create(close,TweenInfo.new(.1),{Size = UDim2.new(0,19,0,19)}):Play()
	    end)
    end
    do
    	
        if not configGet("Global", "hiden",false) then Body.Size = UDim2.new(1, 0, 0, 300) 
        else Body.Size = UDim2.new(1, 0, 0, 0);Body.ClipsDescendants = true;tabs.Position = UDim2.new(-1.5,0,0,0) end 
        
    	local pressed = false
        local state = configGet("Global", "hiden",false)
    	local bsize = nil
        local dpos = nil
    
	    hide.MouseButton1Down:Connect(function()
	    	if not pressed then
	    	    sTween:Create(hide,TweenInfo.new(.1),{Size = UDim2.new(0,15,0,15)}):Play() 
            end
	    end)
	    hide.MouseButton1Up:Connect(function()
	    	if not pressed then
	    		pressed = true
	    		state = not state
            
		        if not state then 
                    bsize = UDim2.new(1,0,0,300) 
                    dpos = UDim2.new(-0.96,0,0,0)
                else 
                    bsize = UDim2.new(1,0,0,0);Body.ClipsDescendants = true
                    dpos = UDim2.new(-1.5,0,0,0)
                end

		        sTween:Create(hide,TweenInfo.new(.1),{Size = UDim2.new(0,19,0,19)}):Play()

		        sTween:Create(Body,TweenInfo.new(.3),{Size = bsize}):Play()
                if not state then wait(.1) end
	    	    sTween:Create(tabs,TweenInfo.new(.25),{Position = dpos}):Play()
                
                configSave("Global", "hiden",state)
	    		wait(.3)
                if not state then Body.ClipsDescendants = false end
	    		pressed = false
	    	end
	    end)
	    hide.MouseEnter:Connect(function()
	    	sTween:Create(hide,TweenInfo.new(.3),{ImageColor3 = Color3.fromRGB(150,150,150)}):Play()
	    end)
	    hide.MouseLeave:Connect(function()
	    	sTween:Create(hide,TweenInfo.new(.3),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
	    	sTween:Create(hide,TweenInfo.new(.1),{Size = UDim2.new(0,19,0,19)}):Play()
	    end)
    end
    _App(0,Main)

    local lib1 = {}
    function lib1:CreateTab(settings)

        local buttonnum = 0
        local textnum = 0
        local labelnum = 0
        local togglenum = 0
        local bindnum = 0
        local slidernum = 0
        local listnum = 0
        local listopened = false

        local name = "Tab"
        for i,v in pairs(settings) do
            if i:lower() == "name" and type(v) == "string" then
                name = v
            end
        end

        tablenum = tablenum + 1
        local myTableNum = tablenum
        _G.nGSTGUi["Tabless"] = tablenum
        _G.nGSTGUi[myTableNum.."BindNum"] = bindnum

        local TabButton = Instance.new("TextButton")
         local Tbg = Instance.new("ImageLabel")
        local Tablename = Instance.new("ImageLabel")
         local BBox = Instance.new("ScrollingFrame")
          local UIGridLayout = Instance.new("UIGridLayout")
         local DBox = Instance.new("ScrollingFrame")
          local UIGridLayout_2 = Instance.new("UIGridLayout")
        --
        
        TabButton.Name = "Tab "..myTableNum
         TabButton.Parent = tabsFrame
         TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
         TabButton.BackgroundTransparency = 1
         TabButton.BorderSizePixel = 0
         TabButton.Size = UDim2.new(0, 200, 0, 50)
         TabButton.ZIndex = 9
         TabButton.Font = Enum.Font.GothamBold
         TabButton.Text = name
         TabButton.RichText = true
         TabButton.Localize = false
         TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         TabButton.TextSize = 14
         TabButton.TextWrapped = true
         Tbg.Name = "bg"
          Tbg.Parent = TabButton
          Tbg.Active = true
          Tbg.AnchorPoint = Vector2.new(0.5, 0.5)
          Tbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          Tbg.BackgroundTransparency = 1
          Tbg.Position = UDim2.new(0.5, 0, 0.5, 0)
          Tbg.Selectable = true
          Tbg.Size = UDim2.new(1, 0, 1, 0)
          Tbg.ZIndex = 8
          Tbg.Image = "rbxassetid://3570695787"
          Tbg.ImageColor3 = Color3.fromRGB(35, 35, 35)
          Tbg.ScaleType = Enum.ScaleType.Slice
          Tbg.SliceCenter = Rect.new(100, 100, 100, 100)
          Tbg.SliceScale = 0.040

        Tablename.Name = "Table "..myTableNum
         Tablename.Parent = Body
         Tablename.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         Tablename.BackgroundTransparency = 1
         Tablename.Position = UDim2.new(0.0126126129, 0, 0.0335435979, 0)
         Tablename.Size = UDim2.new(0, 540, 0, 281)
         Tablename.Image = "rbxassetid://3570695787"
         Tablename.ImageColor3 = Color3.fromRGB(15, 15, 15)
         if myTableNum == 1 then Tablename.Visible = true else Tablename.Visible = false end
         Tablename.ScaleType = Enum.ScaleType.Slice
         Tablename.SliceCenter = Rect.new(100, 100, 100, 100)
         Tablename.SliceScale = 0.040
         BBox.Name = "BBox"
          BBox.Parent = Tablename
          BBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          BBox.BackgroundTransparency = 1
          BBox.CanvasSize = UDim2.new(0,0,0,35)
          BBox.ScrollBarThickness = 0
          --BBox.ClipsDescendants = false
          BBox.Position = UDim2.new(0.0196612328, 0, 0.0249110311, 0)
          BBox.Size = UDim2.new(0, 115, 0, 268)
          UIGridLayout.Parent = BBox
           UIGridLayout.FillDirection = Enum.FillDirection.Vertical
           UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
           UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)
 
         DBox.Name = "DBox"
          DBox.Parent = Tablename
          DBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          DBox.BackgroundTransparency = 1
          DBox.CanvasSize = UDim2.new(0,0,0,1)
          DBox.ScrollBarThickness = 0
          DBox.ScrollingEnabled = false
          --DBox.ClipsDescendants = false
          DBox.Position = UDim2.new(0.292346418, 0, 0.0249110311, 0)
          DBox.Size = UDim2.new(0, 370, 0, 268)
          UIGridLayout_2.Parent = DBox
           UIGridLayout_2.FillDirection = Enum.FillDirection.Vertical
           UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
           UIGridLayout_2.CellSize = UDim2.new(1, 0, 0, 30)
          
          local function tocvpos()
				BBox.CanvasSize = UDim2.new(0,0,0,35*(buttonnum + textnum + labelnum + togglenum + bindnum + slidernum + listnum))
				DBox.CanvasSize = BBox.CanvasSize
	        	sTween:Create(DBox,TweenInfo.new(.15),{CanvasPosition = BBox.CanvasPosition}):Play()
		  end
        --
        do
            local pressed = false

            TabButton.MouseButton1Down:Connect(function()
                sTween:Create(Tbg,TweenInfo.new(.15),{Size = UDim2.new(.98,0,.98,0)}):Play()
                sTween:Create(Tbg,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            
                sTween:Create(TabButton,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            end)
            TabButton.MouseButton1Up:Connect(function()
                if not pressed then
                    pressed = true
                
                    sTween:Create(Tbg,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
                    sTween:Create(Tbg,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
                    sTween:Create(TabButton,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                
                    changeTab(myTableNum,Body)
                    pressed = false
                end
            end)

            TabButton.MouseEnter:Connect(function()
                sTween:Create(Tbg,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
            TabButton.MouseLeave:Connect(function()
                sTween:Create(Tbg,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
                sTween:Create(Tbg,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end)
        end

        local lib2 = {}
        function lib2:CreateButton(settings, callback)
            buttonnum = buttonnum + 1
            callback = callback or function() end

            local Button = Instance.new("TextButton")
             local bg_1 = Instance.new("ImageLabel")

            local Desc = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")

            local name = "Text"
            local desc = "Button"
            for i,v in pairs(settings) do
                if i:lower() == "name" and type(v) == "string" then
                    name = v
                elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                end
            end

            Button.Name = "Button "..buttonnum
             Button.Parent = BBox
             Button.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
             Button.BackgroundTransparency = 1
             Button.BorderSizePixel = 0
             Button.Position = UDim2.new(0.130434781, 0, 0.0373134315, 0)
             Button.Size = UDim2.new(0, 200, 0, 50)
             Button.ZIndex = 2
             Button.TextWrapped = true
             Button.ClipsDescendants = true
             Button.Font = Enum.Font.GothamBold
             Button.Text = name
             Button.RichText = true
             Button.Localize = false
             Button.TextColor3 = Color3.fromRGB(255, 255, 255)
             Button.TextSize = 14
             bg_1.Name = "bg"
              bg_1.Parent = Button
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
            --
            Desc.Name = "Button "..buttonnum
             Desc.Parent = DBox
             Desc.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             Desc.BackgroundTransparency = 1
             Desc.BorderSizePixel = 0
             Desc.Size = UDim2.new(0, 200, 0, 50)
             Desc.ZIndex = 2
             Desc.Font = Enum.Font.GothamBold
             Desc.Text = " "..desc
             Desc.RichText = true
             Desc.ClipsDescendants = true
             Desc.Localize = false
             Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
             Desc.TextSize = 14
             Desc.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = Desc
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
            --

	        local pressed = false

            local timer = false
            local alr = false
            local howmany = 0
            
	        Button.MouseButton1Down:Connect(function()
                if SelectingTabs then return end
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(.98,0,.98,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            
	        	sTween:Create(Button,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
	        end)
	        Button.MouseButton1Up:Connect(function()
	        	if not pressed and not SelectingTabs then
	        		pressed = true
	        		howmany = howmany + 1
                
	        		sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	        		sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
	        		sTween:Create(Button,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                
                    		spawn(function() pcall(callback,howmany) end)
	        		pressed = false
	        	end
	        end)
	        Button.MouseWheelForward:Connect(function() tocvpos() end)
	        Button.MouseWheelBackward:Connect(function() tocvpos() end)
	        Button.MouseEnter:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()

                tip_setting(1,"The Button")
	        end)
            Button.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
	        Button.MouseLeave:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
                tip_setting(3)
	        end)

            local llib = {}
            function llib:Change(Tablo)
                for i,v in pairs(Tablo) do
                    if i:lower() == "name" and type(v) == "string" then
                        Button.Text = v
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        Desc.Text = " "..v
                    end
                end
            end
            function llib:Destroy()
                buttonnum = buttonnum - 1
                Button:Destroy()
                Desc:Destroy()
            end
            return llib

        end

        function lib2:CreateInput(settings, callback)
            textnum = textnum + 1
            callback = callback or function() end
            local myNum = textnum

            local TextInput = Instance.new("TextBox")
             local bg_1 = Instance.new("ImageLabel")

            local Desc = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")

            local text = "text"
            local desc = "TextInput"
            local configsys = false
            for i,v in pairs(settings) do
                if i:lower() == "text" and type(v) == "string" then
                    text = v
                elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                    configsys = v
                end
            end

            if configsys then text = configGet("Local", "Table"..myTableNum.."-TextInput"..myNum,"") end

            TextInput.Name = "TextInput "..myNum
             TextInput.Parent = BBox
             TextInput.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
             TextInput.BackgroundTransparency = 1
             TextInput.BorderSizePixel = 0
             TextInput.Position = UDim2.new(0.130434781, 0, 0.0373134315, 0)
             TextInput.Size = UDim2.new(0, 200, 0, 50)
             TextInput.ZIndex = 2
             TextInput.TextWrapped = true
             TextInput.ClipsDescendants = true
             TextInput.Font = Enum.Font.GothamBold
             TextInput.Text = text
             TextInput.RichText = true
             TextInput.Localize = false
             TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
             TextInput.TextSize = 14
             bg_1.Name = "bg"
              bg_1.Parent = TextInput
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
            --
            Desc.Name = "TextInput "..myNum
             Desc.Parent = DBox
             Desc.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             Desc.BackgroundTransparency = 1
             Desc.BorderSizePixel = 0
             Desc.Size = UDim2.new(0, 200, 0, 50)
             Desc.ZIndex = 2
             Desc.Font = Enum.Font.GothamBold
             Desc.Text = " "..desc
             Desc.RichText = true
             Desc.ClipsDescendants = true
             Desc.Localize = false
             Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
             Desc.TextSize = 14
             Desc.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = Desc
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
            --


            local oldtext = text
            spawn(function() pcall(callback,oldtext) end)
            TextInput.FocusLost:Connect(function(enter)
                if SelectingTabs and not enter and TextInput.Text == oldtext then 
                    TextInput.Text = oldtext
                    return
                end
                oldtext = TextInput.Text
                if configsys then configSave("Local", "Table"..myTableNum.."-TextInput"..myNum,tostring(oldtext)) end
                spawn(function() pcall(callback, oldtext) end)
            end)
            
	        TextInput.MouseWheelForward:Connect(function() tocvpos() end)
	        TextInput.MouseWheelBackward:Connect(function() tocvpos() end)
	        TextInput.MouseEnter:Connect(function()
		        tocvpos()
		        sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()

                tip_setting(1,"The TextInput")
	        end)
            TextInput.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
	        TextInput.MouseLeave:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                tip_setting(3)
	        end)

            local llib = {}
            function llib:Change(Tablo)
                for i,v in pairs(Tablo) do
                    if (i:lower() == "name" or i:lower() == "text" or i:lower() == "input") and type(v) == "string" then
                        TextInput.Text = v
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        Desc.Text = " "..v
                    elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                        configsys = v
                    end
                end
            end
            function llib:Destroy()
                textnum = textnum - 1
                TextInput:Destroy()
                Desc:Destroy()
            end
            return llib

        end


        function lib2:CreateToggle(settings, callback)
            togglenum = togglenum + 1
            callback = callback or function() end
			local myNum = togglenum

            local Toggle = Instance.new("TextButton")
             local txt = Instance.new("TextLabel")
             local bg_1 = Instance.new("ImageLabel")
             local bs = Instance.new("ImageLabel")
              local check = Instance.new("ImageButton")

            local Desc = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")
             
            local name = "Toggle"
            local desc = "Some text"
            local state = false
            local configsys = true
            for i,v in pairs(settings) do
                if (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                elseif i:lower() == "name" and type(v) == "string" then
                    name = v
                elseif i:lower() == "state" and type(v) == "boolean" then
                    state = v
                elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                    configsys = v
                end
            end

	        if configsys then state = configGet("Local", "Table"..myTableNum.."-Toggle"..myNum,state) end
	        local col = nil
	        local Csize = nil

            Toggle.Name = "Toggle "..togglenum
             Toggle.Parent = BBox
             Toggle.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
             Toggle.BackgroundTransparency = 1
             Toggle.BorderSizePixel = 0
             Toggle.Position = UDim2.new(-0.0173913017, 0, 0, 0)
             Toggle.Size = UDim2.new(0, 200, 0, 50)
             Toggle.ZIndex = 2
             Toggle.Font = Enum.Font.GothamBold
             Toggle.Text = ""
             Toggle.Localize = false
             Toggle.TextWrapped = true
             Toggle.ClipsDescendants = true
             Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
             Toggle.TextSize = 14
             Toggle.TextXAlignment = Enum.TextXAlignment.Left
             bg_1.Name = "bg"
              bg_1.Parent = Toggle
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
             bs.Name = "bs"
              bs.Parent = Toggle
              bs.Active = true
              bs.AnchorPoint = Vector2.new(0.5, 0.5)
              bs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bs.BackgroundTransparency = 1
              bs.Position = UDim2.new(0.150000006, 0, 0.5, 0)
              bs.Selectable = true
              bs.Size = UDim2.new(0.154347822, 0, 0.591666639, 0)
              bs.Image = "rbxassetid://3570695787"
              bs.ImageColor3 = Color3.fromRGB(15, 15, 15)
              bs.ScaleType = Enum.ScaleType.Slice
              bs.SliceCenter = Rect.new(100, 100, 100, 100)
              bs.SliceScale = 0.040
              check.Name = "check"
               if state then col = 0;Csize = UDim2.new(0,16,0,16) else col = 1;Csize = UDim2.new(0,13,0,13) end
               check.Parent = bs
               check.AnchorPoint = Vector2.new(0.5, 0.5)
               check.BackgroundTransparency = 1
               check.Position = UDim2.new(0.5, 0, 0.5, 0)
               check.Size = Csize
               check.ZIndex = 2
               check.Image = "rbxassetid://3926305904"
               check.ImageRectOffset = Vector2.new(312, 4)
               check.ImageRectSize = Vector2.new(24, 24)
               check.ImageTransparency = col
             txt.Name = "txt"
              txt.Parent = Toggle
              txt.AnchorPoint = Vector2.new(0.5, 0.5)
              txt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              txt.BackgroundTransparency = 1
              txt.Position = UDim2.new(0.648369551, 0, 0.5, 0)
              txt.Size = UDim2.new(0, 80, 0, 30)
              txt.Font = Enum.Font.GothamBold
              txt.TextWrapped = true
              txt.Text = name
              txt.RichText = true
              txt.Localize = false
              txt.TextColor3 = Color3.fromRGB(255, 255, 255)
              txt.TextSize = 14
              txt.TextXAlignment = Enum.TextXAlignment.Left
            --
            Desc.Name = "Toggle "..togglenum
             Desc.Parent = DBox
             Desc.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             Desc.BackgroundTransparency = 1
             Desc.BorderSizePixel = 0
             Desc.Position = UDim2.new(0.100000001, 0, 0.0373134315, 0)
             Desc.Size = UDim2.new(0, 200, 0, 50)
             Desc.ZIndex = 2
             Desc.ClipsDescendants = true
             Desc.Font = Enum.Font.GothamBold
             Desc.Text = " "..desc
             Desc.RichText = true
             Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
             Desc.TextSize = 14
             Desc.Localize = false
             Desc.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = Desc
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
            --

			local pressed = false
			local timer = false
			local alr = false
			if state then pcall(callback,state) end

	        Toggle.MouseButton1Down:Connect(function()
                if SelectingTabs then return end
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(.98,0,.98,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            
	        	sTween:Create(Toggle.txt,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
	        end)
	        Toggle.MouseButton1Up:Connect(function()
	        	if not pressed and not SelectingTabs then
	        	    state = not state
	        		pressed = true
                
	        		sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
                
	        		sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
	        		if state then col = 0;Csize = UDim2.new(0,16,0,16) else col = 1;Csize = UDim2.new(0,13,0,13) end
	        		sTween:Create(check,TweenInfo.new(.15),{ImageTransparency = col}):Play()
	        		sTween:Create(check,TweenInfo.new(.15),{Size = Csize}):Play()
                
	        		sTween:Create(Toggle.txt,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					
				configSave("Local", "Table"..myTableNum.."-Toggle"..myNum,state)
	        		spawn(function() pcall(callback,state) end)
	        		pressed = false
	        	end
	        end)
	        Toggle.MouseWheelForward:Connect(function() tocvpos() end)
	        Toggle.MouseWheelBackward:Connect(function() tocvpos() end)
	        Toggle.MouseEnter:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                
                tip_setting(1,"The Toggle")
	        end)
            Toggle.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
	        Toggle.MouseLeave:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
                tip_setting(3)
	        end)

            local llib = {}
            function llib:Change(Tablo)
                for i,v in pairs(Tablo) do
                    if i:lower() == "name" and type(v) == "string" then
                        Toggle.txt.Text = v
                    elseif i:lower() == "state" and type(v) == "boolean" then
                        state = v
	        		    if state then col = 0;Csize = UDim2.new(0,16,0,16) else col = 1;Csize = UDim2.new(0,13,0,13) end
	        		    sTween:Create(check,TweenInfo.new(.15),{ImageTransparency = col}):Play()
	        		    sTween:Create(check,TweenInfo.new(.15),{Size = Csize}):Play()
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        Desc.Text = " "..v
                    elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                        configsys = v
                    end
                end
            end
            function llib:Destroy()
                togglenum = togglenum - 1
                Toggle:Destroy()
                Desc:Destroy()
            end
            return llib

        end

        function lib2:CreateLabel(settings)
            
            labelnum = labelnum + 1
            local tbuttons = 0
            local selectedthings = nil
            callback = callback or function() end
			local myNum = labelnum

            local text = "Info"
            local desc = "Some text"
            local fulldesc = ""
            local sizepx = 300
            for i,v in pairs(settings) do
                if (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                elseif (i:lower() == "text" or i:lower() == "name") and type(v) == "string" then
                    text = v
                elseif (i:lower() == "fulldesc" or i:lower() == "fdesc" or i:lower() == "descf" or i:lower() == "descfull") and type(v) == "string" then
                    fulldesc = v
                elseif (i:lower() == "size" or i:lower() == "px") and type(v) == "number" then
                    sizepx = v
                end
            end

            if fulldesc == nil then fulldesc = "" end

            local List = Instance.new("TextLabel")
             local bg_1 = Instance.new("ImageLabel")
   
            local List_2 = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")
             local list = Instance.new("ImageLabel")
              local Frame = Instance.new("ScrollingFrame")
               local Desc = Instance.new("TextLabel")

            List.Name = "TextLabel "..labelnum
             List.Parent = BBox
             List.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
             List.BackgroundTransparency = 1
             List.BorderSizePixel = 0
             List.Position = UDim2.new(0.130434781, 0, 0.0373134315, 0)
             List.Size = UDim2.new(0, 200, 0, 50)
             List.ZIndex = 2
             List.ClipsDescendants = true
             List.Font = Enum.Font.GothamBold
             List.Text = text
             List.RichText = true
             List.Localize = false
             List.TextColor3 = Color3.fromRGB(255, 255, 255)
             List.TextSize = 14
             bg_1.Name = "bg"
              bg_1.Parent = List
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
            --
            List_2.Name = "TextLabel "..listnum
             List_2.Parent = DBox
             List_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             List_2.BackgroundTransparency = 1
             List_2.BorderSizePixel = 0
             List_2.Position = UDim2.new(0.0324324332, 0, -0.0223880634, 0)
             List_2.Size = UDim2.new(0, 200, 0, 50)
             List_2.ZIndex = 3
             --List_2.ClipsDescendants = true
             List_2.Font = Enum.Font.GothamBold
             List_2.Text = " "..desc
             List_2.RichText = true
             List_2.TextWrapped = true
             List_2.Localize = false
             List_2.TextColor3 = Color3.fromRGB(255, 255, 255)
             List_2.TextSize = 14
             List_2.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = List_2
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
             list.Name = "list"
              list.Parent = List_2
              list.AnchorPoint = Vector2.new(0.5, 0)
              list.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              list.BackgroundTransparency = 1
              list.ClipsDescendants = true
              list.Position = UDim2.new(0.5, 0, 0, 0)
              list.Size = UDim2.new(1, 0, 0, 0)
              list.ZIndex = 4
              list.Image = "rbxassetid://3570695787"
              list.ImageColor3 = Color3.fromRGB(20, 20, 20)
              list.ScaleType = Enum.ScaleType.Slice
              list.SliceCenter = Rect.new(100, 100, 100, 100)
              list.SliceScale = 0.040
              Frame.Parent = list
               Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
               Frame.BackgroundTransparency = 1
               Frame.BorderSizePixel = 0
               Frame.Position = UDim2.new(0, 0, 0, 0)
               Frame.CanvasSize = UDim2.new(0,0,0,sizepx)
               Frame.ScrollBarThickness = 2
               Frame.ClipsDescendants = false
               Frame.Size = UDim2.new(0, 358, 0, 137)
               Frame.ZIndex = 5
               Desc.Parent = Frame
                Desc.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Desc.BackgroundTransparency = 1
                Desc.BorderSizePixel = 0
                Desc.Position = UDim2.new(0, 10, 0, 5)
                Desc.Size = UDim2.new(0, 350, 1, 0)
                Desc.ZIndex = 6
                Desc.TextWrapped = true
                Desc.Font = Enum.Font.GothamBold
                Desc.Text = fulldesc
	            Desc.RichText = true
                Desc.Localize = false
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextSize = 14
                Desc.TextXAlignment = Enum.TextXAlignment.Left
                Desc.TextYAlignment = Enum.TextYAlignment.Top
            --
        
            local alr = false
            local timer = false
			
	        List.MouseWheelForward:Connect(function() tocvpos() end)
	        List.MouseWheelBackward:Connect(function() tocvpos() end)
	        List.MouseEnter:Connect(function() tip_setting(1,"Text Label") end)
            List.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
	        List.MouseLeave:Connect(function()
	        	tocvpos()                
                tip_setting(3)
	        end)
            
	        local opened = false
            
	        List_2.MouseEnter:Connect(function()
			    if not opened and not listopened and not MenuDragging and not SelectingTabs and Desc.Text ~= "" then
			        opened = true
                    listopened = true
			        --Frame.CanvasSize = UDim2.new(0,0,string.find(Desc.Text,"\n")/10,0) -- not workin re-sizor
			        sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,4,0)}):Play()
                end
	        end)
	        list.MouseLeave:Connect(function()
	        	if opened and listopened and not MenuDragging and not SelectingTabs then
	        		opened = false
				    listopened = false
	        		sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,0,0)}):Play()
	        	end
	        end)
	        
	        Tablename.MouseEnter:Connect(function()
				opened = false
				listopened = false
				sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,0,0)}):Play()
			end)
	        Tablename.MouseLeave:Connect(function()
				opened = false
				listopened = false
				sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,0,0)}):Play()
			end)

            local llib = {}
            function llib:Change(Tablo)
                for i,v in pairs(Tablo) do
                    if i:lower() == "text" and type(v) == "string" then
                        List.Text = v
                    elseif (i:lower() == "fulldesc" or i:lower() == "fdesc" or i:lower() == "descf" or i:lower() == "descfull") and type(v) == "string" then
                        Desc.Text = v
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        List_2.Text = " "..v
                    end
                end
            end
            function llib:Destroy()
                labelnum = labelnum - 1
                List:Destroy()
                List_2:Destroy()
            end
            return llib
        end

        function lib2:CreateBind(settings, callback)
            bindnum = bindnum + 1
            callback = callback or function() end
			local myNum = bindnum
			_G.nGSTGUi[myTableNum.."BindNum"] = bindnum

            local name = "Bind"
            local defkey = nil
            local looping = false
            local desc = "Key Bind"
            local configsys = true
            for i,v in pairs(settings) do
                if (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                elseif i:lower() == "name" and type(v) == "string" then
                    name = v
                elseif i:lower() == "key" and type(v) == "string" then
                    defkey = v
                elseif (i:lower() == "looping" or i:lower() == "loop") and type(v) == "boolean" then
                    looping = v
                elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                    configsys = v
                end
            end

            local Button = Instance.new("TextButton")
             local bg_1 = Instance.new("ImageLabel")
             local bs = Instance.new("ImageLabel")
              local Bind = Instance.new("TextLabel")
             local txt = Instance.new("TextLabel")

            local Desc = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")
             
            if configsys then defkey = configGet("Local", "Table"..myTableNum.."-Bind"..myNum,defkey) end
            Button.Name = "Bind "..bindnum
             Button.Parent = BBox
             Button.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
             Button.BackgroundTransparency = 1
             Button.BorderSizePixel = 0
             Button.Position = UDim2.new(-0.0173913017, 0, 0, 0)
             Button.Size = UDim2.new(0, 200, 0, 50)
             Button.ZIndex = 2
             Button.Font = Enum.Font.GothamBold
             Button.Text = ""
             Button.Localize = false
             Button.TextColor3 = Color3.fromRGB(255, 255, 255)
             Button.TextSize = 14
             Button.TextXAlignment = Enum.TextXAlignment.Left
             bg_1.Name = "bg"
              bg_1.Parent = Button
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
             bs.Name = "bs"
              bs.Parent = Button
              bs.Active = true
              bs.AnchorPoint = Vector2.new(0.5, 0.5)
              bs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bs.BackgroundTransparency = 1
              bs.Position = UDim2.new(0.150000006, 0, 0.5, 0)
              bs.Selectable = true
              bs.ClipsDescendants = true
              bs.Size = UDim2.new(0.154347822, 0, 0.591666639, 0)
              bs.Image = "rbxassetid://3570695787"
              bs.ImageColor3 = Color3.fromRGB(15, 15, 15)
              bs.ScaleType = Enum.ScaleType.Slice
              bs.SliceCenter = Rect.new(100, 100, 100, 100)
              bs.SliceScale = 0.040
              Bind.Name = "Key"
               Bind.Parent = bs
               Bind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
               Bind.BackgroundTransparency = 1
               Bind.Position = UDim2.new(0, 0, 0, 1)
               Bind.Size = UDim2.new(1, 0, 1, 0)
               Bind.Font = Enum.Font.GothamBold
               if defkey == nil then Bind.Text = "*" else Bind.Text = defkey end
               Bind.TextColor3 = Color3.fromRGB(255, 255, 255)
               Bind.Localize = false
               Bind.TextSize = 14
                     
             txt.Name = "txt"
              txt.Parent = Button
              txt.AnchorPoint = Vector2.new(0.5, 0.5)
              txt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              txt.BackgroundTransparency = 1
              txt.Position = UDim2.new(0.648369551, 0, 0.5, 0)
              txt.Size = UDim2.new(0, 80, 0, 30)
              txt.Font = Enum.Font.GothamBold
              txt.Text = name
              txt.RichText = true
              txt.Localize = false
              txt.TextColor3 = Color3.fromRGB(255, 255, 255)
              txt.TextSize = 14
              txt.TextXAlignment = Enum.TextXAlignment.Left
            --
            Desc.Name = "Bind "..bindnum
             Desc.Parent = DBox
             Desc.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             Desc.BackgroundTransparency = 1
             Desc.BorderSizePixel = 0
             Desc.Position = UDim2.new(0.100000001, 0, 0.0373134315, 0)
             Desc.Size = UDim2.new(0, 200, 0, 50)
             Desc.ZIndex = 2
             Desc.ClipsDescendants = true
             Desc.Font = Enum.Font.GothamBold
             Desc.Text = " "..desc
             Desc.RichText = true
             Desc.Localize = false
             Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
             Desc.TextSize = 14
             Desc.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = Desc
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
            --

            local pressed = false
            local loopressed = false
            local changing = false
            local col = nil
            local Csize = nil
            local oldkey = Bind.Text
            
            Button.MouseButton1Down:Connect(function()
                sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(.98,0,.98,0)}):Play()
                sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
                
                sTween:Create(Button.txt,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            end)
            Button.MouseButton1Up:Connect(function()
                state = not state
                if not pressed then
                    pressed = true
                    changing = true
            
                    sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
                    
                    sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                    
                    if state then col = 0;Csize = UDim2.new(0,16,0,16) else col = 1;Csize = UDim2.new(0,13,0,13) end
                    
                    sTween:Create(Button.txt,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    Bind.Text = "?"
                    Desc.Text = " Backspace to remove"
                    
                    pressed = false
                end
            end)
            
	        Button.MouseWheelForward:Connect(function() tocvpos() end)
	        Button.MouseWheelBackward:Connect(function() tocvpos() end)
            Button.MouseEnter:Connect(function()
	        	tocvpos()
                sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()

                if looping then tip_setting(1,"The Loop Bind") else tip_setting(1,"The KeyBind") end
            end)
            Button.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
            Button.MouseLeave:Connect(function()
	        	tocvpos()
                sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
                sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()

                tip_setting(3)
            end)
            
            _G.nGSTGUi[myTableNum.."Bind"..myNum] = UIS.InputBegan:Connect(function(key, enter)
                if enter then return end
                if looping then loopressed = true end
                if changing then
                    if key.KeyCode == Enum.KeyCode.Unknown then
                        Bind.Text = oldkey
                        Desc.Text = " "..desc
                        changing = false
                    elseif key.KeyCode == Enum.KeyCode.Backspace then
                        Bind.Text = "*"
                        Desc.Text = " "..desc
                        oldkey = "*"
                        changing = false
                    else
                        Bind.Text = key.KeyCode.Name
                        Desc.Text = " "..desc
                        oldkey = key.KeyCode.Name
                        changing = false
                    end
                    if configsys then configSave("Local", "Table"..myTableNum.."-Bind"..myNum,Bind.Text) end
                elseif key.KeyCode.Name == Bind.Text then 
	            local loopnum = 0
		    spawn(function() 
		    	while wait() do
			    loopnum = loopnum + 1
                pcall(callback, key.KeyCode.Name, loopnum)
                    if not loopressed then break end 
                end
            end)
        end
    end)
            
            _G.nGSTGUi[myTableNum.."BindLoop"..myNum] = UIS.InputEnded:Connect(function(key, enter)
                if enter and looping then return end
                if key.KeyCode.Name == Bind.Text then 
                    loopressed = false
                end
            end)

            local llib = {}
            function llib:Change(Tablo)
                for i,v in pairs(Tablo) do
                    if i:lower() == "name" and type(v) == "string" then
                        txt.Text = v
                    elseif i:lower() == "key" and type(v) == "string" then
                        Bind.Text = v
                    elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                        configsys = v
                    elseif (i:lower() == "loop" or i:lower() == "looping") and type(v) == "boolean" then
                        looping = v
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        Desc.Text = " "..v
                    end
                end
            end
            function llib:Destroy()
                bindnum = bindnum - 1
                Button:Destroy()
                Desc:Destroy()
                _G.nGSTGUi[myTableNum.."BindLoop"..myNum]:Disconnect()
            end
            return llib
            
        end

        function lib2:CreateSlider(settings, callback)
            slidernum = slidernum + 1
            local slideropened = false
            callback = callback or function() end
		    local myNum = slidernum

            local min = 0
            local def = nil
            local max = 100
            local desc = "Slider Int"
            local configsys = true
            for i,v in pairs(settings) do
                if (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                elseif i:lower() == "min" and type(v) == "number" then
                    min = v
                elseif i:lower() == "def" and type(v) == "number" then
                    def = v
                elseif i:lower() == "max" and type(v) == "number" then
                    max = v
                elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                    configsys = v
                end
            end
        
		    if configsys then def = configGet("Local", "Table"..myTableNum.."-Slider"..myNum,min) end
        
            local Slider = Instance.new("TextBox")
             local bg_1 = Instance.new("ImageLabel")

            local Slider_2 = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")
             local line = Instance.new("TextButton")
              local bg_3 = Instance.new("ImageLabel")
              local Point = Instance.new("ImageButton")

            Slider.Name = "Slider "..slidernum
             Slider.Parent = BBox
             Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
             Slider.BackgroundTransparency = 1
             Slider.Size = UDim2.new(0, 200, 0, 50)
             Slider.ZIndex = 2
             Slider.Font = Enum.Font.GothamBold
             Slider.Text = def
             Slider.Localize = false
             Slider.TextWrapped = true
             Slider.ClipsDescendants = true
             Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
             Slider.TextSize = 14
             bg_1.Name = "bg"
              bg_1.Parent = Slider
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
            --
            Slider_2.Name = "Slider "..slidernum 
             Slider_2.Parent = DBox
             Slider_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             Slider_2.BackgroundTransparency = 1
             Slider_2.BorderSizePixel = 0
             Slider_2.Position = UDim2.new(0.048648648, 0, -0.0373134315, 0)
             Slider_2.Size = UDim2.new(0, 200, 0, 50)
             Slider_2.ZIndex = 2
             Slider_2.Font = Enum.Font.GothamBold
             Slider_2.ClipsDescendants = true
             Slider_2.Text = " "..desc
             Slider_2.RichText = true
             Slider_2.TextColor3 = Color3.fromRGB(255, 255, 255)
             Slider_2.TextSize = 14
             Slider_2.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = Slider_2
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
              line.Name = "line"
               line.Parent = Slider_2
               line.AnchorPoint = Vector2.new(0.5, 0.5)
               line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
               line.BackgroundTransparency = 1
               line.BorderSizePixel = 0
               line.Position = UDim2.new(0.502702713, 0, 0.516666651, 0)
               line.Size = UDim2.new(0, 356, 0, 5)
               line.Font = Enum.Font.SourceSans
               line.Text = ""
               line.Localize = false
               line.TextColor3 = Color3.fromRGB(0, 0, 0)
               line.TextSize = 14
               bg_3.Name = "bg"
                bg_3.Parent = line
                bg_3.Active = true
                bg_3.AnchorPoint = Vector2.new(0.5, 0.5)
                bg_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                bg_3.BackgroundTransparency = 1
                bg_3.Position = UDim2.new(0.5, 0, 0.5, 0)
                bg_3.Selectable = true
                bg_3.Size = UDim2.new(1, 0, 1, 0)
                bg_3.Image = "rbxassetid://3570695787"
                bg_3.ImageColor3 = Color3.fromRGB(30, 30, 30)
                bg_3.ImageTransparency = 1
                bg_3.ScaleType = Enum.ScaleType.Slice
                bg_3.SliceCenter = Rect.new(100, 100, 100, 100)
                bg_3.SliceScale = 0.040
               Point.Name = "Point"
                Point.Parent = line
                Point.AnchorPoint = Vector2.new(0.5, 0.5)
                Point.BackgroundTransparency = 1
                Point.Position = UDim2.new(0, 0, 0.48300001, 0)
                Point.Rotation = 90
                Point.Size = UDim2.new(0, 20, 0, 20)
                Point.ZIndex = 2
                Point.Image = "rbxassetid://3926305904"
                Point.ImageRectOffset = Vector2.new(484, 284)
                Point.ImageRectSize = Vector2.new(36, 36)
                Point.ImageTransparency = 1
            --
		local alr = false
		local timer = false
		spawn(function() pcall(callback, def) end)
			
	        Slider.MouseWheelForward:Connect(function() tocvpos() end)
	        Slider.MouseWheelBackward:Connect(function() tocvpos() end)
	        Slider.MouseEnter:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                
                tip_setting(1,"The Slider")
	        end)
            Slider.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
	        Slider.MouseLeave:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
                tip_setting(3)
	        end)
            Slider_2.MouseMoved:Connect(function()
                if not slideropened and not MenuDragging and not SelectingTabs then
                    sTween:Create(Slider_2,TweenInfo.new(.15),{TextTransparency = 1}):Play()
                    sTween:Create(bg_3,TweenInfo.new(.15),{ImageTransparency = 0}):Play()
                    sTween:Create(Point,TweenInfo.new(.15),{ImageTransparency = 0}):Play()
                    slideropened = true
                end
            end)
            Slider_2.MouseLeave:Connect(function()
                if slideropened and not MenuDragging and not SelectingTabs then
                    sTween:Create(bg_3,TweenInfo.new(.15),{ImageTransparency = 1}):Play()
                    sTween:Create(Point,TweenInfo.new(.15),{ImageTransparency = 1}):Play()
                    sTween:Create(Slider_2,TweenInfo.new(.15),{TextTransparency = 0}):Play()
                    slideropened = false
                end
            end)
            Point.MouseEnter:Connect(function()
                sTween:Create(Point,TweenInfo.new(.15),{Size = UDim2.new(0,25,0,25)}):Play()
            end)
            Point.MouseLeave:Connect(function()
                sTween:Create(Point,TweenInfo.new(.15),{Size = UDim2.new(0,20,0,20)}):Play()
            end)

	        local Draggging = false
	        local function Drag(thing)
                if thing ~= nil then pcall(callback, tonumber(thing)); if configsys then configSave("Local", "Table"..myTableNum.."-Slider"..myNum,tonumber(thing)) end; return end
                
	        	local mex = max - min
	        	local MousePos = UIS:GetMouseLocation()
	        	local RelPos = MousePos - bg_3.AbsolutePosition
	        	local Percent = math.clamp(RelPos.X / bg_3.AbsolutePosition.X,0,1)
            
	        	sTween:Create(Point,TweenInfo.new(.12),{Position = UDim2.new(Percent,0,.5,0)}):Play()
            
	        	local num = math.round(Percent * mex)+min
            
	        	Slider.Text = num
	        	if configsys then configSave("Local", "Table"..myTableNum.."-Slider"..myNum,tonumber(num)) end
                spawn(function() pcall(callback, num) end)
	        end
	        Point.MouseButton1Down:Connect(function()
	        	Draggging = true
	        end)
	        line.MouseButton1Down:Connect(function()
	        	Draggging = true
	        	Drag()
	        end)
	        UIS.InputEnded:Connect(function(key)
	        	if key.UserInputType == Enum.UserInputType.MouseButton1 then
	        		Draggging = false
	        	end
	        end)
	        UIS.InputChanged:Connect(function()
	        	if Draggging then
	        		Drag()
	        	end
	        end)

            local old = def
            Slider.FocusLost:Connect(function(enter)
                
                if not tonumber(Slider.Text) or SelectingTabs then 
                    Slider.Text = old 
                elseif tonumber(Slider.Text) > max then
                    Slider.Text = max
                elseif tonumber(Slider.Text) < min then
                    Slider.Text = min
                end
                if not enter then Slider.Text = old;return end
            
                sTween:Create(Point,TweenInfo.new(.12),{Position = UDim2.new(0,0,.5,0)}):Play()
                old = Slider.Text
                Drag(old)
            
            end)

            local llib = {}
            function llib:Change(Tablo)
                for i,v in pairs(Tablo) do
                    if i:lower() == "min" and type(v) == "number" then
                        min = v
                    elseif i:lower() == "max" and type(v) == "number" then
                        max = v
                    elseif (i:lower() == "def" or i:lower() == "val" or i:lower() == "value") and type(v) == "number" then
                        Slider.Text = v
                        Drag(v)
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        Slider_2.Text = " "..v
                    elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                        configsys = v
                    end
                end
            end
            function llib:Destroy()
                slidernum = slidernum - 1
                Slider:Destroy()
                Slider_2:Destroy()
            end
            return llib

        end

        function lib2:CreateList(settings, callback)

            local btable = {}
            local multi = false
            local oncreate = true
            local desc = "The List"
            local name = "Apply"
            local configsys = true
            for i,v in pairs(settings) do
                if (i:lower() == "buttons" or i:lower() == "list" or i:lower() == "btns" or i:lower() == "btn" or i:lower() == "table") and type(v) == "table" then
                    for _q,_w in pairs(v) do
                        table.insert(btable,_w)
                    end
                elseif i:lower() == "multi" and type(v) == "boolean" then
                    multi = v
                elseif (i:lower() == "oncreate" or i:lower() == "calloncreate" or i:lower() == "onc") and type(v) == "boolean" then
                    oncreate = v
                elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                    desc = v
                elseif i:lower() == "name" and type(v) == "string" then
                    name = v
                elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                    configsys = v
                end
            end

            listnum = listnum + 1
            local tbuttons = 0
            local selectedthings = nil
            callback = callback or function() end
			local myNum = listnum
            if multi then 
                selectedthings = {}
                if configsys then selectedthings = configGet("Local", "Table"..myTableNum.."-MList"..myNum,{}) end
            else 
                selectedthings = ""
                if configsys then selectedthings = configGet("Local", "Table"..myTableNum.."-List"..myNum,"") end
            end

            local List = Instance.new("TextButton")
             local bg_1 = Instance.new("ImageLabel")
   
            local List_2 = Instance.new("TextLabel")
             local bg_2 = Instance.new("ImageLabel")
             local list = Instance.new("ImageLabel")
              local Frame = Instance.new("ScrollingFrame")
               local UIGridLayout_3 = Instance.new("UIGridLayout")

            List.Name = "List "..listnum
             List.Parent = BBox
             List.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
             List.BackgroundTransparency = 1
             List.BorderSizePixel = 0
             List.Position = UDim2.new(0.130434781, 0, 0.0373134315, 0)
             List.Size = UDim2.new(0, 200, 0, 50)
             List.ZIndex = 2
             List.ClipsDescendants = true
             List.Font = Enum.Font.GothamBold
             List.Text = name
             List.Localize = false
             List.TextWrapped = true
             List.RichText = true
             List.TextColor3 = Color3.fromRGB(255, 255, 255)
             List.TextSize = 14
             bg_1.Name = "bg"
              bg_1.Parent = List
              bg_1.Active = true
              bg_1.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_1.BackgroundTransparency = 1
              bg_1.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_1.Selectable = true
              bg_1.Size = UDim2.new(1, 0, 1, 0)
              bg_1.Image = "rbxassetid://3570695787"
              bg_1.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_1.ScaleType = Enum.ScaleType.Slice
              bg_1.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_1.SliceScale = 0.040
            --
            List_2.Name = "List "..listnum
             List_2.Parent = DBox
             List_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
             List_2.BackgroundTransparency = 1
             List_2.BorderSizePixel = 0
             List_2.Position = UDim2.new(0.0324324332, 0, -0.0223880634, 0)
             List_2.Size = UDim2.new(0, 200, 0, 50)
             List_2.ZIndex = 3
             --List_2.ClipsDescendants = true
             List_2.Font = Enum.Font.GothamBold
             List_2.Text = " "..desc
             List_2.RichText = true
             List_2.Localize = false
             List_2.TextColor3 = Color3.fromRGB(255, 255, 255)
             List_2.TextSize = 14
             List_2.TextXAlignment = Enum.TextXAlignment.Left
             bg_2.Name = "bg"
              bg_2.Parent = List_2
              bg_2.AnchorPoint = Vector2.new(0.5, 0.5)
              bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              bg_2.BackgroundTransparency = 1
              bg_2.Position = UDim2.new(0.5, 0, 0.5, 0)
              bg_2.Size = UDim2.new(1, 0, 1, 0)
              bg_2.Image = "rbxassetid://3570695787"
              bg_2.ImageColor3 = Color3.fromRGB(35, 35, 35)
              bg_2.ScaleType = Enum.ScaleType.Slice
              bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
              bg_2.SliceScale = 0.040
             list.Name = "list"
              list.Parent = List_2
              list.AnchorPoint = Vector2.new(0.5, 0)
              list.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              list.BackgroundTransparency = 1
              list.ClipsDescendants = true
              list.Position = UDim2.new(0.5, 0, 0, 0)
              list.Size = UDim2.new(1, 0, 0, 0)
              list.ZIndex = 4
              list.Image = "rbxassetid://3570695787"
              list.ImageColor3 = Color3.fromRGB(20, 20, 20)
              list.ScaleType = Enum.ScaleType.Slice
              list.SliceCenter = Rect.new(100, 100, 100, 100)
              list.SliceScale = 0.040
              Frame.Parent = list
               Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
               Frame.BackgroundTransparency = 1
               Frame.CanvasSize = UDim2.new(0,0,0,0)
               Frame.ScrollBarThickness = 2
               Frame.BorderSizePixel = 0
               Frame.Position = UDim2.new(0.0162162166, 0, 0.04, 0)
               Frame.Size = UDim2.new(0, 358, 0, 137)
               Frame.ZIndex = 5
               UIGridLayout_3.Parent = Frame
                UIGridLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout_3.CellSize = UDim2.new(1, 0, 0, 30)
            --
	        List.MouseButton1Down:Connect(function()
                if SelectingTabs then return end
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(.98,0,.98,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            
	        	sTween:Create(List,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
	        end)
	        List.MouseButton1Up:Connect(function()
	        	if not pressed and not SelectingTabs then
	        		pressed = true
                
	        		sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	        		sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
	        		sTween:Create(List,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                
	        		spawn(function() pcall(callback, selectedthings) end)
	        		pressed = false
	        	end
	        end)
            
	        local opened = false
           	local function checkbutt(setup)
           		spawn(function()
					for v,i in pairs(Frame:GetChildren()) do
						if setup ~= nil and not multi and configsys and configGet("Local", "Table"..myTableNum.."-List"..myNum,nil) == nil then
							selectedthings = setup
						end
						if i.Name ~= "UIGridLayout" then
							if multi then
								if configsys then configSave("Local", "Table"..myTableNum.."-MList"..myNum,selectedthings) end
								if table.find(selectedthings,i.Text) then
									sTween:Create(i,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
								else
									sTween:Create(i,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
								end
							else
								if configsys then configSave("Local", "Table"..myTableNum.."-List"..myNum,selectedthings) end
								if selectedthings == i.Text then
									sTween:Create(i,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
								else
									sTween:Create(i,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
								end
							end
						end
					end
				end)
            end
            checkbutt(btable[1])
            if oncreate then spawn(function() pcall(callback, selectedthings) end) end
            
            local alr = false
            local timer = false
			
	        List.MouseWheelForward:Connect(function() tocvpos() end)
	        List.MouseWheelBackward:Connect(function() tocvpos() end)
	        List.MouseEnter:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                
                if multi then tip_setting(1,"The MultiList") else tip_setting(1,"The List") end
	        end)
            List.MouseMoved:Connect(function()
	        	tocvpos()
                tip_setting(2)
            end)
	        List.MouseLeave:Connect(function()
	        	tocvpos()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	        	sTween:Create(bg_1,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                
                tip_setting(3)
	        end)
            
		    local list2size = 5
	        List_2.MouseMoved:Connect(function()
			    if not opened and not listopened and not MenuDragging and not SelectingTabs then
			    opened = true
                listopened = true
			    sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,list2size,0)}):Play()
                if tbuttons == 1 then list2size = 1.3
                elseif tbuttons == 2 then list2size = 2.5
                elseif tbuttons == 3 then list2size = 3.7
                elseif tbuttons == 4 then list2size = 4.9
                elseif tbuttons > 4 then list2size = 4.9;Frame.CanvasSize = UDim2.new(0,0,0,34.6*tbuttons) end
                checkbutt()
                end
	        end)

	        list.MouseLeave:Connect(function()
	        	if opened and listopened and not MenuDragging and not SelectingTabs then
	        		opened = false
				    listopened = false
	        		sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,0,0)}):Play()
	        	end
	        end)
	        
	        Tablename.MouseEnter:Connect(function()
				opened = false
				listopened = false
				sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,0,0)}):Play()
			end)
	        Tablename.MouseLeave:Connect(function()
				opened = false
				listopened = false
				sTween:Create(list,TweenInfo.new(.25),{Size = UDim2.new(1,0,0,0)}):Play()
			end)

            local function genlbut(name,numm)
                local ButtonF = Instance.new("TextButton")
                 local bg_3 = Instance.new("ImageLabel")

                ButtonF.Name = "Button "..tbuttons
                 ButtonF.Parent = Frame
                 ButtonF.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                 ButtonF.BackgroundTransparency = 1
                 ButtonF.BorderSizePixel = 0
                 ButtonF.Size = UDim2.new(0, 200, 0, 50)
                 ButtonF.ZIndex = 5
                 ButtonF.ClipsDescendants = true
                 ButtonF.Font = Enum.Font.GothamBold
                 ButtonF.Text = name
                 ButtonF.RichText = true
                 ButtonF.TextWrapped = true
                 ButtonF.Localize = false
                 ButtonF.TextColor3 = Color3.fromRGB(200, 200, 200)
                 ButtonF.TextSize = 14
                 bg_3.Name = "bg"
                  bg_3.Parent = ButtonF
                  bg_3.Active = true
                  bg_3.AnchorPoint = Vector2.new(0.5, 0.5)
                  bg_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                  bg_3.BackgroundTransparency = 1
                  bg_3.Position = UDim2.new(0.5, 0, 0.5, 0)
                  bg_3.Selectable = true
                  bg_3.Size = UDim2.new(1, 0, 1, 0)
                  bg_3.ZIndex = 4
                  bg_3.Image = "rbxassetid://3570695787"
                  bg_3.ImageColor3 = Color3.fromRGB(35, 35, 35)
                  bg_3.ScaleType = Enum.ScaleType.Slice
                  bg_3.SliceCenter = Rect.new(100, 100, 100, 100)
                  bg_3.SliceScale = 0.040
                --
	    	    local pressed = false
                local hmm = false

	            ButtonF.MouseButton1Down:Connect(function()
	            	sTween:Create(bg_3,TweenInfo.new(.15),{Size = UDim2.new(.98,0,.98,0)}):Play()
	            	sTween:Create(bg_3,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(25, 25, 25)}):Play()
                
	            	sTween:Create(ButtonF,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
	            end)
                
	            ButtonF.MouseButton1Up:Connect(function()
	            	if not pressed then
	            		pressed = true
                    
	            		sTween:Create(bg_3,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
	            		sTween:Create(bg_3,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                        
                        if multi then
                            if not table.find(selectedthings, ButtonF.Text) then
	            		        sTween:Create(ButtonF,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                                if not hmm then table.insert(selectedthings, ButtonF.Text) else selectedthings[myNum] = ButtonF.Text end
                            else
                                for i=1, #selectedthings do
                                    if selectedthings[i] == ButtonF.Text then table.remove(selectedthings,i) end
                                end
                            end
                        else
                            if selectedthings ~= ButtonF.Text then
                                selectedthings = ButtonF.Text
				                sTween:Create(ButtonF,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                            end
                        end

                        checkbutt()
				        pressed = false
			        end
	            end)
            
            
	            ButtonF.MouseEnter:Connect(function()
                    sTween:Create(bg_3,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(45, 45, 45)}):Play()
	            end)
	            ButtonF.MouseLeave:Connect(function()
	            	sTween:Create(bg_3,TweenInfo.new(.15),{Size = UDim2.new(1,0,1,0)}):Play()
                    sTween:Create(bg_3,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(35, 35, 35)}):Play()
	            end)
            end

            for v,i in pairs(btable) do
                tbuttons = tbuttons + 1
                local myNum = tbuttons
                genlbut(i,myNum)
            end

            local llib = {}
            function llib:Change(Tablo2)
                for i,v in pairs(Tablo2) do
                    if i:lower() == "multi" and type(v) == "boolean" then
                        multi = v
                        if multi then selectedthings = configGet("Local", "Table"..myTableNum.."-AMList"..myNum,{selectedthings}) else selectedthings = configGet("Local", "Table"..myTableNum.."-AList"..myNum,"") end
                    elseif i:lower() == "add" and type(v) == "table" then
                        for _q,name in pairs(v) do
                            local createdhmm = false
                            for q,w in pairs(Frame:GetChildren()) do
                                if w.Name ~= "UIGridLayout" then
                                    if w.Text == name then
                                        createdhmm = true
                                    end
                                end
                            end
                            if createdhmm == false then
                                tbuttons = tbuttons + 1
                                genlbut(name,tbuttons)
                            end
                        end
                    elseif i:lower() == "remove" and (type(v) == "table" or v == "all") then
                        if v == "all" then
                            for q,w in pairs(Frame:GetChildren()) do
                                if w.Name ~= "UIGridLayout" then
                                    tbuttons = tbuttons - 1
                                    w:Destroy()
                                end
                            end
                        else
                            for _q,name in pairs(v) do
                                for q,w in pairs(Frame:GetChildren()) do
                                    if w.Name ~= "UIGridLayout" then
                                        if w.Text == name then
                                            tbuttons = tbuttons - 1
                                            w:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                    elseif i:lower() == "name" and type(v) == "string" then
                        List.Text = v
                    elseif (i:lower() == "config" or i:lower() == "cfg") and type(v) == "boolean" then
                        configsys = v
                    elseif (i:lower() == "desc" or i:lower() == "description") and type(v) == "string" then
                        List_2.Text = " "..v
                    end
                end
            end
            function llib:Destroy()
                listnum = listnum - 1
                tbuttons = 0
                List:Destroy()
                List_2:Destroy()
            end
            return llib

        end
        return lib2

    end
    return lib1
    
end
return lib

--[[

--local var = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/synapse.luas/main/UiLibs/GUiLibRewrite.lua"))():CreateWin(Name: string, configid: string)
local var = lib:CreateWin(Name: string, configid: string) -- configid - will be gui support the config system or not (if yes must place nil value at 'state' var)

local var1 = var:CreateTab({Name=string*})

var1:CreateButton({Name=string*, desc=string*}, callback: function(return number) end)
var1:CreateInput({Name=string*, desc=string*, config=boolean*}, function(return string) end)
var1:CreateToggle({Name=string*, state=boolean*, desc=string*, config=boolean*}, callback: function(return boolean) end)
var1:CreateLabel({Name=string*, desc=string*, px=number*, fdesc=string*})
var1:CreateSlider({Min=number*, Def=number*, Max=number*, desc=string*, config=boolean*}, callback: function(return number) end)
var1:CreateList({table=table*, multi=boolean*, callOnCreate=boolean*, desc=string*, config=boolean*}, callback: function(return table(MultiChoice true) or string(MultiChoice false)) end)
var1:CreateBind({Name=string*, Key=string(1)*, loop=boolean*, desc=string*, config=boolean*}, function(return string and (how many times): number) end)

-- test setup | 'return lib' must be commented. to use that method

local began = lib:CreateWin("Test")
local tab = began:CreateTab({name="Test"})

tab:CreateButton({},function(_) print("Clicked ".._.." time") end)
tab:CreateInput({},function(_) print("Text writed: ".._) end)
tab:CreateLabel({})
tab:CreateToggle({},function(_) print("State: ".._) end)
tab:CreateBind({},function(_,_2) print("Key pressed: ".._.." | Pressed: ".._2) end)
tab:CreateSlider({},function(_) print("SliderInt: ".._) end)
tab:CreateList({},function(_) print("List selected: ".._) end)

]]--
