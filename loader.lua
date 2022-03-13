--[[
    
    MANUAL, HOW TO USE

    1st you must init this via
     - var1 = lib:init(loader_name) -- loader_name -> string

    if you need add into loader your scripts (and dont open every time your executor)
    you can add that:
     - var1:CustomScript(script_name,script_func) -- script_name -> string, script_func -> string(raw link to script) or function() end

    okay and finnaly how to add(or convert some GUi) into loader's GUi tab?
     - 1st you must create menu via "var2 = var1:AddMenu(menu_name) -- menu_name -> string"
       and add tab "var3 = var2:AddTab(tab_name) -- tab_name -> string" (you can create multiple of tabs for one menu)

        Before to start you must know something (if you're beginner in this theme, if not you can skip it)
         callback(args*) -- this is function() with args what can return you some information when it got triggered, all return values is written in bottom

         %nameOfVar(%varAliases*) -> %varReturnType -- %varDesc (%varDefValue, if %varName is not provided)


       after you can add those buttons to use:
        - var3:CreateButton(settings,callback) {
            settings -> table { 
                name(title)       -> string,        -- Name of function ("Button name")
                desc(description) -> string         -- Description of function ("")
            } 
            callback -> returns (click_count -> number)
        }
        - var3:CreateToggle(settings,callback) {
            settings -> table {
                name(title)       -> string,        -- Name of function ("Toggle name")
                desc(description) -> string,        -- Description of function ("")
                exec              -> boolean,       -- Trigger callback on create (false)
                state             -> boolean        -- State on function creation (false)
            }
            callback -> returns (state: boolean)
        }
        - var3:CreateInput(settings,callback) {
            settings -> table {
                name(title)       -> string,        -- Name of function ("Input name")
                desc(description) -> string,        -- Description of function ("")
                autocomplete(ac)  -> table {        -- By pressing tab will add needed text ({nil,""})
                    Instance,               -- like this: game.Players:GetChildren() or another Instance
                    table {strings*}        -- like this: {"Name","DisplayName"}
                }
            }
            callback -> returns (text -> string)
        }
        - var3:CreateSlider(settings,callback) {
            settings -> table {
                name(title)         -> string,      -- Name of function ("Slider name")
                desc(description)   -> string,      -- Description of function ("")
                exec                -> boolean,     -- Trigger callback on create (false)
                min(minimum)        -> number,      -- Minimal range to slide (0)
                def(default, start) -> number,      -- Value on function creation or MouseButton2Click (50)
                max(maximum)        -> number       -- Maximum range to slide (100)
            } 
            callback -> returns (count -> number)
        }
        - var3:CreateBind(settings,callback) {
            settings -> table {
                name(title)       -> string,        -- Name of function ("Bind name")
                desc(description) -> string,        -- Description of function ("")
                key(bind)         -> string,        -- Key to trigger callback (*)
                loop(looping)     -> boolean        -- Loop callback (false)
            } 
            callback -> returns (Key -> string, tick -> number)
        }
        - var3:CreateLabel(settings) {
            settings -> table {
                name(title)          -> string,     -- Name of function ("Label name")
                desc(description)    -> string,     -- Description of function ("")
                copy(clip,clipboard) -> string      -- Text to copy on MouseButton1Click ("")
            }
        }
        - var3:CreateList(settings,callback) {
            settings -> table {
                name(title)          -> string,     -- Name of function ("List name")
                desc(description)    -> string,     -- Description of function ("")
                exec                 -> boolean,    -- Trigger callback on creation (false)
                btns(buttons,btn)    -> table {     -- List of buttons in function ({"name is value",{"button with own value","hello world!"}})
                    (strings* or tables*) -> (Name or {Name,Value}) -- Button's return Value on MouseButton1Click
                }
            }
            callback -> returns (value -> any)
        }


       Example:
        -- optinal
        local the_loader = lib:init("Kebabich") -- this string as default have variable "getgenv().ngstloader"

        -- my custom scripts :)
        the_loader:CustomScript("Dex3","https://scriptkid.com/dex3/raw/") -- example with link provided
        the_loader:CustomScript("shit my console pls",function()  -- example with callback provided
            while wait() do
                print("you an idiot :)")
            end
        end)

        -- my new powerful autofarm gui !!!

        local GUi = the_loader:AddMenu("Ultimate GUi autofarm")
        local autofarm = GUi:AddTab("AutoFarm!!!")
        autofarm:CreateLabel({name="My discord server!!!",copy="https://discord.gg/roblox/"})
        autofarm:CreateButton({name="give 100000000 robrux!",desc="gives u a lot of robrux!!!"},function(_)
            if _ == 1 then return end
            print("I GAVE U ROBRUX ".._.." TIMES MAN!")

        end)
        autofarm:CreateToggle({name="AutoFarm state"},function(state) -- returns boolean
            if state then
                print("autofarm started :)")
            else
                print("autofarm stopped :(")
            end
        end)
        autofarm:CreateInput({name="Write player name to give robrux",desc="u stuped?",ac={game:GetService("Players"):GetChildren(),{"Name","DisplayName"}}},function(text)
            local selected;
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Name == text or v.DisplayName == text then
                    selected = v.Name
                    break
                end
            end
            print("Selected: "..selected)

        end)
        autofarm:CreateSlider({name="Speedhack",exec=true,desc="umm spedheck?",min=10,def=16,max=115},function(number)
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = number
        end)
        autofarm:CreateBind({name="Sanig",desc="you will speed up every 1s",key="W",loop=true},function(k,tick)
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 16+tick
            wait(1)
        end)
        autofarm:CreateList({name="choose item to get",btns={"dildo",{"anime gril","dildo"},"yo mama",{"my mama","yo mama"}}},function(_)
            if _ == "yo mama" then print('i got yo mama lol.')
            elseif _ == "dildo" then print('check your ass.') end

        end)
    
    video tutorial: after development finish...

]]--



local lib = {}
function lib:init(loader_name,available_games_url)
    if type(loader_name) ~= "string" then warn("You must provide arg in lig:init(Name*)"); return end
    repeat wait() until game:IsLoaded() and game:GetService("CoreGui")

    -- old instance removal
    if getgenv().GreenCumLoaderHorseBabyUhhHello ~= nil then 
        pcall(function() getgenv().GreenCumLoaderHorseBabyUhhHello["Root.HideKeyBind"]:Disconnect() end)
        getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"]:Destroy()
        game:GetService("Workspace").Camera.FieldOfView = getgenv().GreenCumLoaderHorseBabyUhhHello["Root.deffov"] 
        if getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"] ~= nil then
            for i,v in pairs(getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"]) do
                for q,w in pairs(v["Binds"]) do
                    w:Disconnect()
                end
            end
        end
    
    end -- remove old shit
    getgenv().GreenCumLoaderHorseBabyUhhHello = {}
    -- settings
    local settings = {
        ZIndex = 100, -- global ZIndex of GUi
        root = { -- Loader settings
            ratio = 4
        },
        cs = { -- Custom Script settings
            ratio = 4
        },
        cm = { -- Custom Menus settings
            ratio = 4,
            button = {
                ratio = 4
            },
            toggle = {
                ratio = 4
            },
            input = {
                ratio = 4
            },
            slider = {
                ratio = 4
            },
            bind = {
                ratio = 4
            },
            list = {
                ratio = 4,
                btns = {
                    ratio = 4
                }
            },
            label = {
                ratio = 4
            }
        }
    }

    -- gui setup
    getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"] = Instance.new("ScreenGui")
     local DarkBg = Instance.new("Frame") -- black bg
      local Pattern = Instance.new("ImageLabel")
     local Main = Instance.new("ImageLabel") -- the gui start
      local Body = Instance.new("ImageLabel")
       local RootGeneral = Instance.new("Frame")
        local Execute = Instance.new("ImageButton")
         local Loading = Instance.new("ImageButton")
         local Bg = Instance.new("ImageLabel")
         local Cant = Instance.new("ImageButton")
        local ReloadFList = Instance.new("TextButton")
         local bg = Instance.new("ImageLabel")
         local signal0 = Instance.new("ImageButton")
         local signal1 = Instance.new("ImageButton")
         local signal2 = Instance.new("ImageButton")
         local signal3 = Instance.new("ImageButton")
         local signal4 = Instance.new("ImageButton")
         local signaloff = Instance.new("ImageButton")
         local friends = Instance.new("ImageButton")
         local nofriends = Instance.new("ImageButton")
        local AuthorName = Instance.new("ImageLabel")
         local Text = Instance.new("TextLabel")
        local CustomScripts = Instance.new("ImageLabel")
         local Scroll = Instance.new("ScrollingFrame")
          local UIGridLayout = Instance.new("UIGridLayout")
           -- custom scripts (dynamic)

        local Friends = Instance.new("ImageLabel")
         local Friends_2 = Instance.new("ScrollingFrame")
         local UIGridLayout_2 = Instance.new("UIGridLayout")
        local GameImage = Instance.new("ImageLabel")
        local GameName = Instance.new("ImageLabel")
         local Text_2 = Instance.new("TextLabel")
        local UnsupportReason = Instance.new("ImageLabel")
         local Text_3 = Instance.new("TextLabel")

      local Top = Instance.new("Frame")
       local LoaderName = Instance.new("ImageLabel")
        local Title = Instance.new("TextLabel")
       local HideKeyBind = Instance.new("ImageLabel")
        local KeyChanger = Instance.new("TextButton")
        local KeyBg = Instance.new("ImageLabel")
         local Key = Instance.new("TextLabel")
      local Rejoin = Instance.new("ImageLabel")
       local Reconn = Instance.new("TextButton")

      local Execbg = Instance.new("ImageLabel")
       local ExecMe = Instance.new("TextBox")
        local bg_8 = Instance.new("ImageLabel")

      local MenuChooser = Instance.new("ScrollingFrame")
       local UIGridLayout_5 = Instance.new("UIGridLayout")
       local RootGeneral_2 = Instance.new("TextButton")
        local bg_9 = Instance.new("ImageLabel")
        local MenuName = Instance.new("TextLabel")
    
    -- protect gui
    getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"].Name = "Loader: "..loader_name
    if syn then
        syn.protect_gui(getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"])
        getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"].Parent = game:GetService("CoreGui")
        print("Loading with synapse menu protector")
    elseif gethui() then
        getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"].Parent = gethui()
        print("Loading with gethui() menu protector")
    else
        getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"].Parent = game:GetService("CoreGui")
        print("Loading with default menu protector")
    end
    do
        Main.Name = "Main"
        Main.Parent = getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"]
        Main.AnchorPoint = Vector2.new(0.5, 0.5)
        Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Main.BackgroundTransparency = 1.000
        Main.Position = UDim2.new(0.499636352, 0, 0.5, 0)
        Main.Size = UDim2.new(0, 765, 0, 300)
        Main.ZIndex = settings.ZIndex+1
        Main.Image = "rbxassetid://3570695787"
        Main.ImageColor3 = Color3.fromRGB(48, 48, 48)
        Main.ImageTransparency = 0.100
        Main.ScaleType = Enum.ScaleType.Slice
        Main.SliceCenter = Rect.new(100, 100, 100, 100)
        Main.SliceScale = 0.080
        
        Body.Name = "Body"
        Body.Parent = Main
        Body.AnchorPoint = Vector2.new(0.5, 0.5)
        Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Body.BackgroundTransparency = 1.000
        Body.ClipsDescendants = true
        Body.Position = UDim2.new(0.5, 0, 0.553804874, 0)
        Body.Size = UDim2.new(0.990000069, 0, 0.852390289, 0)
        Body.ZIndex = settings.ZIndex+1
        Body.Image = "rbxassetid://3570695787"
        Body.ImageColor3 = Color3.fromRGB(28, 28, 28)
        Body.ImageTransparency = 0.100
        Body.ScaleType = Enum.ScaleType.Slice
        Body.SliceCenter = Rect.new(100, 100, 100, 100)
        Body.SliceScale = 0.080
        
        RootGeneral.Name = "Root.General"
        RootGeneral.Parent = Body
        RootGeneral.AnchorPoint = Vector2.new(0.5, 1)
        RootGeneral.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        RootGeneral.BackgroundTransparency = 1.000
        RootGeneral.ClipsDescendants = true
        RootGeneral.Position = UDim2.new(0.5, 0, 1, 0)
        RootGeneral.Size = UDim2.new(1, 0, 1, 0)
        RootGeneral.ZIndex = settings.ZIndex+1
        
        Bg.Name = "Bg"
        Bg.Parent = RootGeneral
        Bg.AnchorPoint = Vector2.new(0.5, 0.5)
        Bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Bg.BackgroundTransparency = 1.000
        Bg.Position = UDim2.new(0.192090005, 0, 0.428758383, 0)
        Bg.Size = UDim2.new(0, 30, 0, 30)
        Bg.ZIndex = settings.ZIndex+1
        Bg.Image = "rbxassetid://3570695787"
        Bg.ImageColor3 = Color3.fromRGB(22, 22, 22)
        Bg.ScaleType = Enum.ScaleType.Slice
        Bg.SliceCenter = Rect.new(100, 100, 100, 100)
        Bg.SliceScale = 0.080
        
        Execute.Name = "Execute"
        Execute.Parent = Bg
        Execute.AnchorPoint = Vector2.new(0.5, 0.5)
        Execute.BackgroundTransparency = 1.000
        Execute.LayoutOrder = 10
        Execute.Position = UDim2.new(0.5, 0, 0.5, 0)
        Execute.Size = UDim2.new(1, 0, 1, 0)
        Execute.ZIndex = settings.ZIndex+3
        Execute.Image = "rbxassetid://3926307971"
        Execute.ImageColor3 = Color3.fromRGB(200,200,200)
        Execute.ImageRectOffset = Vector2.new(764, 244)
        Execute.ImageRectSize = Vector2.new(36, 36)
        
        Loading.Name = "Loading"
        Loading.Parent = Bg
        Loading.AnchorPoint = Vector2.new(0.5, 0.5)
        Loading.BackgroundTransparency = 1.000
        Loading.LayoutOrder = 2
        Loading.Position = UDim2.new(0.5, 0, 0.5, 0)
        Loading.Rotation = 360.000
        Loading.Size = UDim2.new(1, 0, 1, 0)
        Loading.ZIndex = settings.ZIndex+2
        Loading.Image = "rbxassetid://3926305904"
        Loading.ImageRectOffset = Vector2.new(244, 684)
        Loading.ImageRectSize = Vector2.new(36, 36)
        Loading.ImageTransparency = 1.000
        
        Cant.Name = "Cant"
        Cant.Parent = Bg
        Cant.AnchorPoint = Vector2.new(0.5, 0.5)
        Cant.BackgroundTransparency = 1.000
        Cant.LayoutOrder = 7
        Cant.Position = UDim2.new(0.5, 0, 0.5, 0)
        Cant.Size = UDim2.new(0, 25, 0, 25)
        Cant.ZIndex = settings.ZIndex+2
        Cant.Image = "rbxassetid://3926305904"
        Cant.ImageColor3 = Color3.fromRGB(150, 0, 0)
        Cant.ImageRectOffset = Vector2.new(364, 324)
        Cant.ImageRectSize = Vector2.new(36, 36)
        Cant.ImageTransparency = 1.000
        
        ReloadFList.Name = "ReloadFList"
        ReloadFList.Parent = RootGeneral
        ReloadFList.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        ReloadFList.BackgroundTransparency = 1.000
        ReloadFList.BorderSizePixel = 0
        ReloadFList.Position = UDim2.new(0.81, 0, 0.035, 0)
        ReloadFList.Size = UDim2.new(0, 30, 0, 30)
        ReloadFList.ZIndex = settings.ZIndex+5
        ReloadFList.Font = Enum.Font.Ubuntu
        ReloadFList.Text = ""
        ReloadFList.TextColor3 = Color3.fromRGB(200, 200, 200)
        ReloadFList.TextSize = 14.000
        
        bg.Name = "bg"
        bg.Parent = ReloadFList
        bg.Active = true
        bg.AnchorPoint = Vector2.new(0.5, 0.5)
        bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bg.BackgroundTransparency = 1.000
        bg.Position = UDim2.new(0.5, 0, 0.5, 0)
        bg.Selectable = true
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.ZIndex = settings.ZIndex+1
        bg.Image = "rbxassetid://3570695787"
        bg.ImageColor3 = Color3.fromRGB(22, 22, 22)
        bg.ScaleType = Enum.ScaleType.Slice
        bg.SliceCenter = Rect.new(100, 100, 100, 100)
        bg.SliceScale = 0.080
        
        signal0.Name = "signal0"
        signal0.Parent = ReloadFList
        signal0.AnchorPoint = Vector2.new(0.5, 0.5)
        signal0.BackgroundTransparency = 1.000
        signal0.Position = UDim2.new(0.5, 0, 0.5, 0)
        signal0.Size = UDim2.new(0.8, 0, 0.8, 0)
        signal0.ZIndex = settings.ZIndex+2
        signal0.Image = "rbxassetid://3926307971"
        signal0.ImageRectOffset = Vector2.new(764, 204)
        signal0.ImageColor3 = Color3.fromRGB(255,255,255)
        signal0.ImageRectSize = Vector2.new(36, 36)
        signal0.ImageTransparency = 1.000
        
        signal1.Name = "signal1"
        signal1.Parent = ReloadFList
        signal1.AnchorPoint = Vector2.new(0.5, 0.5)
        signal1.BackgroundTransparency = 1.000
        signal1.Position = UDim2.new(0.5, 0, 0.5, 0)
        signal1.Size = UDim2.new(0.8, 0, 0.8, 0)
        signal1.ZIndex = settings.ZIndex+2
        signal1.Image = "rbxassetid://3926307971"
        signal1.ImageRectOffset = Vector2.new(364, 4)
        signal1.ImageColor3 = Color3.fromRGB(255,255,255)
        signal1.ImageRectSize = Vector2.new(36, 36)
        signal1.ImageTransparency = 1.000
        
        signal2.Name = "signal2"
        signal2.Parent = ReloadFList
        signal2.AnchorPoint = Vector2.new(0.5, 0.5)
        signal2.BackgroundTransparency = 1.000
        signal2.Position = UDim2.new(0.5, 0, 0.5, 0)
        signal2.Size = UDim2.new(0.8, 0, 0.8, 0)
        signal2.ZIndex = settings.ZIndex+2
        signal2.Image = "rbxassetid://3926307971"
        signal2.ImageRectOffset = Vector2.new(244, 164)
        signal2.ImageColor3 = Color3.fromRGB(255,255,255)
        signal2.ImageRectSize = Vector2.new(36, 36)
        signal2.ImageTransparency = 1.000
        
        signal3.Name = "signal3"
        signal3.Parent = ReloadFList
        signal3.AnchorPoint = Vector2.new(0.5, 0.5)
        signal3.BackgroundTransparency = 1.000
        signal3.Position = UDim2.new(0.5, 0, 0.5, 0)
        signal3.Size = UDim2.new(0.8, 0, 0.8, 0)
        signal3.ZIndex = settings.ZIndex+2
        signal3.Image = "rbxassetid://3926307971"
        signal3.ImageRectOffset = Vector2.new(124, 164)
        signal3.ImageColor3 = Color3.fromRGB(255,255,255)
        signal3.ImageRectSize = Vector2.new(36, 36)
        signal3.ImageTransparency = 1.000
        
        signal4.Name = "signal4"
        signal4.Parent = ReloadFList
        signal4.AnchorPoint = Vector2.new(0.5, 0.5)
        signal4.BackgroundTransparency = 1.000
        signal4.Position = UDim2.new(0.5, 0, 0.5, 0)
        signal4.Size = UDim2.new(0.8, 0, 0.8, 0)
        signal4.ZIndex = settings.ZIndex+2
        signal4.Image = "rbxassetid://3926307971"
        signal4.ImageRectOffset = Vector2.new(204, 364)
        signal4.ImageColor3 = Color3.fromRGB(255,255,255)
        signal4.ImageRectSize = Vector2.new(36, 36)
        signal4.ImageTransparency = 1.000
        
        signaloff.Name = "signaloff"
        signaloff.Parent = ReloadFList
        signaloff.AnchorPoint = Vector2.new(0.5, 0.5)
        signaloff.BackgroundTransparency = 1.000
        signaloff.Position = UDim2.new(0.5, 0, 0.5, 0)
        signaloff.Size = UDim2.new(0.8, 0, 0.8, 0)
        signaloff.ZIndex = settings.ZIndex+2
        signaloff.Image = "rbxassetid://3926307971"
        signaloff.ImageColor3 = Color3.fromRGB(200,200,200)
        signaloff.ImageRectOffset = Vector2.new(4, 524)
        signaloff.ImageRectSize = Vector2.new(36, 36)
        signaloff.ImageTransparency = 1.000
        
        friends.Name = "friends"
        friends.Parent = ReloadFList
        friends.AnchorPoint = Vector2.new(0.5, 0.5)
        friends.BackgroundTransparency = 1.000
        friends.Position = UDim2.new(0.5, 0, 0.5, 0)
        friends.Size = UDim2.new(0.8, 0, 0.8, 0)
        friends.ZIndex = settings.ZIndex+2
        friends.Image = "rbxassetid://3926305904"
        friends.ImageColor3 = Color3.fromRGB(200,200,200)
        friends.ImageRectOffset = Vector2.new(144, 4)
        friends.ImageRectSize = Vector2.new(24, 24)
        
        nofriends.Name = "nofriends"
        nofriends.Parent = ReloadFList
        nofriends.AnchorPoint = Vector2.new(0.5, 0.5)
        nofriends.BackgroundTransparency = 1.000
        nofriends.LayoutOrder = 14
        nofriends.Position = UDim2.new(0.5, 0, 0.5, 0)
        nofriends.Size = UDim2.new(0, 25, 0, 25)
        nofriends.ZIndex = settings.ZIndex+2
        nofriends.Image = "rbxassetid://3926307971"
        nofriends.ImageTransparency = 1
        nofriends.ImageRectOffset = Vector2.new(764, 124)
        nofriends.ImageColor3 = Color3.fromRGB(200,200,200)
        nofriends.ImageRectSize = Vector2.new(36, 36)
        
        AuthorName.Name = "AuthorName"
        AuthorName.Parent = RootGeneral
        AuthorName.AnchorPoint = Vector2.new(0, 0.5)
        AuthorName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AuthorName.BackgroundTransparency = 1.000
        AuthorName.Position = UDim2.new(0.172053903, 0, 0.290359944, 0)
        AuthorName.Size = UDim2.new(0, 30, 0, 30)
        AuthorName.ZIndex = settings.ZIndex+1
        AuthorName.Image = "rbxassetid://3570695787"
        AuthorName.ImageColor3 = Color3.fromRGB(22, 22, 22)
        AuthorName.ScaleType = Enum.ScaleType.Slice
        AuthorName.SliceCenter = Rect.new(100, 100, 100, 100)
        AuthorName.SliceScale = 0.080
        
        Text.Name = "Text"
        Text.Parent = AuthorName
        Text.AnchorPoint = Vector2.new(0.5, 0.5)
        Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text.BackgroundTransparency = 1.000
        Text.BorderSizePixel = 0
        Text.Position = UDim2.new(0.5, 0, 0.5, 0)
        Text.Size = UDim2.new(0.95, 0, 0.85, 0)
        Text.ZIndex = settings.ZIndex+2
        Text.Font = Enum.Font.Ubuntu
        Text.Text = "?"
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextScaled = true
        Text.TextSize = 14.000
        Text.TextWrapped = true
        
        CustomScripts.Name = "CustomScripts"
        CustomScripts.Parent = RootGeneral
        CustomScripts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CustomScripts.BackgroundTransparency = 1.000
        CustomScripts.Position = UDim2.new(0.0105631473, 0, 0.516195476, 0)
        CustomScripts.Size = UDim2.new(0, 743, 0, 117)
        CustomScripts.ZIndex = settings.ZIndex+1
        CustomScripts.Image = "rbxassetid://3570695787"
        CustomScripts.ImageColor3 = Color3.fromRGB(22, 22, 22)
        CustomScripts.ScaleType = Enum.ScaleType.Slice
        CustomScripts.SliceCenter = Rect.new(100, 100, 100, 100)
        CustomScripts.SliceScale = 0.080
        
        Scroll.Name = "Scroll"
        Scroll.Parent = CustomScripts
        Scroll.Active = true
        Scroll.AnchorPoint = Vector2.new(0.5, 0.5)
        Scroll.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        Scroll.BackgroundTransparency = 1.000
        Scroll.BorderSizePixel = 0
        Scroll.Position = UDim2.new(0.5, 0, 0.5, 0)
        Scroll.Size = UDim2.new(0.980000019, 0, 0.920000017, 0)
        Scroll.ZIndex = settings.ZIndex+2
        Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        Scroll.ScrollBarThickness = 5
        
        UIGridLayout.Parent = Scroll
        UIGridLayout.FillDirection = Enum.FillDirection.Vertical
        UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIGridLayout.CellPadding = UDim2.new(0, 2, 0, 2)
        UIGridLayout.CellSize = UDim2.new(0, 50, 0, 50)
        
        Friends.Name = "Friends"
        Friends.Parent = RootGeneral
        Friends.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Friends.BackgroundTransparency = 1.000
        Friends.Position = UDim2.new(0.860000014, 0, 0.0350000001, 0)
        Friends.Size = UDim2.new(0, 100, 0, 115)
        Friends.ZIndex = settings.ZIndex+3
        Friends.Image = "rbxassetid://3570695787"
        Friends.ImageColor3 = Color3.fromRGB(22, 22, 22)
        Friends.ImageTransparency = 0.100
        Friends.ScaleType = Enum.ScaleType.Slice
        Friends.SliceCenter = Rect.new(100, 100, 100, 100)
        Friends.SliceScale = 0.080
        
        Friends_2.Name = "Friends"
        Friends_2.Parent = Friends
        Friends_2.Active = true
        Friends_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Friends_2.BackgroundTransparency = 1.000
        Friends_2.BorderSizePixel = 0
        Friends_2.Size = UDim2.new(1, 0, 1, 0)
        Friends_2.ZIndex = settings.ZIndex+3
        Friends_2.CanvasSize = UDim2.new(0, 0, 0, 0)
        Friends_2.ScrollBarThickness = 2
        
        UIGridLayout_2.Parent = Friends_2
        UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIGridLayout_2.CellPadding = UDim2.new(0, 2, 0, 2)
        UIGridLayout_2.CellSize = UDim2.new(0, 49, 0, 49)
        
        GameImage.Name = "GameImage"
        GameImage.Parent = RootGeneral
        GameImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GameImage.BorderSizePixel = 0
        GameImage.Position = UDim2.new(0.0303690489, 0, 0.0977642909, 0)
        GameImage.Size = UDim2.new(0, 100, 0, 100)
        GameImage.ZIndex = settings.ZIndex+3
        GameImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        
        GameName.Name = "GameName"
        GameName.Parent = RootGeneral
        GameName.AnchorPoint = Vector2.new(0, 0.5)
        GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GameName.BackgroundTransparency = 1.000
        GameName.Position = UDim2.new(0.172194093, 0, 0.152536571, 0)
        GameName.Size = UDim2.new(0, 30, 0, 30)
        GameName.ZIndex = settings.ZIndex+1
        GameName.Image = "rbxassetid://3570695787"
        GameName.ImageColor3 = Color3.fromRGB(22, 22, 22)
        GameName.ScaleType = Enum.ScaleType.Slice
        GameName.SliceCenter = Rect.new(100, 100, 100, 100)
        GameName.SliceScale = 0.080
        
        Text_2.Name = "Text"
        Text_2.Parent = GameName
        Text_2.AnchorPoint = Vector2.new(0.5, 0.5)
        Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text_2.BackgroundTransparency = 1.000
        Text_2.BorderSizePixel = 0
        Text_2.Position = UDim2.new(0.5, 0, 0.5, 0)
        Text_2.Size = UDim2.new(0.95, 0, 0.85, 0)
        Text_2.ZIndex = settings.ZIndex+2
        Text_2.Font = Enum.Font.Ubuntu
        Text_2.Text = "?"
        Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text_2.TextScaled = true
        Text_2.TextSize = 14.000
        Text_2.TextWrapped = true
        
        UnsupportReason.Name = "UnsupportReason"
        UnsupportReason.Parent = RootGeneral
        UnsupportReason.AnchorPoint = Vector2.new(0, 0.5)
        UnsupportReason.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UnsupportReason.BackgroundTransparency = 1.000
        UnsupportReason.ClipsDescendants = true
        UnsupportReason.Position = UDim2.new(0.221048653, 0, 0.426276594, 0)
        UnsupportReason.Size = UDim2.new(0, 0, 0, 30)
        UnsupportReason.ZIndex = settings.ZIndex+1
        UnsupportReason.Image = "rbxassetid://3570695787"
        UnsupportReason.ImageColor3 = Color3.fromRGB(22, 22, 22)
        UnsupportReason.ScaleType = Enum.ScaleType.Slice
        UnsupportReason.SliceCenter = Rect.new(100, 100, 100, 100)
        UnsupportReason.SliceScale = 0.080
        
        Text_3.Name = "Text"
        Text_3.Parent = UnsupportReason
        Text_3.AnchorPoint = Vector2.new(0.5, 0.5)
        Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text_3.BackgroundTransparency = 1.000
        Text_3.BorderSizePixel = 0
        Text_3.Position = UDim2.new(0.5, 0, 0.5, 0)
        Text_3.Size = UDim2.new(0.95, 0, 0.85, 0)
        Text_3.ZIndex = settings.ZIndex+2
        Text_3.Font = Enum.Font.Ubuntu
        Text_3.Text = "?"
        Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text_3.TextScaled = true
        Text_3.TextSize = 14.000
        Text_3.TextTransparency = 1.000
        Text_3.TextWrapped = true
        
        Top.Name = "Top"
        Top.Parent = Main
        Top.AnchorPoint = Vector2.new(0.5, 0.5)
        Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Top.BackgroundTransparency = 1.000
        Top.BorderSizePixel = 0
        Top.ClipsDescendants = true
        Top.Position = UDim2.new(0.500476718, 0, 0.0610886104, 0)
        Top.Size = UDim2.new(0.99000001, 0, 0, 26)
        Top.ZIndex = settings.ZIndex+1
        
        LoaderName.Name = "LoaderName"
        LoaderName.Parent = Top
        LoaderName.AnchorPoint = Vector2.new(0, 0.5)
        LoaderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LoaderName.BackgroundTransparency = 1.000
        LoaderName.ClipsDescendants = true
        LoaderName.Position = UDim2.new(0, 0, 0.5, 0)
        LoaderName.Size = UDim2.new(0.0311879404, 0, 1.00000024, 0)
        LoaderName.ZIndex = settings.ZIndex+1
        LoaderName.Image = "rbxassetid://3570695787"
        LoaderName.ImageColor3 = Color3.fromRGB(28, 28, 28)
        LoaderName.ImageTransparency = 0.100
        LoaderName.ScaleType = Enum.ScaleType.Slice
        LoaderName.SliceCenter = Rect.new(100, 100, 100, 100)
        LoaderName.SliceScale = 0.080
        
        Title.Name = "Title"
        Title.Parent = LoaderName
        Title.AnchorPoint = Vector2.new(0.5, 0.5)
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.50999999, 0, 0.5, 0)
        Title.Size = UDim2.new(0.95, 0, 0.899999976, 0)
        Title.ZIndex = settings.ZIndex+2
        Title.Font = Enum.Font.SourceSans
        Title.Text = loader_name
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        Title.TextSize = 14.000
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left
        
        HideKeyBind.Name = "HideKeyBind"
        HideKeyBind.Parent = Top
        HideKeyBind.AnchorPoint = Vector2.new(1, 0.5)
        HideKeyBind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        HideKeyBind.BackgroundTransparency = 1.000
        HideKeyBind.ClipsDescendants = true
        HideKeyBind.Position = UDim2.new(1, 0, 0.5, 0)
        HideKeyBind.Size = UDim2.new(0.163068727, 0, 1, 0)
        HideKeyBind.ZIndex = settings.ZIndex+2
        HideKeyBind.Image = "rbxassetid://3570695787"
        HideKeyBind.ImageColor3 = Color3.fromRGB(28, 28, 28)
        HideKeyBind.ImageTransparency = 0.100
        HideKeyBind.ScaleType = Enum.ScaleType.Slice
        HideKeyBind.SliceCenter = Rect.new(100, 100, 100, 100)
        HideKeyBind.SliceScale = 0.080
        
        KeyChanger.Name = "KeyChanger"
        KeyChanger.Parent = HideKeyBind
        KeyChanger.AnchorPoint = Vector2.new(0, 0.5)
        KeyChanger.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        KeyChanger.BackgroundTransparency = 1.000
        KeyChanger.BorderSizePixel = 0
        KeyChanger.Position = UDim2.new(0.0501244068, 0, 0.5, 0)
        KeyChanger.Size = UDim2.new(0.646933317, 0, 0.900000036, 0)
        KeyChanger.ZIndex = settings.ZIndex+3
        KeyChanger.Modal = true
        KeyChanger.Font = Enum.Font.Ubuntu
        KeyChanger.Text = "Show/Hide Key"
        KeyChanger.TextColor3 = Color3.fromRGB(200, 200, 200)
        KeyChanger.TextSize = 16.000
        KeyChanger.TextWrapped = true
        KeyChanger.TextXAlignment = Enum.TextXAlignment.Left
        
        KeyBg.Name = "KeyBg"
        KeyBg.Parent = HideKeyBind
        KeyBg.AnchorPoint = Vector2.new(0.5, 0.5)
        KeyBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        KeyBg.BackgroundTransparency = 1.000
        KeyBg.Position = UDim2.new(0.859271586, 0, 0.5, 0)
        KeyBg.Size = UDim2.new(0.185205981, 0, 0.85, 0)
        KeyBg.ZIndex = settings.ZIndex+3
        KeyBg.Image = "rbxassetid://3570695787"
        KeyBg.ImageColor3 = Color3.fromRGB(20, 20, 20)
        KeyBg.ImageTransparency = 0.100
        KeyBg.ScaleType = Enum.ScaleType.Slice
        KeyBg.SliceCenter = Rect.new(100, 100, 100, 100)
        KeyBg.SliceScale = 0.080
        
        Key.Name = "Key"
        Key.Parent = KeyBg
        Key.AnchorPoint = Vector2.new(0.5, 0.5)
        Key.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Key.BackgroundTransparency = 1.000
        Key.BorderSizePixel = 0
        Key.ClipsDescendants = true
        Key.Position = UDim2.new(0.5, 0, 0.5, 0)
        Key.Size = UDim2.new(0.95, 0, 0.95, 0)
        Key.ZIndex = settings.ZIndex+4
        Key.Font = Enum.Font.Ubuntu
        Key.Text = "?"
        Key.TextColor3 = Color3.fromRGB(200, 200, 200)
        Key.TextScaled = true
        Key.TextSize = 18.000
        Key.TextWrapped = true
        
        Rejoin.Name = "Rejoin"
        Rejoin.Parent = Top
        Rejoin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Rejoin.BackgroundTransparency = 1.000
        Rejoin.Position = UDim2.new(0.7, 0, 0, 0)
        Rejoin.Size = UDim2.new(0, 100, 0, 25)
        Rejoin.ZIndex = settings.ZIndex+3
        Rejoin.Image = "rbxassetid://3570695787"
        Rejoin.ImageColor3 = Color3.fromRGB(28, 28, 28)
        Rejoin.ScaleType = Enum.ScaleType.Slice
        Rejoin.SliceCenter = Rect.new(100, 100, 100, 100)
        Rejoin.SliceScale = 0.080
        
        Reconn.Name = "Reconn"
        Reconn.Parent = Rejoin
        Reconn.AnchorPoint = Vector2.new(0.5, 0.5)
        Reconn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Reconn.BackgroundTransparency = 1.000
        Reconn.BorderSizePixel = 0
        Reconn.Position = UDim2.new(0.5, 0, 0.5, 0)
        Reconn.Size = UDim2.new(1, 0, 1, 0)
        Reconn.ZIndex = settings.ZIndex+4
        Reconn.Font = Enum.Font.Ubuntu
        Reconn.Text = "Rejoin"
        Reconn.TextColor3 = Color3.fromRGB(200, 200, 200)
        Reconn.TextSize = 18.000
        
        Execbg.Name = "Execbg"
        Execbg.Parent = Main
        Execbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Execbg.BackgroundTransparency = 1.000
        Execbg.ClipsDescendants = true
        Execbg.Position = UDim2.new(0, 0, 1.02, 0)
        Execbg.Size = UDim2.new(0, 765, 0, 32)
        Execbg.ZIndex = settings.ZIndex+3
        Execbg.Image = "rbxassetid://3570695787"
        Execbg.ImageColor3 = Color3.fromRGB(48, 48, 48)
        Execbg.ScaleType = Enum.ScaleType.Slice
        Execbg.SliceCenter = Rect.new(100, 100, 100, 100)
        Execbg.SliceScale = 0.080
        
        ExecMe.Name = "ExecMe"
        ExecMe.Parent = Execbg
        ExecMe.AnchorPoint = Vector2.new(0.5, 0.5)
        ExecMe.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        ExecMe.BackgroundTransparency = 1.000
        ExecMe.BorderSizePixel = 0
        ExecMe.Position = UDim2.new(0.5, 0, 0.5, 0)
        ExecMe.Size = UDim2.new(0.97, 0, 0.7, 0)
        ExecMe.ZIndex = settings.ZIndex+4
        ExecMe.ClearTextOnFocus = false
        ExecMe.Font = Enum.Font.Ubuntu
        ExecMe.Text = "Execute script."
        ExecMe.TextColor3 = Color3.fromRGB(144, 144, 144)
        ExecMe.TextSize = 14.000
        ExecMe.TextXAlignment = Enum.TextXAlignment.Left
        
        bg_8.Name = "bg"
        bg_8.Parent = ExecMe
        bg_8.Active = true
        bg_8.AnchorPoint = Vector2.new(0.5, 0.5)
        bg_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bg_8.BackgroundTransparency = 1.000
        bg_8.Position = UDim2.new(0.5, 0, 0.5, 0)
        bg_8.Selectable = true
        bg_8.Size = UDim2.new(1, 10, 1, 0)
        bg_8.ZIndex = settings.ZIndex+3
        bg_8.Image = "rbxassetid://3570695787"
        bg_8.ImageColor3 = Color3.fromRGB(28, 28, 28)
        bg_8.ScaleType = Enum.ScaleType.Slice
        bg_8.SliceCenter = Rect.new(100, 100, 100, 100)
        bg_8.SliceScale = 0.080
        
        MenuChooser.Name = "MenuChooser"
        MenuChooser.Parent = Main
        MenuChooser.Active = true
        MenuChooser.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MenuChooser.BackgroundTransparency = 1.000
        MenuChooser.BorderColor3 = Color3.fromRGB(255, 6, 231)
        MenuChooser.BorderSizePixel = 0
        MenuChooser.Position = UDim2.new(1, 0, 0.022, 0)
        MenuChooser.Size = UDim2.new(0, 125, 0, 286)
        MenuChooser.ZIndex = settings.ZIndex+3
        MenuChooser.CanvasSize = UDim2.new(0, 0, 0, 0)
        MenuChooser.ScrollBarThickness = 3
        MenuChooser.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
        
        UIGridLayout_5.Parent = MenuChooser
        UIGridLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
        UIGridLayout_5.CellPadding = UDim2.new(0, 2, 0, 1)
        UIGridLayout_5.CellSize = UDim2.new(1, 0, 0, 35)
        
        RootGeneral_2.Name = "Root.General"
        RootGeneral_2.Parent = MenuChooser
        RootGeneral_2.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        RootGeneral_2.BackgroundTransparency = 1.000
        RootGeneral_2.BorderSizePixel = 0
        RootGeneral_2.Size = UDim2.new(0, 200, 0, 50)
        RootGeneral_2.ZIndex = settings.ZIndex+4
        RootGeneral_2.Font = Enum.Font.Ubuntu
        RootGeneral_2.Text = ""
        RootGeneral_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        RootGeneral_2.TextSize = 16.000
        RootGeneral_2.TextWrapped = true
        
        bg_9.Name = "bg"
        bg_9.Parent = RootGeneral_2
        bg_9.Active = true
        bg_9.AnchorPoint = Vector2.new(1, 0.5)
        bg_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bg_9.BackgroundTransparency = 1.000
        bg_9.BorderSizePixel = 0
        bg_9.Position = UDim2.new(0.999999046, 0, 0.5, 0)
        bg_9.Selectable = true
        bg_9.Size = UDim2.new(1, 30, 1, 0)
        bg_9.ZIndex = settings.ZIndex+3
        bg_9.Image = "rbxassetid://3570695787"
        bg_9.ImageColor3 = Color3.fromRGB(23, 23, 23)
        bg_9.ScaleType = Enum.ScaleType.Slice
        bg_9.SliceCenter = Rect.new(100, 100, 100, 100)
        bg_9.SliceScale = 0.120
        
        MenuName.Name = "MenuName"
        MenuName.Parent = RootGeneral_2
        MenuName.AnchorPoint = Vector2.new(0.5, 0.5)
        MenuName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MenuName.BackgroundTransparency = 1.000
        MenuName.BorderSizePixel = 0
        MenuName.Position = UDim2.new(0.5, 0, 0.5, 0)
        MenuName.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
        MenuName.ZIndex = settings.ZIndex+5
        MenuName.Font = Enum.Font.Ubuntu
        MenuName.Text = loader_name
        MenuName.TextColor3 = Color3.fromRGB(200, 200, 200)
        MenuName.TextSize = 16.000
        MenuName.TextXAlignment = Enum.TextXAlignment.Left
        
        DarkBg.Name = "DarkBg"
        DarkBg.Parent = getgenv().GreenCumLoaderHorseBabyUhhHello["Root.ScreenGui"]
        DarkBg.AnchorPoint = Vector2.new(0.5, 0.5)
        DarkBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        DarkBg.BackgroundTransparency = 0.150
        DarkBg.BorderSizePixel = 0
        DarkBg.Position = UDim2.new(0.5, 0, 0.5, 0)
        DarkBg.Size = UDim2.new(2, 0, 2, 0)
        DarkBg.ZIndex = settings.ZIndex-1
        
        Pattern.Name = "Pattern"
        Pattern.Parent = DarkBg
        Pattern.AnchorPoint = Vector2.new(0.5, 0.5)
        Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Pattern.BackgroundTransparency = 1.000
        Pattern.Position = UDim2.new(0.7, 0, 0.4, 0)
        Pattern.Size = UDim2.new(1, 0, 1, 0)
        Pattern.ZIndex = settings.ZIndex
        Pattern.Image = "rbxassetid://2151741365"
        Pattern.ImageTransparency = 0.600
        Pattern.ScaleType = Enum.ScaleType.Tile
        Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
        Pattern.TileSize = UDim2.new(0, 250, 0, 250)
    end -- main gui setup end

    -- services
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local tps = game:GetService("TeleportService")
    local UIS = game:GetService("UserInputService")
    local req = (syn and syn.request) or (http and http.request) or http_request

    -- script global vars
    local isstillcd = false
    local activepage = {m=RootGeneral,b=RootGeneral_2} -- default loader page
    
    -- script global functions
    local function toRGB(instance) -- returns table with: %var = {R,G,B} colors (only instances with colors)
        return {R=math.round(instance.R*255),G=math.round(instance.G*255),B=math.round(instance.B*255)}
    
    end
    local function autosizeY(instance, callback)
        spawn(function()
    	local buttons = 0
    	local tosize;
	    for i,v in pairs(instance:GetChildren()) do
	    	if v.ClassName == "UIGridLayout" then
                tosize = v
            else buttons = buttons + 1 end
    
	    end
    	local khm = buttons * (tosize.CellSize.Y.Offset + tosize.CellPadding.Y.Offset)
    	TweenService:Create(instance,TweenInfo.new(.1),{CanvasSize = UDim2.new(0,0,0,khm)}):Play()
    	
        callback = function() end
        pcall(callback, buttons) end)
    end
    local function click(type,c,i1,i2,fisonbtn,setting)
        local i2type = "TextColor3"
        type = tostring(type):lower()
        if i2.ClassName == "ImageButton" or i2.ClassName == "ImageLabel" then i2type = "ImageColor3" end

	    if type == "up" then
            TweenService:Create(i2,TweenInfo.new(.25),{[i2type] = Color3.fromRGB(200, 200, 200)}):Play()
            TweenService:Create(i1,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
            if fisonbtn then
                TweenService:Create(i2,TweenInfo.new(.25),{[i2type] = Color3.fromRGB(255,255,255)}):Play()
                TweenService:Create(i1,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings[setting].ratio,c.G+settings[setting].ratio,c.B+settings[setting].ratio)}):Play()
                
            end

        elseif type == "down" then
            TweenService:Create(i2,TweenInfo.new(.25),{[i2type] = Color3.fromRGB(150, 150, 150)}):Play()
            TweenService:Create(i1,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings[setting].ratio,c.G-settings[setting].ratio,c.B-settings[setting].ratio)}):Play()

        elseif type == "enter" then
            fisonbtn = true
            TweenService:Create(i2,TweenInfo.new(.25),{[i2type] = Color3.fromRGB(255,255,255)}):Play()
            TweenService:Create(i1,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings[setting].ratio,c.G+settings[setting].ratio,c.B+settings[setting].ratio)}):Play()
        
        elseif type == "leave" then
            fisonbtn = false
            TweenService:Create(i2,TweenInfo.new(.25),{[i2type] = Color3.fromRGB(200, 200, 200)}):Play()
            TweenService:Create(i1,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
        
        end
    end
    --[[ background tasks
    do
         functions
        spawn(function() -- ugly bg animation
            local igetmad = true
            while igetmad == true do
                TweenService:Create(Pattern,TweenInfo.new(30),{Position = UDim2.new(0.4, 0, 0.7, 0)}):Play()
                wait(30)
                TweenService:Create(Pattern,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                wait(.1)
                Pattern.Position = UDim2.new(0.7, 0, 0.4, 0)
                TweenService:Create(Pattern,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                
            end 
        end)
    end]]
    
    -- getting information from internet
    local json,data = nil,nil
    if req then
        if type(available_games_url) == "string" then
            local r = req({Url = available_games_url, Method = "GET"})
            if r.Body ~= "404: Not Found" then 
                json = HttpService:JSONDecode(r.Body)
                local gameid = game.PlaceId
                if json[tostring(game.PlaceId)] then
                    if json[tostring(game.PlaceId)]["exec?"] then gameid = json[tostring(game.PlaceId)]["exec?"] end
                    if json[tostring(gameid)] then data = json[tostring(gameid)] else data = json[tostring(game.PlaceId)] end
                else
                    data = HttpService:JSONDecode('{"author": false, "script": false, "lobby": null}')
                end
            end
        end
    end

    do -- exec root script
    	local execdb = false
    	local isexecutable = true
        if json == nil then
            isexecutable = false 
            Text_3.Text = "Service unvanable."
        elseif data.script == false and type(data["exec?"]) ~= "string" then 
            isexecutable = false 
            Text_3.Text = "Game unsupported."
        elseif data.lobby == true and type(data["exec?"]) ~= "string" and data.script == nil then
            isexecutable = false 
            Text_3.Text = "Start game to exec script."
        elseif data.script == true or type(data["exec?"]) == "string" then 
            local gameid = game.PlaceId
            if type(json[tostring(game.PlaceId)]["exec?"]) == "string" then gameid = json[tostring(game.PlaceId)]["exec?"] end
            Text_3.Text = json["script-path"] .. gameid .. ".lua"
        else
            Text_3.Text = data.script
        end
    
    	-- Exec
        local isonbtn = false
        local awaitinstop = false
        local c = toRGB(Bg.ImageColor3)
    	Execute.MouseEnter:Connect(function()
            isonbtn = true
    		if isexecutable then
                click("enter",c,Bg,Execute,isonbtn,"root")
    		else
                repeat wait() until awaitinstop == false
    			TweenService:Create(Execute,TweenInfo.new(.12),{ImageTransparency = 1}):Play()
    			TweenService:Create(Cant,TweenInfo.new(.15),{ImageTransparency = 0}):Play()
    			
    			TweenService:Create(Cant,TweenInfo.new(.15),{Rotation = 0}):Play()
    			TweenService:Create(Cant,TweenInfo.new(1.5),{ImageColor3 = Color3.fromRGB(200, 0, 0)}):Play()
    			TweenService:Create(Execute,TweenInfo.new(.15),{Rotation = 45}):Play()

    			TweenService:Create(UnsupportReason,TweenInfo.new(.25),{Size = UDim2.new(0,string.len(UnsupportReason.Text.Text)*8,0,30)}):Play()
    			TweenService:Create(UnsupportReason.Text,TweenInfo.new(.1),{TextTransparency = 0}):Play()
    		end
    	end)
    	Execute.MouseLeave:Connect(function()
            isonbtn = false
    		if isexecutable then
                click("leave",c,Bg,Execute,isonbtn,"root")
    		else
                awaitinstop = true
    			TweenService:Create(Execute,TweenInfo.new(.15),{ImageTransparency = 0}):Play()
    			TweenService:Create(Cant,TweenInfo.new(.12),{ImageTransparency = 1}):Play()
    			
    			TweenService:Create(Cant,TweenInfo.new(.15),{Rotation = -45}):Play()
    			TweenService:Create(Cant,TweenInfo.new(1.5),{ImageColor3 = Color3.fromRGB(150, 0, 0)}):Play()
    			TweenService:Create(Execute,TweenInfo.new(.15),{Rotation = 0}):Play()
            
    			TweenService:Create(UnsupportReason.Text,TweenInfo.new(.1),{TextTransparency = 1}):Play()
    			TweenService:Create(UnsupportReason,TweenInfo.new(.25),{Size = UDim2.new(0,0,0,30)}):Play()

                wait(.15)
                awaitinstop = false
                Cant.ImageColor3 = Color3.fromRGB(150, 0, 0)
    		end
    	end)
    	Execute.MouseButton1Down:Connect(function() 
    		if not isexecutable then return end
            click("down",c,Bg,Execute,isonbtn,"root")
    	end)
    
    	Execute.MouseButton1Up:Connect(function()
    		if not isexecutable then return end
        
            click("up",c,Bg,Execute,isonbtn,"root")
    		local function loadanim()
    			spawn(function()
    				while execdb == true do
    					TweenService:Create(Loading,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Rotation = 0}):Play()
    					wait(1)
    					Loading.Rotation = 360
    				end
    			end)
    		end
        
    		if not execdb then
    			execdb = true
    			loadanim()
    			TweenService:Create(Execute,TweenInfo.new(.15),{ImageTransparency = 1}):Play()
    			TweenService:Create(Loading,TweenInfo.new(.15),{ImageTransparency = 0}):Play()
    			loadstring(game:HttpGet(Text_3.Text))()
    			TweenService:Create(Loading,TweenInfo.new(.15),{ImageTransparency = 1}):Play()
    			TweenService:Create(Execute,TweenInfo.new(.15),{ImageTransparency = 0}):Play()
    			execdb = false
    		end
        
    	end)
    
    	-- Loading.
    	Loading.MouseEnter:Connect(function() TweenService:Create(Loading,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(255, 255, 0)}):Play() end)
    	Loading.MouseLeave:Connect(function() TweenService:Create(Loading,TweenInfo.new(.15),{ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play() end)
    end
    do -- Friends func
        local player = game.Players.LocalPlayer
        local function uhh_tmp()
            TweenService:Create(signal0,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            TweenService:Create(signal1,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            TweenService:Create(signal2,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            TweenService:Create(signal3,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            TweenService:Create(signal4,TweenInfo.new(.1),{ImageTransparency = 1}):Play()

            TweenService:Create(signaloff,TweenInfo.new(.1),{ImageTransparency = 1}):Play() 
            TweenService:Create(nofriends,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            TweenService:Create(friends,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
            wait(0.1)

        end
        local function _tmp(ss)
            wait(ss)
            local lfriends;
            local frinds = 0
            local susus = pcall(function() lfriends = player:GetFriendsOnline(200) end)
            if susus then
                for i,v in pairs(lfriends) do
                    if v.PlaceId == nil then return end
                    frinds = frinds + 1
                    local newFrame = Instance.new("ImageButton") -- gen button
                    newFrame.Name = v.UserName
                    newFrame.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username="..v.UserName
                    newFrame.Parent = Friends_2
                    newFrame.BackgroundColor3 = Color3.fromRGB(32,32,32)
                    newFrame.BackgroundTransparency = 1
                    newFrame.BorderSizePixel = 0
                    newFrame.ZIndex = settings.ZIndex+5
                    newFrame.ClipsDescendants = true
                    newFrame.ImageTransparency = 1
                    local PlrName = Instance.new("TextLabel")
                    PlrName.Name = v.UserName
                    PlrName.Parent = newFrame
                    PlrName.AnchorPoint = Vector2.new(0.5,0.5)
                    PlrName.Size = UDim2.new(1,0,1,0)
                    PlrName.Position = UDim2.new(0.5,0,0.5,0)
                    PlrName.BackgroundTransparency = 1
                    PlrName.BorderSizePixel = 0
                    PlrName.ZIndex = settings.ZIndex+6
                    PlrName.TextColor3 = Color3.fromRGB(255, 255, 255)
                    PlrName.TextWrapped = true
                    PlrName.TextTransparency = 1
                    PlrName.Text = v.UserName.."\n"..v.DisplayName
                    PlrName.TextSize = 6
                    local frbg = Instance.new("ImageLabel")
                    frbg.Name = "bg"
                    frbg.Parent = newFrame
                    frbg.AnchorPoint = Vector2.new(0.5,0.5)
                    frbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    frbg.BackgroundTransparency = 1.000
                    frbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                    frbg.ZIndex = settings.ZIndex+4
                    frbg.Size = UDim2.new(1, 0, 1, 0)
                    frbg.Image = "rbxassetid://3570695787"
                    frbg.ImageTransparency = 1
                    frbg.ImageColor3 = Color3.fromRGB(35, 35, 35)
                    frbg.ScaleType = Enum.ScaleType.Slice
                    frbg.SliceCenter = Rect.new(100, 100, 100, 100)
                    frbg.SliceScale = 0.080
                    TweenService:Create(newFrame,TweenInfo.new(0.25),{ImageTransparency = 0}):Play()
                    PlrName.MouseEnter:Connect(function()
                        TweenService:Create(frbg,TweenInfo.new(0.25),{ImageTransparency = 0.75}):Play()
                        TweenService:Create(PlrName,TweenInfo.new(0.12),{TextTransparency = 0}):Play()
                    end)
                    PlrName.MouseLeave:Connect(function()
                        TweenService:Create(frbg,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                        TweenService:Create(PlrName,TweenInfo.new(0.12),{TextTransparency = 1}):Play()
                    end)
                    newFrame.MouseButton1Click:Connect(function()
                        tps:TeleportCancel()
                        if v.GameId ~= nil then teleport_connection = tps:TeleportToPlaceInstance(v.PlaceId, v.GameId, player)
                        else teleport_connection = tps:Teleport(v.PlaceId) end
                    end)
                end
                if frinds == 0 then uhh_tmp();TweenService:Create(nofriends,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                else uhh_tmp();TweenService:Create(friends,TweenInfo.new(.1),{ImageTransparency = 0}):Play() end
            else uhh_tmp();TweenService:Create(signaloff,TweenInfo.new(.1),{ImageTransparency = 0}):Play() end
            TweenService:Create(Friends_2,TweenInfo.new(0.25),{CanvasSize = UDim2.new(0,0,0,(frinds/2)*31)}):Play()
        end
        local isloading,nextgen = false,false
        local function reloadfriendslist()
            if nextgen then return end
            uhh_tmp()
            spawn(function()
                if not nextgen then
                    nextgen,isloading = true,true
                    local function stopme()
                        if isloading == false then
                            TweenService:Create(signal0,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal1,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal2,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal3,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal4,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                            return 1
                        
                        end
                    end
                    spawn(function()
                        while isloading == true do
                            TweenService:Create(signal0,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                            wait(.25); if stopme() == 1 then break end
                            TweenService:Create(signal0,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal1,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                            wait(.25); if stopme() == 1 then break end
                            TweenService:Create(signal1,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal2,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                            wait(.25); if stopme() == 1 then break end
                            TweenService:Create(signal2,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal3,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                            wait(.25); if stopme() == 1 then break end
                            TweenService:Create(signal3,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                            TweenService:Create(signal4,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
                            wait(.25); if stopme() == 1 then break end
                            TweenService:Create(signal4,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                        
                        end
                    end)
                    for i,v in pairs(Friends_2:GetChildren()) do
                        spawn(function()
                            if v.ClassName ~= "UIGridLayout" and v.ClassName ~= "LocalScript" then
                                TweenService:Create(v,TweenInfo.new(0.25),{ImageTransparency = 1}):Play()
                                wait(0.25)
                                v:Destroy()
                            end
                        end)
                    end
                    _tmp(0.3)
	    	        isloading = false
                    wait(1)
                    nextgen = false
                end
            end)
        end
        spawn(function() while true do reloadfriendslist(); wait(15) end end)
        do -- friend-list reload
            local c = toRGB(bg.ImageColor3)
            local isonbtn = false
            ReloadFList.MouseButton1Up:Connect(function()
                click("up",c,bg,friends,isonbtn,"root")
                reloadfriendslist() -- in-func db

            end)
            ReloadFList.MouseButton1Down:Connect(function()
                click("down",c,bg,friends,isonbtn,"root")

            end)
            ReloadFList.MouseEnter:Connect(function()
                isonbtn = true
                click("enter",c,bg,friends,isonbtn,"root")

            end)
            ReloadFList.MouseLeave:Connect(function()
                isonbtn = false
                click("leave",c,bg,friends,isonbtn,"root")

            end)
        end

    end
    do -- Root.General setup
        spawn(function()
            local gameid = game.PlaceId
            if json ~= nil then
                if json[tostring(game.PlaceId)] and json[tostring(game.PlaceId)].game then
                    if type(json[tostring(game.PlaceId)]["game"]) == "string" then Text.Text = json[tostring(json[tostring(game.PlaceId)].game)].author end
                elseif (type(data.author) == "boolean" or data.author == nil) then 
                    Text.Text = "Unknown."
                else
                    Text.Text = data.author
                end
                if data.lobby ~= nil and data.lobby ~= true and type(data["exec?"]) == "string" then
                    gameid = data["exec?"] 
                elseif data.lobby ~= nil and data.lobby ~= true and type(data.lobby) == "string" then 
                    gameid = data.lobby 
                end
            else
                Text.Text = "Unknown."
            end
            local product = game:GetService("MarketplaceService"):GetProductInfo(gameid)
            Text_2.Text = product.Name 
            GameImage.Image = "rbxthumb://type=Asset&id="..product.IconImageAssetId.."&w=420&h=420"

            local size0 = string.len(Title.Text)*8
            local size1 = string.len(Text_2.Text)*8
            local size2 = string.len(Text.Text)*8
            TweenService:Create(LoaderName,TweenInfo.new(.25),{Size = UDim2.new(0, size0,1, 0)}):Play()
    	    TweenService:Create(GameName,TweenInfo.new(.25),{Size = UDim2.new(0,size1,0,30)}):Play()
    	    TweenService:Create(AuthorName,TweenInfo.new(.25),{Size = UDim2.new(0,size2,0,30)}):Play()
    	    TweenService:Create(GameImage,TweenInfo.new(.25),{ImageTransparency = 0}):Play()
            
            -- Root.General buttons
            do -- Rejoin
                local isonbtn = false
                local c = toRGB(Rejoin.ImageColor3)
	            Reconn.MouseButton1Up:Connect(function()
                    click("up",c,Rejoin,Reconn,isonbtn,"root")

                    tps:TeleportCancel()
	            	tps:TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
	            end)
	            Reconn.MouseButton1Down:Connect(function()
                    click("down",c,Rejoin,Reconn,isonbtn,"root")

	            end)
	            Reconn.MouseEnter:Connect(function()
                    isonbtn = true
                    click("enter",c,Rejoin,Reconn,isonbtn,"root")

	            end)
	            Reconn.MouseLeave:Connect(function()
                    isonbtn = false
                    click("leave",c,Rejoin,Reconn,isonbtn,"root")

	            end)
            end

        end)
    end
    do -- hide/show
	    local camera = game:GetService("Workspace"):WaitForChild("Camera")
        getgenv().GreenCumLoaderHorseBabyUhhHello["Root.deffov"] = camera.FieldOfView
    	-- DBs
    	local iskeychanging = false
    	local ismenuopened = true
	    local ismousernables = UIS.MouseIconEnabled

    	local lashchoosenkey = "X"
    	Key.Text = lashchoosenkey
    	
    	-- function
    	if ismenuopened then TweenService:Create(camera,TweenInfo.new(.15),{FieldOfView = getgenv().GreenCumLoaderHorseBabyUhhHello["Root.deffov"] - 20}):Play() end
    	local function AppAction()
    		if ismenuopened == false then
                UIS.MouseIconEnabled = ismousernables
    			TweenService:Create(Main,TweenInfo.new(.15),{Position = UDim2.new(0.5,0,1.3,0)}):Play()
    			TweenService:Create(DarkBg,TweenInfo.new(.15),{BackgroundTransparency = 1.00}):Play()
    			TweenService:Create(Pattern,TweenInfo.new(.1),{ImageTransparency = 1.00}):Play()
    			TweenService:Create(camera,TweenInfo.new(.15),{FieldOfView = getgenv().GreenCumLoaderHorseBabyUhhHello["Root.deffov"]}):Play()
    		elseif ismenuopened == true then
                ismousernables = UIS.MouseIconEnabled
                getgenv().GreenCumLoaderHorseBabyUhhHello["Root.deffov"] = camera.FieldOfView
            	UIS.MouseIconEnabled = true
    			TweenService:Create(Main,TweenInfo.new(.15),{Position = UDim2.new(0.5,0,0.5,0)}):Play()
    			TweenService:Create(DarkBg,TweenInfo.new(.15),{BackgroundTransparency = 0.15}):Play()
    			TweenService:Create(Pattern,TweenInfo.new(.1),{ImageTransparency = 0}):Play()
    			TweenService:Create(camera,TweenInfo.new(.15),{FieldOfView = getgenv().GreenCumLoaderHorseBabyUhhHello["Root.deffov"] - 20}):Play()
    		end
            wait(.25)
    	end
    	AppAction()
        
    	-- Show/Hide Menu
        local isonbtn = false
        local c = toRGB(HideKeyBind.ImageColor3)
    	getgenv().GreenCumLoaderHorseBabyUhhHello["Root.HideKeyBind"] = UIS.InputBegan:Connect(function(input,enter)
            if input.KeyCode.Value == 0 or enter then return end
    		if iskeychanging then
    			lashchoosenkey = input.KeyCode.Name
    			Key.Text = lashchoosenkey
    			iskeychanging = false
    		elseif input.KeyCode.Name == tostring(Key.Text) then
                ismenuopened = not ismenuopened
                AppAction()
    		end
    	end)
    
    	-- Change Key
    	KeyChanger.MouseButton1Up:Connect(function()
            click("up",c,HideKeyBind,Key,isonbtn,"root")
            TweenService:Create(KeyChanger,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150,150,150)}):Play()
            if isonbtn then TweenService:Create(KeyChanger,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200,200,200)}):Play() end

    		if Key.Text == "?" then
    			iskeychanging = false
    			Key.Text = lashchoosenkey
    		else
    			Key.Text = "?"
    			iskeychanging = true
    		end
    	end)
    	KeyChanger.MouseButton1Down:Connect(function()
            click("down",c,HideKeyBind,Key,isonbtn,"root")
            TweenService:Create(KeyChanger,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150,150,150)}):Play()

        end)
    	KeyChanger.MouseEnter:Connect(function()
            isonbtn = true
            click("enter",c,HideKeyBind,Key,isonbtn,"root")
            TweenService:Create(KeyChanger,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        end)
    	KeyChanger.MouseLeave:Connect(function()
            isonbtn = false
            click("leave",c,HideKeyBind,Key,isonbtn,"root")
            TweenService:Create(KeyChanger,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200,200,200)}):Play()
        end)
    end
    do -- ExecMe.Execscript 
    	local defexectxt = ExecMe.Text
    	local lastscripttxt = ""
    	
    	local function _tmp(newtext)
    		TweenService:Create(ExecMe,TweenInfo.new(.05),{TextTransparency = 1}):Play()
    		wait(0.05)
    		ExecMe.Text = newtext
    		TweenService:Create(ExecMe,TweenInfo.new(.05),{TextTransparency = 0}):Play()
    		
    	end
    	ExecMe.Focused:Connect(function()
    		TweenService:Create(ExecMe,TweenInfo.new(.2),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    		_tmp(lastscripttxt)
    		
    	end)
    	ExecMe.FocusLost:Connect(function()
    	    if pcall(function() loadstring(tostring(ExecMe.Text))() end) then
    		    lastscripttxt = ExecMe.Text end
    		TweenService:Create(ExecMe,TweenInfo.new(.2),{TextColor3 = Color3.fromRGB(144, 144, 144)}):Play()
    		_tmp(defexectxt)
    		
    	end)
    end
    do -- RootGeneral_2.click (to api)
    	-- saving button colors
    	local c = toRGB(bg_9.ImageColor3)
    
    	-- main function
    	TweenService:Create(bg_9,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)}):Play()
    	TweenService:Create(MenuName,TweenInfo.new(.1),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        
    	local isonbtn = false
    	local ismyactive = true
    	RootGeneral_2.MouseButton1Up:Connect(function()
            click("up",c,bg_9,MenuName,isonbtn,"root")
    		if isstillcd then return
    		elseif RootGeneral.Name == activepage['m'].Name then return end
    		isstillcd = true
    		-- load page
    		RootGeneral.Visible = true
            TweenService:Create(bg_9,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)}):Play()
            TweenService:Create(MenuName,TweenInfo.new(.1),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    		TweenService:Create(RootGeneral,TweenInfo.new(.25),{Position = UDim2.new(0.5,0,1,0)}):Play()
    		TweenService:Create(activepage['m'],TweenInfo.new(.25),{Position = UDim2.new(0.5,0,2.1,0)}):Play()
    		TweenService:Create(activepage['b'].MenuName,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
    		TweenService:Create(activepage['b'].bg,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
    		activepage['m'] = RootGeneral
    		activepage['b'] = RootGeneral_2
        
    		wait(0.3)	-- remove bug
    		isstillcd = false
    	end)
    
    	-- visuals only
    	RootGeneral_2.MouseButton1Down:Connect(function()
            click("down",c,bg_9,MenuName,isonbtn,"root")
        
    	end)
    	RootGeneral_2.MouseEnter:Connect(function()
    		isonbtn = true
    		if activepage['b'].Name == RootGeneral_2.Name then return end
            click("enter",c,bg_9,MenuName,isonbtn,"root")
        
    	end)
    	RootGeneral_2.MouseLeave:Connect(function()
    		isonbtn = false
    		if activepage['b'].Name == RootGeneral_2.Name then 
                TweenService:Create(bg_9,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)}):Play()
                TweenService:Create(MenuName,TweenInfo.new(.1),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                return end
            click("leave",c,bg_9,MenuName,isonbtn,"root")
        
    	end)
    end

    local lib2 = {}
    function lib2:CustomScript(script_name, script_link) -- Custom script function
        for i,v in pairs(Scroll:GetChildren()) do
            if v.Name == 'Script: '..script_name and v.ClassName == "TextButton" then
                Scroll.CanvasSize = UDim2.new(0,Scroll.CanvasSize.X.Offset-26,0,0)
                spawn(function()
                    v.Selectable = false
                    TweenService:Create(v.name,TweenInfo.new(.1),{TextTransparency = 1}):Play()
                    TweenService:Create(v.bg,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                    wait(.1)
                    v:Destroy()
                end)
                break
            end
        end
        wait(.15)

        if not type(script_link) == "string" then -- avoid some shit
            script_link = script_link or function() end end
        
            -- custom script button setup
            local cs_btn = Instance.new("TextButton")
            local cs_bg = Instance.new("ImageLabel")
            local cs_name = Instance.new("TextLabel")
            do
                cs_btn.Name = 'Script: '..script_name
                cs_btn.Parent = Scroll
                cs_btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                cs_btn.BackgroundTransparency = 1.000
                cs_btn.BorderSizePixel = 0
                cs_btn.Size = UDim2.new(0, 200, 0, 50)
                cs_btn.ZIndex = settings.ZIndex+7
                cs_btn.Font = Enum.Font.SourceSans
                cs_btn.TextColor3 = Color3.fromRGB(0, 0, 0)
                cs_btn.Text = ""
                cs_btn.TextSize = 14.000
                
                cs_bg.Name = "bg"
                cs_bg.Parent = cs_btn
                cs_bg.Active = true
                cs_bg.AnchorPoint = Vector2.new(0.5, 0.5)
                cs_bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                cs_bg.BackgroundTransparency = 1.000
                cs_bg.Position = UDim2.new(0.5, 0, 0.5, 0)
                cs_bg.Selectable = true
                cs_bg.Size = UDim2.new(1, 0, 1, 0)
                cs_bg.ZIndex = settings.ZIndex+5
                cs_bg.Image = "rbxassetid://3570695787"
                cs_bg.ImageTransparency = 1
                cs_bg.ImageColor3 = Color3.fromRGB(30, 30, 30)
                cs_bg.ScaleType = Enum.ScaleType.Slice
                cs_bg.SliceCenter = Rect.new(100, 100, 100, 100)
                cs_bg.SliceScale = 0.080
                
                cs_name.Name = "name"
                cs_name.Parent = cs_btn
                cs_name.AnchorPoint = Vector2.new(0.5, 0.5)
                cs_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                cs_name.BackgroundTransparency = 1.000
                cs_name.BorderSizePixel = 0
                cs_name.Position = UDim2.new(0.5, 0, 0.5, 0)
                cs_name.Size = UDim2.new(0.899999976, 0, 0.8, 0)
                cs_name.ZIndex = settings.ZIndex+6
                cs_name.Font = Enum.Font.Ubuntu
                cs_name.Text = script_name
                cs_name.TextColor3 = Color3.fromRGB(200, 200, 200)
                cs_name.TextScaled = true
                cs_name.TextTransparency = 1
                cs_name.TextSize = 14.000
                cs_name.TextWrapped = true
                Scroll.CanvasSize = UDim2.new(0,Scroll.CanvasSize.X.Offset+26,0,0) -- auto size (Scroll)
            end
            spawn(function()
                TweenService:Create(cs_name,TweenInfo.new(.25),{TextTransparency = 0}):Play()
                TweenService:Create(cs_bg,TweenInfo.new(.25),{ImageTransparency = 0}):Play()
                wait(.25)
            end)

            -- function
            local db = false
            local isonbtn = false
            local c = toRGB(cs_bg.ImageColor3)
            cs_btn.MouseButton1Up:Connect(function()
                click("up",c,cs_bg,cs_name,isonbtn,"cs")

                if db then return end
                db = true
                if type(script_link) == "string" then
                    loadstring(game:HttpGet(script_link))()
                else
                    pcall(script_link)
                end
                db = false
            end)
            
            -- visuals
            cs_btn.MouseButton1Down:Connect(function()
                click("down",c,cs_bg,cs_name,isonbtn,"cs")
            
            end)
            cs_btn.MouseEnter:Connect(function()
                isonbtn = true
                click("enter",c,cs_bg,cs_name,isonbtn,"cs")
            
            end)
            cs_btn.MouseLeave:Connect(function()
                isonbtn = false
                click("leave",c,cs_bg,cs_name,isonbtn,"cs")
            
            end)
            
    end
    local menunum = 0
    getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"] = {}
    function lib2:AddMenu(menu_name)
        menunum = menunum + 1
        local activetab = nil
        local tabnum = 0
        local mijnmenu_num = menunum
        local islistopened = false
        
        local function removeMenu()
            for i,v in pairs(Body:GetChildren()) do
                if v.Name == "Menus."..menu_name and v.ClassName == "Frame" then
                    if activepage['m'].Name == v.Name then 
                        menunum = menunum - 1
                        activepage = {m=RootGeneral,b=RootGeneral_2} 
                        local c = toRGB(bg_9.ImageColor3)
                        v.Selectable = false
                        TweenService:Create(bg_9,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)}):Play()
                        TweenService:Create(MenuName,TweenInfo.new(.1),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                        TweenService:Create(RootGeneral,TweenInfo.new(.1),{Position = UDim2.new(0.5,0,1,0)}):Play()
                        TweenService:Create(v,TweenInfo.new(.1),{Position = UDim2.new(0.5,0,2.1,0)}):Play()
                        wait(.1)
                    end
                    v:Destroy()
                    for q,w in pairs(MenuChooser:GetChildren()) do
                        if w.Name == "Menus."..menu_name and w.ClassName == 'TextButton' then
                            spawn(function()
                                w.Selectable = false
                                TweenService:Create(w.bg,TweenInfo.new(.1),{ImageTransparency = 1}):Play()
                                TweenService:Create(w.MenuName,TweenInfo.new(.1),{TextTransparency = 1}):Play()
                                wait(.1)
                                w:Destroy()
                            end)
                            break
                        end
                    end
                    for q,w in pairs(getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"][menu_name]["Binds"]) do
                        w:Disconnect()
                    end
                    break
                end
            end
        end
        removeMenu()
        wait(.15)
        getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"][menu_name] = {Binds={}}
        local NewMenu = Instance.new("Frame") -- the menu
        local NewMenuButton = Instance.new("TextButton") -- btn changer
         local NewMenuBg = Instance.new("ImageLabel")
         local NewMenuTitle = Instance.new("TextLabel")
         local close_icon = Instance.new("ImageButton")
        local NewMenuScroll = Instance.new("ImageLabel") -- tab selector
         local NewMenuscr = Instance.new("ScrollingFrame")
          local NewMenuUIG = Instance.new("UIGridLayout")
        do
            NewMenuButton.Name = "Menus."..menu_name
            NewMenuButton.Parent = MenuChooser
            NewMenuButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
            NewMenuButton.BackgroundTransparency = 1.000
            NewMenuButton.BorderSizePixel = 0
            NewMenuButton.Size = UDim2.new(0, 200, 0, 50)
            NewMenuButton.ZIndex = settings.ZIndex+3
            NewMenuButton.Font = Enum.Font.Ubuntu
            NewMenuButton.Text = ""
            NewMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            NewMenuButton.TextSize = 16.000
            NewMenuButton.TextWrapped = true
            
            NewMenuBg.Name = "bg"
            NewMenuBg.Parent = NewMenuButton
            NewMenuBg.Active = true
            NewMenuBg.AnchorPoint = Vector2.new(1, 0.5)
            NewMenuBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NewMenuBg.BackgroundTransparency = 1.000
            NewMenuBg.BorderSizePixel = 0
            NewMenuBg.Position = UDim2.new(1, 0, 0.5, 0)
            NewMenuBg.Selectable = true
            NewMenuBg.ImageTransparency = 1
            NewMenuBg.Size = UDim2.new(1, 30, 1, 0)
            NewMenuBg.ZIndex = settings.ZIndex+4
            NewMenuBg.Image = "rbxassetid://3570695787"
            NewMenuBg.ImageColor3 = Color3.fromRGB(23, 23, 23)
            NewMenuBg.ScaleType = Enum.ScaleType.Slice
            NewMenuBg.SliceCenter = Rect.new(100, 100, 100, 100)
            NewMenuBg.SliceScale = 0.120
            
            NewMenuTitle.Name = "MenuName"
            NewMenuTitle.Parent = NewMenuButton
            NewMenuTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            NewMenuTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NewMenuTitle.BackgroundTransparency = 1.000
            NewMenuTitle.BorderSizePixel = 0
            NewMenuTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
            NewMenuTitle.Size = UDim2.new(0.75, 0, 0.9, 0)
            NewMenuTitle.ZIndex = settings.ZIndex+5
            NewMenuTitle.Font = Enum.Font.Ubuntu
            NewMenuTitle.Text = menu_name
            NewMenuTitle.TextTransparency = 1
            NewMenuTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            NewMenuTitle.TextSize = 16.000
            NewMenuTitle.TextXAlignment = Enum.TextXAlignment.Left

            close_icon.Name = "Close"
            close_icon.Parent = NewMenuButton
            close_icon.AnchorPoint = Vector2.new(0.5, 0.5)
            close_icon.BackgroundTransparency = 1.000
            close_icon.Position = UDim2.new(0.885, 0, 0.5, 0)
            close_icon.Size = UDim2.new(0, 15, 0, 15)
            close_icon.ZIndex = settings.ZIndex+6
            close_icon.Image = "rbxassetid://3926305904"
            close_icon.ImageColor3 = Color3.fromRGB(80, 80, 80)
            close_icon.ImageRectOffset = Vector2.new(284, 4)
            close_icon.ImageRectSize = Vector2.new(24, 24)
        end
        TweenService:Create(NewMenuBg,TweenInfo.new(.25),{ImageTransparency = 0}):Play()
        TweenService:Create(NewMenuTitle,TweenInfo.new(.25),{TextTransparency = 0}):Play()
        if string.len(menu_name) > 12 then
            NewMenuTitle.TextWrapped = true
            NewMenuTitle.TextScaled = true
        end

        do
            local c = toRGB(close_icon.ImageColor3)
            local isonbtn = false
            close_icon.MouseButton1Up:Connect(function()
                if isonbtn then
                    TweenService:Create(close_icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)})
                else
                    TweenService:Create(close_icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)})
                end
                removeMenu()

            end)
            close_icon.MouseButton1Down:Connect(function()
                TweenService:Create(close_icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.root.ratio,c.G-settings.root.ratio,c.B-settings.root.ratio)})
            
            end)
            close_icon.MouseEnter:Connect(function()
                isonbtn = true
                TweenService:Create(close_icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)})
            
            end)
            close_icon.MouseLeave:Connect(function()
                isonbtn = false
                TweenService:Create(close_icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)})
            
            end)
        end

        local Desc = Instance.new("TextButton")
         local desc = Instance.new("TextBox")
         local bg_6 = Instance.new("ImageLabel")
        local blackBg = Instance.new("TextButton")
         local bg_7 = Instance.new("ImageLabel")
        local ListSelector = Instance.new("TextButton")
         local LSbg = Instance.new("ImageLabel")

        do
            NewMenu.Name = "Menus."..menu_name
            NewMenu.Parent = Body
            NewMenu.AnchorPoint = Vector2.new(0.5, 1)
            NewMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NewMenu.BackgroundTransparency = 1.000
            NewMenu.ClipsDescendants = true
            NewMenu.Position = UDim2.new(0.5, 0, 2.1, 0)
            NewMenu.Size = UDim2.new(1, 0, 1, 0)
            NewMenu.ZIndex = settings.ZIndex+1

            Desc.Name = "Desc"
            Desc.Parent = NewMenu
            Desc.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Desc.BackgroundTransparency = 1.000
            Desc.BorderSizePixel = 0
            Desc.Position = UDim2.new(0, 0, 1.1, 0)
            Desc.Size = UDim2.new(1, 0, 0, 200)
            Desc.ZIndex = settings.ZIndex+25
            Desc.Font = Enum.Font.SourceSans
            Desc.Text = ""
            Desc.TextColor3 = Color3.fromRGB(0, 0, 0)
            Desc.TextSize = 14.000

            desc.Name = "desc"
            desc.Parent = Desc
            desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            desc.BackgroundTransparency = 1.000
            desc.Position = UDim2.new(0.010568032, 0, 0.0490196086, 0)
            desc.Size = UDim2.new(0.98, 0, 0.98, 0)
            desc.ZIndex = settings.ZIndex+26
            desc.Font = Enum.Font.Ubuntu
            desc.Text = "Desc"
            desc.ClearTextOnFocus = false
            desc.TextEditable = false
            desc.TextColor3 = Color3.fromRGB(255, 255, 255)
            desc.TextSize = 16.000
            desc.TextXAlignment = Enum.TextXAlignment.Left
            desc.TextYAlignment = Enum.TextYAlignment.Top
            
            bg_6.Name = "bg"
            bg_6.Parent = Desc
            bg_6.Active = true
            bg_6.AnchorPoint = Vector2.new(0.5, 0.5)
            bg_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            bg_6.BackgroundTransparency = 1.000
            bg_6.Position = UDim2.new(0.5, 0, 0.5, 0)
            bg_6.Selectable = true
            bg_6.Size = UDim2.new(1, 0, 1, 0)
            bg_6.ZIndex = settings.ZIndex+24
            bg_6.Image = "rbxassetid://3570695787"
            bg_6.ImageColor3 = Color3.fromRGB(30, 30, 30)
            bg_6.ScaleType = Enum.ScaleType.Slice
            bg_6.SliceCenter = Rect.new(100, 100, 100, 100)
            bg_6.SliceScale = 0.080
            
            ListSelector.Name = "ListSelector"
            ListSelector.Parent = NewMenu
            ListSelector.AnchorPoint = Vector2.new(0.5, 0.5)
            ListSelector.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ListSelector.BackgroundTransparency = 1.000
            ListSelector.BorderSizePixel = 0
            ListSelector.Position = UDim2.new(1.60000002, 0, 0.5, 0)
            ListSelector.Size = UDim2.new(0, 388, 0, 247)
            ListSelector.ZIndex = 125
            ListSelector.Font = Enum.Font.SourceSans
            ListSelector.TextColor3 = Color3.fromRGB(0, 0, 0)
            ListSelector.TextSize = 14.000

            LSbg.Name = "bg"
            LSbg.Parent = ListSelector
            LSbg.Active = true
            LSbg.AnchorPoint = Vector2.new(0.5, 0.5)
            LSbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LSbg.BackgroundTransparency = 1.000
            LSbg.Position = UDim2.new(0.5, 0, 0.5, 0)
            LSbg.Selectable = true
            LSbg.Size = UDim2.new(1, 0, 1, 0)
            LSbg.ZIndex = 125
            LSbg.Image = "rbxassetid://3570695787"
            LSbg.ImageColor3 = Color3.fromRGB(30, 30, 30)
            LSbg.ScaleType = Enum.ScaleType.Slice
            LSbg.SliceCenter = Rect.new(100, 100, 100, 100)
            LSbg.SliceScale = 0.080

            blackBg.Name = "blackBg"
            blackBg.Parent = NewMenu
            blackBg.Active = false
            blackBg.AnchorPoint = Vector2.new(0.5, 0.5)
            blackBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            blackBg.BackgroundTransparency = 1.000
            blackBg.BorderSizePixel = 0
            blackBg.Position = UDim2.new(0.5, 0, 0.5, 0)
            blackBg.Selectable = false
            blackBg.Size = UDim2.new(1, 0, 1, 0)
            blackBg.ZIndex = settings.ZIndex+24
            blackBg.AutoButtonColor = false
            blackBg.Font = Enum.Font.SourceSans
            blackBg.Text = ""
            blackBg.TextColor3 = Color3.fromRGB(0, 0, 0)
            blackBg.TextSize = 14.000
            
            bg_7.Name = "bg"
            bg_7.Parent = blackBg
            bg_7.AnchorPoint = Vector2.new(0.5, 0.5)
            bg_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            bg_7.BackgroundTransparency = 1.000
            bg_7.Position = UDim2.new(0.5, 0, 0.5, 0)
            bg_7.Size = UDim2.new(1, 0, 1, 0)
            bg_7.ZIndex = settings.ZIndex+23
            bg_7.Image = "rbxassetid://3570695787"
            bg_7.ImageColor3 = Color3.fromRGB(0, 0, 0)
            bg_7.ImageTransparency = 1.000
            bg_7.ScaleType = Enum.ScaleType.Slice
            bg_7.SliceCenter = Rect.new(100, 100, 100, 100)
            bg_7.SliceScale = 0.080
            
            NewMenuScroll.Name = "Scroll"
            NewMenuScroll.Parent = NewMenu
            NewMenuScroll.AnchorPoint = Vector2.new(0.5, 0.5)
            NewMenuScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NewMenuScroll.BackgroundTransparency = 1.000
            NewMenuScroll.Position = UDim2.new(0.07, 0, 0.5, 0)
            NewMenuScroll.Size = UDim2.new(0, 100, 0, 250)
            NewMenuScroll.ZIndex = settings.ZIndex+3
            NewMenuScroll.Image = "rbxassetid://3570695787"
            NewMenuScroll.ImageColor3 = Color3.fromRGB(22, 22, 22)
            NewMenuScroll.ScaleType = Enum.ScaleType.Slice
            NewMenuScroll.SliceCenter = Rect.new(100, 100, 100, 100)
            NewMenuScroll.SliceScale = 0.080

            NewMenuscr.Name = "scr"
            NewMenuscr.Parent = NewMenuScroll
            NewMenuscr.Active = true
            NewMenuscr.AnchorPoint = Vector2.new(0.5, 0.5)
            NewMenuscr.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            NewMenuscr.BackgroundTransparency = 1.000
            NewMenuscr.BorderSizePixel = 0
            NewMenuscr.Position = UDim2.new(0.5, 0, 0.5, 0)
            NewMenuscr.Size = UDim2.new(0.94, 0, 0.96, 0)
            NewMenuscr.ZIndex = settings.ZIndex+3
            NewMenuscr.CanvasSize = UDim2.new(0, 0, 0, 0)
            NewMenuscr.ScrollBarThickness = 3
            NewMenuscr.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
            NewMenuscr.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

            NewMenuUIG.Parent = NewMenuscr
            NewMenuUIG.SortOrder = Enum.SortOrder.LayoutOrder
            NewMenuUIG.CellPadding = UDim2.new(0, 5, 0, 2)
            NewMenuUIG.CellSize = UDim2.new(1, 0, 0, 30)
            -- Dynamic (tabs)
        end
        do
            blackBg.MouseButton1Click:Connect(function()
                TweenService:Create(Desc,TweenInfo.new(.25),{Position = UDim2.new(0, 0, 1.1, 0)}):Play()
                TweenService:Create(ListSelector,TweenInfo.new(.25),{Position = UDim2.new(1.6, 0, 0.5, 0)}):Play()
                TweenService:Create(bg_7,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                wait(.25)
                blackBg.Visible = false
                islistopened = false
            
            end)
        end
        local function tipgen(parent,descstring)
            descstring = tostring(descstring)
            local info = Instance.new("TextButton")
             local iicon = Instance.new("ImageButton")
            info.Name = "info"
            info.Parent = parent
            info.AnchorPoint = Vector2.new(0.5, 0.5)
            info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            info.BackgroundTransparency = 1.000
            info.Position = UDim2.new(0.964999974, 0, 0.488999993, 0)
            info.Size = UDim2.new(0, 30, 0, 30)
            info.ZIndex = settings.ZIndex+5
            info.Font = Enum.Font.SourceSans
            info.Text = ""
            info.TextColor3 = Color3.fromRGB(0, 0, 0)
            info.TextSize = 14.000
            
            iicon.Name = "icon"
            iicon.Parent = info
            iicon.AnchorPoint = Vector2.new(0.5, 0.5)
            iicon.BackgroundTransparency = 1.000
            iicon.LayoutOrder = 4
            iicon.Position = UDim2.new(0.5, 0, 0.5, 0)
            iicon.Size = UDim2.new(0, 25, 0, 25)
            iicon.ZIndex = settings.ZIndex+4
            iicon.Image = "rbxassetid://3926305904"
            iicon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            iicon.ImageRectOffset = Vector2.new(524, 444)
            iicon.ImageRectSize = Vector2.new(36, 36)

            if descstring == "" then
                info.Active = false
                info.Selectable = false
                TweenService:Create(iicon,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                info.Visible = false
            else
                info.Visible = true
                TweenService:Create(iicon,TweenInfo.new(.25),{ImageTransparency = 0}):Play()
                info.Active = true
                info.Selectable = true
            end


            local ispressed = false
            info.MouseButton1Up:Connect(function()
                if not ispressed then return end
                ispressed = false
                blackBg.Visible = true
                TweenService:Create(iicon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                desc.Text = descstring
                Desc.Visible = true
                TweenService:Create(Desc,TweenInfo.new(.25),{Position = UDim2.new(0, 0, 0.258, 0)}):Play()
                TweenService:Create(bg_7,TweenInfo.new(.25),{ImageTransparency = 0.15}):Play()
            
            end)
        
            info.MouseButton1Down:Connect(function()
                ispressed = true
                TweenService:Create(iicon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(150, 150, 150)}):Play()
            
            end)
            info.MouseEnter:Connect(function()
                if islistopened then return end
                TweenService:Create(iicon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            
            end)
            info.MouseLeave:Connect(function()
                ispressed = false
                if islistopened then return end
                TweenService:Create(iicon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            
            end)

            local llib = {}
            function llib:Desc(new_string)
                new_string = tostring(new_string)
                TweenService:Create(desc,TweenInfo.new(.25),{TextTransparency = 1}):Play()
                wait(.25)
                desc.Text = new_string
                TweenService:Create(desc,TweenInfo.new(.25),{TextTransparency = 0}):Play()
                if new_string == "" then
                    info.Active = false
                    info.Selectable = false
                    TweenService:Create(iicon,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                    wait(.25)
                    info.Visible = false
                else
                    info.Visible = true
                    TweenService:Create(iicon,TweenInfo.new(.25),{ImageTransparency = 0}):Play()
                    wait(.25)
                    info.Active = true
                    info.Selectable = true
                end
                
            end

            return llib

        end
        do -- menu changer
        
            -- saving button colors
            local c = toRGB(NewMenuBg.ImageColor3)
        
            -- main function
            local isonbtn = false
            local ismyactive = false
            local c = toRGB(NewMenuBg.ImageColor3)
            local isutingthis = false
            NewMenuButton.MouseButton1Up:Connect(function()
                if not isutingthis then return end
                isutingthis = false
                click("down",c,NewMenuBg,NewMenuTitle,isonbtn,'cm')
                if isstillcd then return
                elseif NewMenuButton.Name == activepage['m'].Name then return end
                isstillcd = true
                -- load page
                NewMenuButton.Visible = true
                TweenService:Create(NewMenuBg,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)}):Play()
                TweenService:Create(NewMenuTitle,TweenInfo.new(.1),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                TweenService:Create(activetab,TweenInfo.new(.25),{Position = UDim2.new(0.5,0,1,0)}):Play()
                TweenService:Create(activepage['m'],TweenInfo.new(.25),{Position = UDim2.new(0.5,0,2.1,0)}):Play()
                TweenService:Create(activepage['b'].MenuName,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                TweenService:Create(activepage['b'].bg,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                activepage['m'] = activetab
                activepage['b'] = NewMenuButton
            
                wait(0.3)	-- remove bug
                isstillcd = false
            end)
        
            -- visuals only
            NewMenuButton.MouseButton1Down:Connect(function()
                click("down",c,NewMenuBg,NewMenuTitle,isonbtn,'cm')
                isutingthis = true
            
            end)
            NewMenuButton.MouseEnter:Connect(function()
                if islistopened then return end
                isonbtn = true
                if activepage['b'].Name == NewMenuButton.Name then return end
                click("enter",c,NewMenuBg,NewMenuTitle,isonbtn,'cm')
            
            end)
            NewMenuButton.MouseLeave:Connect(function()
                isonbtn = false
                isutingthis = false
                if islistopened then return end
                if activepage['b'].Name == NewMenuButton.Name then 
                    TweenService:Create(NewMenuBg,TweenInfo.new(.1),{ImageColor3 = Color3.fromRGB(c.R+settings.root.ratio,c.G+settings.root.ratio,c.B+settings.root.ratio)}):Play()
                    TweenService:Create(NewMenuTitle,TweenInfo.new(.1),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    return end
                click("leave",c,NewMenuBg,NewMenuTitle,isonbtn,'cm')
            
            end)
        end
        local tlib = {}
        function tlib:AddTab(tab_name)
            local lib3 = {}
            tabnum = tabnum + 1
            local mijntabid = tabnum
            local counters = {buttons=0,toggles=0,inputs=0,binds=0,lists=0,sliders=0,labels=0}

            local Menu1_2 = Instance.new("ScrollingFrame")
             local UIGridLayout_4 = Instance.new("UIGridLayout")
            local NewMenu1 = Instance.new("TextButton")
             local NewMenubg = Instance.new("ImageLabel")
            do
                NewMenu1.Name = "tab "..tab_name -- list
                NewMenu1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NewMenu1.BackgroundTransparency = 1.000
                NewMenu1.BorderSizePixel = 0
                NewMenu1.Parent = NewMenuscr
                NewMenu1.Size = UDim2.new(0, 200, 0, 50)
                NewMenu1.ZIndex = settings.ZIndex+5
                NewMenu1.Font = Enum.Font.Ubuntu
                NewMenu1.Text = tab_name
                NewMenu1.TextColor3 = Color3.fromRGB(200, 200, 200)
                NewMenu1.TextSize = 14.000
                NewMenu1.TextWrapped = true
                
                NewMenubg.Name = "bg"
                NewMenubg.Parent = NewMenu1
                NewMenubg.Active = true
                NewMenubg.AnchorPoint = Vector2.new(0.5, 0.5)
                NewMenubg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NewMenubg.BackgroundTransparency = 1.000
                NewMenubg.Position = UDim2.new(0.5, 0, 0.5, 0)
                NewMenubg.Selectable = true
                NewMenubg.Size = UDim2.new(1, 0, 1, 0)
                NewMenubg.ZIndex = settings.ZIndex+4
                NewMenubg.Image = "rbxassetid://3570695787"
                NewMenubg.ImageColor3 = Color3.fromRGB(30, 30, 30)
                NewMenubg.ScaleType = Enum.ScaleType.Slice
                NewMenubg.SliceCenter = Rect.new(100, 100, 100, 100)
                NewMenubg.SliceScale = 0.080

                Menu1_2.Name = "tab "..mijntabid -- btns
                Menu1_2.Parent = NewMenu
                Menu1_2.Active = true
                if tabnum > 1 then Menu1_2.Visible = false else activetab = NewMenu end
                Menu1_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Menu1_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Menu1_2.BackgroundTransparency = 1.000
                Menu1_2.BorderSizePixel = 0
                Menu1_2.Position = UDim2.new(0.57, 0, 0.5, 0)
                Menu1_2.Size = UDim2.new(0, 640, 0, 248)
                Menu1_2.ZIndex = settings.ZIndex+1
                Menu1_2.CanvasSize = UDim2.new(0, 0, 0, 0)
                Menu1_2.ScrollBarThickness = 3
                Menu1_2.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

                UIGridLayout_4.Parent = Menu1_2
                UIGridLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout_4.CellPadding = UDim2.new(0, 5, 0, 2)
                UIGridLayout_4.CellSize = UDim2.new(1, 0, 0, 45)
            end

            function lib3:CreateButton(fsettings,callback)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateButton> must be table type");return end
                callback = callback or function() end
                counters['buttons'] = counters['buttons'] + 1

                local save = {num=counters['buttons']}
                local toapply = {name="Button name",desc=""}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateButton ("..save['num']..")>")
                    end
                end

                local Button = Instance.new("TextButton")
                 local bg_4 = Instance.new("ImageLabel")
                 local title = Instance.new("TextLabel")
                 local icon = Instance.new("ImageButton")

                do 
                    Button.Name = "Button"..save['num']
                    Button.Parent = Menu1_2
                    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Button.BackgroundTransparency = 1.000
                    Button.BorderSizePixel = 0
                    Button.Size = UDim2.new(0, 200, 0, 50)
                    Button.ZIndex = settings.ZIndex+3
                    Button.Font = Enum.Font.Ubuntu
                    Button.Text = ""
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 16.000

                    bg_4.Name = "bg"
                    bg_4.Parent = Button
                    bg_4.Active = true
                    bg_4.AnchorPoint = Vector2.new(0.5, 0.5)
                    bg_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bg_4.BackgroundTransparency = 1.000
                    bg_4.Position = UDim2.new(0.5, 0, 0.5, 0)
                    bg_4.Selectable = true
                    bg_4.Size = UDim2.new(1, 0, 1, 0)
                    bg_4.ZIndex = settings.ZIndex+1
                    bg_4.Image = "rbxassetid://3570695787"
                    bg_4.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    bg_4.ScaleType = Enum.ScaleType.Slice
                    bg_4.SliceCenter = Rect.new(100, 100, 100, 100)
                    bg_4.SliceScale = 0.080

                    title.Name = "title"
                    title.Parent = Button
                    title.AnchorPoint = Vector2.new(0.5, 0.5)
                    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title.BackgroundTransparency = 1.000
                    title.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title.Size = UDim2.new(0.88, 0, 0.86, 0)
                    title.ZIndex = settings.ZIndex+2
                    title.Font = Enum.Font.Ubuntu
                    title.Text = toapply['name']
                    title.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title.TextSize = 20.000
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    icon.Name = "icon"
                    icon.Parent = Button
                    icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    icon.BackgroundTransparency = 1.000
                    icon.LayoutOrder = 9
                    icon.Position = UDim2.new(0.032, 0, 0.505, 0)
                    icon.Size = UDim2.new(0, 25, 0, 25)
                    icon.ZIndex = settings.ZIndex+2
                    icon.Image = "rbxassetid://3926305904"
                    icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
                    icon.ImageRectOffset = Vector2.new(84, 204)
                    icon.ImageRectSize = Vector2.new(36, 36)

                end

                local info = tipgen(Button,toapply['desc'])

                do
                    -- save col
                    local c = toRGB(bg_4.ImageColor3)

                    -- main func
                    local db = false
                    local click_count = 0
                    local isutingthis = false
                    Button.MouseButton1Up:Connect(function()
                        if not isutingthis then return end
                        isutingthis = false
                        if isonbtn then 
                            TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.button.ratio,c.G+settings.cm.button.ratio,c.B+settings.cm.button.ratio)}):Play()
                            TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play() 
                            TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
                        end
                        click_count = click_count + 1
                        if db then return end
                        db = true
                        pcall(callback,click_count)
                        db = false
                    end)
                
                    -- visual
                    Button.MouseButton1Down:Connect(function()
                        isutingthis = true
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.cm.button.ratio,c.G-settings.cm.button.ratio,c.B-settings.cm.button.ratio)}):Play()
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(150,150,150)}):Play() 
                    
                    end)
                    Button.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.button.ratio,c.G+settings.cm.button.ratio,c.B+settings.cm.button.ratio)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                    
                    end)
                    Button.MouseLeave:Connect(function()
                        isonbtn = false
                        isutingthis = false
                        if islistopened then return end
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                    
                    end)

                    local llib = {}
                    function llib:ResetClick()
                        click_count = 0

                    end

                    return llib
                end
            end
            function lib3:CreateToggle(fsettings,callback)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateToggle> must be table type");return end
                callback = callback or function() end
                counters['toggles'] = counters['toggles'] + 1

                local save = {num=counters['toggles']}
                local toapply = {name="Toggle name",exec=false,desc="",state=false}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    elseif k == 'state' then
                        if type(v) == "boolean" then
                            toapply['state'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateToggle ("..save['num']..")>") end
                    elseif k == 'exec' then
                        if type(v) == "boolean" then
                            toapply['exec'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateToggle ("..save['num']..")>") end
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateToggle ("..save['num']..")>")
                    end
                end

                local Toggle = Instance.new("TextButton") -- toggle func
                local bg_5 = Instance.new("ImageLabel")
                local title_2 = Instance.new("TextLabel")
                local state = Instance.new("ImageButton")
                do
                    Toggle.Name = "Toggle"
                    Toggle.Parent = Menu1_2
                    Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Toggle.BackgroundTransparency = 1.000
                    Toggle.BorderSizePixel = 0
                    Toggle.Size = UDim2.new(0, 200, 0, 50)
                    Toggle.ZIndex = settings.ZIndex+3
                    Toggle.Font = Enum.Font.Ubuntu
                    Toggle.Text = ""
                    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Toggle.TextSize = 16.000

                    bg_5.Name = "bg"
                    bg_5.Parent = Toggle
                    bg_5.Active = true
                    bg_5.AnchorPoint = Vector2.new(0.5, 0.5)
                    bg_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bg_5.BackgroundTransparency = 1.000
                    bg_5.Position = UDim2.new(0.5, 0, 0.5, 0)
                    bg_5.Selectable = true
                    bg_5.Size = UDim2.new(1, 0, 1, 0)
                    bg_5.ZIndex = settings.ZIndex+1
                    bg_5.Image = "rbxassetid://3570695787"
                    bg_5.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    bg_5.ScaleType = Enum.ScaleType.Slice
                    bg_5.SliceCenter = Rect.new(100, 100, 100, 100)
                    bg_5.SliceScale = 0.080

                    title_2.Name = "title"
                    title_2.Parent = Toggle
                    title_2.AnchorPoint = Vector2.new(0.5, 0.5)
                    title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title_2.BackgroundTransparency = 1.000
                    title_2.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title_2.Size = UDim2.new(0.88, 0, 0.86, 0)
                    title_2.ZIndex = settings.ZIndex+2
                    title_2.Font = Enum.Font.Ubuntu
                    title_2.Text = toapply.name
                    title_2.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title_2.TextSize = 20.000
                    title_2.TextXAlignment = Enum.TextXAlignment.Left

                    state.Name = "state"
                    state.Parent = Toggle
                    state.AnchorPoint = Vector2.new(0.5, 0.5)
                    state.BackgroundTransparency = 1.000
                    state.LayoutOrder = 8
                    state.Position = UDim2.new(0.032, 0, 0.505, 0)
                    if not toapply['state'] then state.Rotation = 180 else state.Rotation = 0 end
                    state.Size = UDim2.new(0, 20, 0, 20)
                    state.ZIndex = settings.ZIndex+2
                    state.Image = "rbxassetid://3926305904"
                    if not toapply['state'] then state.ImageColor3 = Color3.fromRGB(150, 0, 0) else state.ImageColor3 = Color3.fromRGB(0, 150, 0) end
                    state.ImageRectOffset = Vector2.new(324, 244)
                    state.ImageRectSize = Vector2.new(36, 36)
                end
                
                local info = tipgen(Toggle,toapply.desc)

                do
                    if toapply["exec"] then pcall(callback,toapply['state']) end
                    -- main func
                    local db = false
                    local toggle_state = toapply['state']
                    local c = toRGB(bg_5.ImageColor3)
                    local isutingthis = false
                    Toggle.MouseButton1Up:Connect(function()
                        if not isutingthis then return end
                        isutingthis = false
                        if db then return end
                        db = true
                        toggle_state = not toggle_state
                        pcall(callback,toggle_state)
                        local r = 0
                        if not toggle_state then r = 180 end
                        TweenService:Create(state,TweenInfo.new(.25),{Rotation = r}):Play()
                        if isonbtn then 
                            local cc = Color3.fromRGB(0, 255, 0)
                            if not toggle_state then cc = Color3.fromRGB(255, 0, 0) end
                            TweenService:Create(bg_5,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.toggle.ratio,c.G+settings.cm.toggle.ratio,c.B+settings.cm.toggle.ratio)}):Play()
                            TweenService:Create(title_2,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play() 
                            TweenService:Create(state,TweenInfo.new(.25),{ImageColor3 = cc}):Play()
                        
                        else
                            local cc = Color3.fromRGB(0, 200, 0)
                            if not toggle_state then cc = Color3.fromRGB(200, 0, 0) end
                            TweenService:Create(bg_5,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                            TweenService:Create(title_2,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200,200,200)}):Play() 
                            TweenService:Create(state,TweenInfo.new(.25),{ImageColor3 = cc}):Play()

                        end
                        db = false
                    end)
                
                    -- visual
                    Toggle.MouseButton1Down:Connect(function()
                        isutingthis = true
                        TweenService:Create(bg_5,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.cm.toggle.ratio,c.G-settings.cm.toggle.ratio,c.B-settings.cm.toggle.ratio)}):Play()
                        TweenService:Create(title_2,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                        local cc = Color3.fromRGB(0, 150, 0)
                        if not toggle_state then cc = Color3.fromRGB(150, 0, 0) end
                        TweenService:Create(state,TweenInfo.new(.25),{ImageColor3 = cc}):Play()
                    
                    end)
                    Toggle.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        TweenService:Create(title_2,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(bg_5,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.toggle.ratio,c.G+settings.cm.toggle.ratio,c.B+settings.cm.toggle.ratio)}):Play()
                        local cc = Color3.fromRGB(0, 255, 0)
                        if not toggle_state then cc = Color3.fromRGB(255, 0, 0) end
                        TweenService:Create(state,TweenInfo.new(.25),{ImageColor3 = cc}):Play()
                    
                    end)
                    Toggle.MouseLeave:Connect(function()
                        isonbtn = false
                        isutingthis = false
                        if islistopened then return end
                        TweenService:Create(title_2,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(bg_5,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                        local cc = Color3.fromRGB(0, 150, 0)
                        if not toggle_state then cc = Color3.fromRGB(150, 0, 0) end
                        TweenService:Create(state,TweenInfo.new(.25),{ImageColor3 = cc}):Play()
                    
                    end)
                end
            end
            function lib3:CreateInput(fsettings,callback)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateInput> must be table type");return end
                callback = callback or function() end
                counters['inputs'] = counters['inputs'] + 1

                local save = {num=counters['inputs']}
                local toapply = {name="Input name",desc="",ac={nil,""}}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    elseif table.find({'ac','autocomplete'},k) then
                        local resp,err = pcall(function() toapply['ac'][1] = v[1];toapply['ac'][2] = v[2] end)
                        if not resp then warn("["..menu_name.."-"..tab_name.."] ~ "..err) end
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateInput ("..save['num']..")>")
                    end
                end

                local Input = Instance.new("TextBox")
                 local acorr = Instance.new("TextLabel")
                 local bgl = Instance.new("ImageLabel")
                 local title = Instance.new("TextLabel")
                 local icon = Instance.new("ImageButton")
                 local savetxt = Instance.new("ImageButton")

                do
                    Input.Name = "Input"
                    Input.Parent = Menu1_2
                    Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Input.BackgroundTransparency = 1.000
                    Input.BorderSizePixel = 0
                    Input.Size = UDim2.new(0, 200, 0, 50)
                    Input.ZIndex = settings.ZIndex+5
                    Input.Font = Enum.Font.Ubuntu
                    Input.Text = ""
                    Input.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Input.TextTransparency = 1
                    Input.ClearTextOnFocus = false
                    Input.TextSize = 20.000
                    Input.Font = Enum.Font.Ubuntu

                    bgl.Name = "bg"
                    bgl.Parent = Input
                    bgl.Active = true
                    bgl.AnchorPoint = Vector2.new(0.5, 0.5)
                    bgl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bgl.BackgroundTransparency = 1.000
                    bgl.Position = UDim2.new(0.5, 0, 0.5, 0)
                    bgl.Selectable = true
                    bgl.Size = UDim2.new(1, 0, 1, 0)
                    bgl.ZIndex = settings.ZIndex+3
                    bgl.Image = "rbxassetid://3570695787"
                    bgl.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    bgl.ScaleType = Enum.ScaleType.Slice
                    bgl.SliceCenter = Rect.new(100, 100, 100, 100)
                    bgl.SliceScale = 0.080

                    title.Name = "title"
                    title.Parent = Input
                    title.AnchorPoint = Vector2.new(0.5, 0.5)
                    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title.BackgroundTransparency = 1.000
                    title.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title.Size = UDim2.new(0.88, 0, 0.86, 0)
                    title.ZIndex = settings.ZIndex+4
                    title.Font = Enum.Font.Ubuntu
                    title.Text = toapply['name']
                    title.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title.TextSize = 20.000
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    acorr.Name = "autocorrect_text"
                    acorr.Parent = Input
                    acorr.AnchorPoint = Vector2.new(0.5, 0.5)
                    acorr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    acorr.BackgroundTransparency = 1.000
                    acorr.Position = UDim2.new(0.5, 0, 0.5, 0)
                    acorr.Size = UDim2.new(0.88, 0, 0.86, 0)
                    acorr.ZIndex = settings.ZIndex+4
                    acorr.Font = Enum.Font.Ubuntu
                    acorr.Text = ""
                    acorr.TextTransparency = 1
                    acorr.TextColor3 = Color3.fromRGB(125, 125, 125)
                    acorr.TextSize = 20.000
                    acorr.TextXAlignment = Enum.TextXAlignment.Left

                    icon.Name = "icon"
                    icon.Parent = Input
                    icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    icon.BackgroundTransparency = 1.000
                    icon.Position = UDim2.new(0.03125, 0, 0.5, 0)
                    icon.Size = UDim2.new(0, 25, 0, 25)
                    icon.ZIndex = settings.ZIndex+5
                    icon.Image = "rbxassetid://3926305904"
                    icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
                    icon.ImageRectOffset = Vector2.new(284, 644)
                    icon.ImageRectSize = Vector2.new(36, 36)

                    savetxt.Name = "istxtsaves?"
                    savetxt.Parent = icon
                    savetxt.AnchorPoint = Vector2.new(0.5, 0.5)
                    savetxt.BackgroundTransparency = 1.000
                    savetxt.Position = UDim2.new(0.35, 0, 0.2, 0)
                    savetxt.Rotation = -45.000
                    savetxt.Size = UDim2.new(0, 18, 0, 18)
                    savetxt.ZIndex = settings.ZIndex+3
                    savetxt.Image = "rbxassetid://3926305904"
                    savetxt.ImageRectOffset = Vector2.new(164, 404)
                    savetxt.ImageColor3 = Color3.fromRGB(150, 150, 150)
                    savetxt.ImageRectSize = Vector2.new(36, 36)

                end

                local info = tipgen(Input,toapply['desc'])

                do
                    -- save col
                    local c = toRGB(bgl.ImageColor3)

                    -- main func
                    local iswriting = false
                    local isonbtn = false
                    local Inputwriting;
                    local tabtocomplete;
                    Input.Focused:Connect(function()
                        iswriting = true
                        TweenService:Create(title,TweenInfo.new(.1),{TextTransparency = 1}):Play()
                        TweenService:Create(acorr,TweenInfo.new(.1),{TextTransparency = 0}):Play()
                        acorr.Text = ""
                        TweenService:Create(Input,TweenInfo.new(.1),{TextTransparency = 0}):Play()
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.input.ratio,c.G+settings.cm.input.ratio,c.B+settings.cm.input.ratio)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                        
                        local isacwork = true
                        if toapply['ac'][1] ~= nil then -- autocomplete
                            spawn(function()
                                Inputwriting = UIS.InputBegan:Connect(function(_,isonInp)
                                    if string.len(Input.Text) >= 2 then
                                        if isonInp and iswriting and isacwork then
                                            for i,v in pairs(toapply['ac'][1]) do -- instace table
                                                for q,w in pairs(toapply['ac'][2]) do -- vars from instance to check
                                                    if string.find(v[w]:lower(),Input.Text:lower()) then
                                                        acorr.Text = v[w]
                                                        pcall(function() tabtocomplete:Disconnect() end)
                                                        tabtocomplete = UIS.InputBegan:Connect(function(ayo)
                                                            if ayo.KeyCode.Name == "Tab" then
                                                                isacwork = false
                                                                wait(0.1)
                                                                Input.Text = acorr.Text
                                                                tabtocomplete:Disconnect()
                                                                isacwork = true

                                                            end

                                                        end)

                                                    end

                                                end

                                            end

                                        end

                                    else acorr.Text = "" end

                                end)

                            end)

                        end

                    end)
                    
                    local idb = false
                    icon.MouseButton1Click:Connect(function()
                        if idb then return end
                        idb = true
                        Input.ClearTextOnFocus = not Input.ClearTextOnFocus
                        if Input.ClearTextOnFocus then
                            TweenService:Create(savetxt,TweenInfo.new(.25),{ImageTransparency = 1}):Play()
                            TweenService:Create(savetxt,TweenInfo.new(.25),{Position = UDim2.new(0.55, 0, 0, 0)}):Play()

                        else
                            TweenService:Create(savetxt,TweenInfo.new(.25),{ImageTransparency = 0}):Play()
                            TweenService:Create(savetxt,TweenInfo.new(.20),{Position = UDim2.new(0.35, 0, 0.2, 0)}):Play()

                        end
                        wait(.25)
                        idb = false

                    end)

                    Input.FocusLost:Connect(function(_)
                        iswriting = false
                        pcall(function() Inputwriting:Disconnect() end); pcall(function() tabtocomplete:Disconnect() end)
                        TweenService:Create(title,TweenInfo.new(.1),{TextTransparency = 0}):Play()
                        TweenService:Create(acorr,TweenInfo.new(.1),{TextTransparency = 1}):Play()
                        TweenService:Create(Input,TweenInfo.new(.1),{TextTransparency = 1}):Play()
                        if isonbtn then 
                            TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                            TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.input.ratio,c.G+settings.cm.input.ratio,c.B+settings.cm.input.ratio)}):Play()
                            TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                        else
                            TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                            TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                            TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                        end
                        if not _ then return end
                        pcall(callback,Input.Text)
                    
                    end)
                    Input.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        if iswriting then return end
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.input.ratio,c.G+settings.cm.input.ratio,c.B+settings.cm.input.ratio)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                    
                    end)
                    Input.MouseLeave:Connect(function()
                        isonbtn = false
                        if islistopened then return end
                        if iswriting then return end
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                    
                    end)
                end

            end
            function lib3:CreateSlider(fsettings,callback)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateSlider> must be table type");return end
                callback = callback or function() end
                counters['sliders'] = counters['sliders'] + 1

                local save = {num=counters['sliders']}
                local toapply = {name="Slider name",exec=false,desc="",min=0,def=50,max=100}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    elseif table.find({'min','minimum'},k) then
                        if tonumber(v) then toapply['min'] = tonumber(v) 
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"int type\" in <CreateSlider ("..save['num']..")>") end
                    elseif table.find({'def','default',"start"},k) then
                        if tonumber(v) then toapply['def'] = tonumber(v) 
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"int type\" in <CreateSlider ("..save['num']..")>") end
                    elseif table.find({'max','maximum'},k) then
                        if tonumber(v) then toapply['max'] = tonumber(v) 
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"int type\" in <CreateSlider ("..save['num']..")>") end
                    elseif k == 'exec' then
                        if type(v) == "boolean" then
                            toapply['exec'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateSlider ("..save['num']..")>") end
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateSlider ("..save['num']..")>")
                    end
                end
                if toapply["min"] >= toapply["max"] then 
                    toapply["min"] = toapply["min"] - toapply["max"] 
                    warn("["..menu_name.."-"..tab_name.."] ~ Incorrect value set in \"min\", new value is: "..toapply['min']..", <CreateSlider ("..save['num']..")>")
                end
                if toapply['def'] < toapply["min"] or toapply['def'] > toapply["max"] then
                    toapply['def'] = toapply["min"] 
                    warn("["..menu_name.."-"..tab_name.."] ~ Incorrect value set in \"def\", new value is: "..toapply['def']..", <CreateSlider ("..save['num']..")>")
                end

                local Slider = Instance.new("TextButton")
                 local lbg = Instance.new("ImageLabel")
                 local title = Instance.new("TextLabel")
                 local int = Instance.new("TextLabel")
                 local icon = Instance.new("ImageButton")
                 local slider = Instance.new("TextButton")
                  local bg_2 = Instance.new("ImageLabel")

                do 
                    Slider.Name = "Slider"..save['num']
                    Slider.Parent = Menu1_2
                    Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Slider.BackgroundTransparency = 1.000
                    Slider.BorderSizePixel = 0
                    Slider.Size = UDim2.new(0, 200, 0, 50)
                    Slider.ZIndex = settings.ZIndex+3
                    Slider.Font = Enum.Font.Ubuntu
                    Slider.Text = ""
                    Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Slider.TextSize = 16.000

                    lbg.Name = "bg"
                    lbg.Parent = Slider
                    lbg.Active = true
                    lbg.AnchorPoint = Vector2.new(0.5, 0.5)
                    lbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    lbg.BackgroundTransparency = 1.000
                    lbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                    lbg.Selectable = true
                    lbg.Size = UDim2.new(1, 0, 1, 0)
                    lbg.ZIndex = settings.ZIndex+1
                    lbg.Image = "rbxassetid://3570695787"
                    lbg.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    lbg.ScaleType = Enum.ScaleType.Slice
                    lbg.SliceCenter = Rect.new(100, 100, 100, 100)
                    lbg.SliceScale = 0.080

                    title.Name = "title"
                    title.Parent = Slider
                    title.AnchorPoint = Vector2.new(0.5, 0.5)
                    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title.BackgroundTransparency = 1.000
                    title.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title.Size = UDim2.new(0.88, 0, 0.86, 0)
                    title.ZIndex = settings.ZIndex+2
                    title.Font = Enum.Font.Ubuntu
                    title.Text = toapply['name']
                    title.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title.TextSize = 20.000
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    int.Name = "int"
                    int.Parent = Slider
                    int.AnchorPoint = Vector2.new(0.5, 0.5)
                    int.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    int.BackgroundTransparency = 1.000
                    int.Position = UDim2.new(0.5, 0, 0.5, 0)
                    int.Size = UDim2.new(0.88, 0, 0.86, 0)
                    int.ZIndex = settings.ZIndex+2
                    int.Font = Enum.Font.Ubuntu
                    int.Text = toapply['def']
                    int.TextTransparency = 1
                    int.TextColor3 = Color3.fromRGB(200, 200, 200)
                    int.TextSize = 20.000
                    int.TextXAlignment = Enum.TextXAlignment.Left
                    
                    icon.Name = "icon"
                    icon.Parent = Slider
                    icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    icon.BackgroundTransparency = 1.000
                    icon.Position = UDim2.new(0.03125, 0, 0.5, 0)
                    icon.Size = UDim2.new(0, 25, 0, 25)
                    icon.ZIndex = settings.ZIndex+2
                    icon.Image = "rbxassetid://3926305904"
                    icon.ImageColor3 = Color3.fromRGB(200,200,200)
                    icon.ImageRectOffset = Vector2.new(684, 364)
                    icon.ImageRectSize = Vector2.new(36, 36)

                    slider.Name = "slider"
                    slider.Parent = lbg
                    slider.AnchorPoint = Vector2.new(0.5, 0.5)
                    slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    slider.BackgroundTransparency = 1.000
                    slider.ClipsDescendants = true
                    slider.Position = UDim2.new(0.5, 0, 0.5, 0)
                    slider.Size = UDim2.new(1, 0, 1, 0)
                    slider.ZIndex = settings.ZIndex+3
                    slider.Font = Enum.Font.SourceSans
                    slider.Text = ""
                    slider.TextColor3 = Color3.fromRGB(0, 0, 0)
                    slider.TextSize = 14.000
                    
                    bg_2.Name = "bg"
                    bg_2.Parent = slider
                    bg_2.Active = true
                    bg_2.AnchorPoint = Vector2.new(0, 0.5)
                    bg_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bg_2.BackgroundTransparency = 1.000
                    bg_2.Position = UDim2.new(0, 0, 0.5, 0)
                    bg_2.Selectable = true
                    bg_2.Size = UDim2.new(0, 640, 1, 0)
                    bg_2.ZIndex = settings.ZIndex+2
                    bg_2.Image = "rbxassetid://3570695787"
                    bg_2.ImageColor3 = Color3.fromRGB(13, 13, 13)
                    bg_2.ImageTransparency = 0.500
                    bg_2.ScaleType = Enum.ScaleType.Slice
                    bg_2.SliceCenter = Rect.new(100, 100, 100, 100)
                    bg_2.SliceScale = 0.080
                end

                local info = tipgen(Slider,toapply['desc'])

                do
                    -- save col
                    local c = toRGB(lbg.ImageColor3)
                        
                    -- main func
                    local mouse = game.Players.LocalPlayer:GetMouse()
                    local Value = toapply['def']
                    local OldValue = toapply['min']
                    local ispressed = false
                    local isonbtn = false
                    spawn(function()
                        TweenService:Create(bg_2,TweenInfo.new(.1),{Size = UDim2.new(0, 320, 1, 0)}):Play()
                        wait(.11)
                        Value = toapply['def']
                        pcall(function()
                            int.Text = Value
                            OldValue = Value
                            if toapply["exec"] then pcall(callback,Value) end
                        end)
                    end)
                    slider.MouseButton1Down:Connect(function()
                        ispressed = true
                        if isonbtn then 
                            TweenService:Create(int,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                            TweenService:Create(lbg,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.slider.ratio,c.G+settings.cm.slider.ratio,c.B+settings.cm.slider.ratio)}):Play()
                            TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
    
                            TweenService:Create(title,TweenInfo.new(.25),{TextTransparency = 1}):Play()
                            TweenService:Create(int,TweenInfo.new(.25),{TextTransparency = 0}):Play()
                        end
                        spawn(function()
                            TweenService:Create(bg_2,TweenInfo.new(.1),{Size = UDim2.new(0, math.clamp(mouse.X - bg_2.AbsolutePosition.X, 0, 640), 1, 0)}):Play()
                            wait(.11)
                            Value = math.floor((((tonumber(toapply['max']) - tonumber(toapply['min'])) / 640) * bg_2.AbsoluteSize.X) + tonumber(toapply['min']))
                            pcall(function()
                                if Value == OldValue then return end
                                int.Text = Value
                                OldValue = Value
                                pcall(callback,Value)
                            end)
                        end)
                        moveconnection = mouse.Move:Connect(function()
                            Value = math.floor((((tonumber(toapply['max']) - tonumber(toapply['min'])) / 640) * bg_2.AbsoluteSize.X) + tonumber(toapply['min']))
                            pcall(function()
                                if Value == OldValue then return end
                                int.Text = Value
                                OldValue = Value
                                pcall(callback,Value)
                            end)
                            TweenService:Create(bg_2,TweenInfo.new(.1),{Size = UDim2.new(0, math.clamp(mouse.X - bg_2.AbsolutePosition.X, 0, 640), 1, 0)}):Play()
                        end)
                        releaseconnection = UIS.InputEnded:Connect(function(Mouse)
                            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                Value = math.floor((((tonumber(toapply['max']) - tonumber(toapply['min'])) / 640) * bg_2.AbsoluteSize.X) + tonumber(toapply['min']))
                                pcall(function()
                                    if Value == OldValue then return end
                                    int.Text = Value
                                    OldValue = Value
                                    pcall(callback,Value)
                                end)
                                TweenService:Create(bg_2,TweenInfo.new(.1),{Size = UDim2.new(0, math.clamp(mouse.X - bg_2.AbsolutePosition.X, 0, 640), 1, 0)}):Play()
                                moveconnection:Disconnect()
                                releaseconnection:Disconnect()
                                if not isonbtn then
                                    TweenService:Create(lbg,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                                    TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                                    TweenService:Create(int,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200,200,200)}):Play()
        
                                    TweenService:Create(title,TweenInfo.new(.25),{TextTransparency = 0}):Play()
                                    TweenService:Create(int,TweenInfo.new(.25),{TextTransparency = 1}):Play()
                                end
                                ispressed = false
                            end
                        end)
                    end)
                    slider.MouseButton2Click:Connect(function()
                        pcall(function()
                            if toapply['def'] == OldValue then return end
                            TweenService:Create(bg_2,TweenInfo.new(.1),{Size = UDim2.new(0, 320, 1, 0)}):Play()
                            int.Text = toapply['def']
                            OldValue = toapply['def']
                            pcall(callback,toapply['def'])
                        end)
                    end)

                    slider.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        if ispressed then return end
                        TweenService:Create(int,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(lbg,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.slider.ratio,c.G+settings.cm.slider.ratio,c.B+settings.cm.slider.ratio)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 

                        TweenService:Create(title,TweenInfo.new(.25),{TextTransparency = 1}):Play()
                        TweenService:Create(int,TweenInfo.new(.25),{TextTransparency = 0}):Play()
                    
                    end)
                    slider.MouseLeave:Connect(function()
                        isonbtn = false
                        if islistopened then return end
                        if ispressed then return end
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        TweenService:Create(int,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(lbg,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()

                        TweenService:Create(title,TweenInfo.new(.25),{TextTransparency = 0}):Play()
                        TweenService:Create(int,TweenInfo.new(.25),{TextTransparency = 1}):Play()
                    
                    end)
                end
            end
            function lib3:CreateBind(fsettings,callback)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateBind> must be table type");return end
                callback = callback or function() end
                counters['binds'] = counters['binds'] + 1

                local save = {num=counters['binds']}
                local toapply = {name="Bind name",desc="",key="*",loop=false}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    elseif table.find({'key','bind'},k) then
                        toapply['key'] = tostring(v)
                    elseif table.find({'loop','looping'},k) then
                        if type(v) == "boolean" then toapply['loop'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateBind ("..save['num']..")>") end
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateBind ("..save['num']..")>")
                    end
                end

                local Bind = Instance.new("TextButton")
                 local bgl = Instance.new("ImageLabel")
                 local title = Instance.new("TextLabel")
                 local KeyBg = Instance.new("ImageLabel")
                  local Key = Instance.new("TextLabel")

                do 
                    Bind.Name = "Button"..save['num']
                    Bind.Parent = Menu1_2
                    Bind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Bind.BackgroundTransparency = 1.000
                    Bind.BorderSizePixel = 0
                    Bind.Size = UDim2.new(0, 200, 0, 50)
                    Bind.ZIndex = settings.ZIndex+3
                    Bind.Font = Enum.Font.Ubuntu
                    Bind.Text = ""
                    Bind.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Bind.TextSize = 16.000

                    bgl.Name = "bg"
                    bgl.Parent = Bind
                    bgl.Active = true
                    bgl.AnchorPoint = Vector2.new(0.5, 0.5)
                    bgl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bgl.BackgroundTransparency = 1.000
                    bgl.Position = UDim2.new(0.5, 0, 0.5, 0)
                    bgl.Selectable = true
                    bgl.Size = UDim2.new(1, 0, 1, 0)
                    bgl.ZIndex = settings.ZIndex+1
                    bgl.Image = "rbxassetid://3570695787"
                    bgl.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    bgl.ScaleType = Enum.ScaleType.Slice
                    bgl.SliceCenter = Rect.new(100, 100, 100, 100)
                    bgl.SliceScale = 0.080

                    title.Name = "title"
                    title.Parent = Bind
                    title.AnchorPoint = Vector2.new(0.5, 0.5)
                    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title.BackgroundTransparency = 1.000
                    title.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title.Size = UDim2.new(0.879999995, 0, 0.860000014, 0)
                    title.ZIndex = settings.ZIndex+2
                    title.Font = Enum.Font.Ubuntu
                    title.Text = toapply['name']
                    title.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title.TextSize = 20.000
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    KeyBg.Name = "KeyBg"
                    KeyBg.Parent = Bind
                    KeyBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    KeyBg.BackgroundTransparency = 1.000
                    KeyBg.Position = UDim2.new(0.0109374998, 0, 0.222222224, 0)
                    KeyBg.Size = UDim2.new(0, 25, 0, 25)
                    KeyBg.ZIndex = settings.ZIndex+2
                    KeyBg.Image = "rbxassetid://3570695787"
                    KeyBg.ImageColor3 = Color3.fromRGB(15, 15, 15)
                    KeyBg.ScaleType = Enum.ScaleType.Slice
                    KeyBg.SliceCenter = Rect.new(100, 100, 100, 100)
                    KeyBg.SliceScale = 0.080
                    
                    Key.Name = "Key"
                    Key.Parent = KeyBg
                    Key.AnchorPoint = Vector2.new(0.5, 0.5)
                    Key.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Key.BackgroundTransparency = 1.000
                    Key.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Key.Size = UDim2.new(0.98, 0, 0.98, 0)
                    Key.ZIndex = settings.ZIndex+2
                    Key.Font = Enum.Font.Ubuntu
                    Key.Text = toapply['key']
                    Key.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Key.TextSize = 20.000

                end

                local info = tipgen(Bind,toapply['desc'])

                do
                    -- save col
                    local c = toRGB(bgl.ImageColor3)

                    -- main func
                    local bind_tick = 0
                    local iskeychangin = false
                    local islooping = false
                    local oldkey = toapply['key']
                    local isutingthis = false
                    Bind.MouseButton1Up:Connect(function() -- keybind change
                        if not isutingthis then return end
                        isutingthis = false
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                        if isonbtn then 
                            TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.bind.ratio,c.G+settings.cm.bind.ratio,c.B+settings.cm.bind.ratio)}):Play()
                            TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play() 
                        end
                        iskeychangin = true
                        Key.Text = "?"
                        title.Text = "Backspace to remove"
                    end)
                
                    getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"][menu_name]["Binds"]["Bind"..save['num']] = UIS.InputBegan:Connect(function(key, enter)
                        if enter then return end
                        if toapply['loop'] then islooping = true end
                        if iskeychangin then
                            if key.KeyCode == Enum.KeyCode.Unknown then
                                Key.Text = oldkey
                                title.Text = toapply['name']
                                iskeychangin = false
                            elseif key.KeyCode == Enum.KeyCode.Backspace then
                                Key.Text = "*"
                                title.Text = toapply['name']
                                oldkey = "*"
                                iskeychangin = false
                            else
                                Key.Text = key.KeyCode.Name
                                title.Text = toapply['name']
                                oldkey = key.KeyCode.Name
                                iskeychangin = false
                            end
                        elseif key.KeyCode.Name == Key.Text then 
                            bind_tick = 0
                            spawn(function() 
                                while wait() do
                                    bind_tick = bind_tick + 1
                                    pcall(callback, key.KeyCode.Name, bind_tick)
                                    if not islooping then break end 
                                end
                            end)
                        end
                    end)
                    getgenv().GreenCumLoaderHorseBabyUhhHello["Menus"][menu_name]["Binds"]["LBind"..save['num']] = UIS.InputEnded:Connect(function(key, enter)
                        if enter and toapply['loop'] then return end
                        if key.KeyCode.Name == Key.Text then 
                            islooping = false
                        end
                    end)
                    -- visual
                    Bind.MouseButton1Down:Connect(function()
                        isutingthis = true
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.cm.bind.ratio,c.G-settings.cm.bind.ratio,c.B-settings.cm.bind.ratio)}):Play()
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                    
                    end)
                    Bind.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.bind.ratio,c.G+settings.cm.bind.ratio,c.B+settings.cm.bind.ratio)}):Play()
                    
                    end)
                    Bind.MouseLeave:Connect(function()
                        isonbtn = false
                        isutingthis = false
                        if islistopened then return end
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(bgl,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                    
                    end)

                end
            end
            function lib3:CreateLabel(fsettings)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateLabel> must be table type");return end
                callback = callback or function() end
                counters['labels'] = counters['labels'] + 1

                local save = {num=counters['labels']}
                local toapply = {name="Label name",desc="",exec=false,clip=""}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    elseif table.find({'clip','clipboard','copy'},k) then
                        toapply['clip'] = tostring(v)
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateLabel ("..save['num']..")>")
                    end
                end

                local Label = Instance.new("TextButton")
                 local bg_4 = Instance.new("ImageLabel")
                 local title = Instance.new("TextLabel")
                 local acorr = Instance.new("TextBox")
                 local icon = Instance.new("ImageButton")

                do 
                    Label.Name = "Label"..save['num']
                    Label.Parent = Menu1_2
                    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Label.BackgroundTransparency = 1.000
                    Label.BorderSizePixel = 0
                    Label.Size = UDim2.new(0, 200, 0, 50)
                    Label.ZIndex = settings.ZIndex+3
                    Label.Font = Enum.Font.Ubuntu
                    Label.Text = ""
                    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Label.TextSize = 16.000

                    bg_4.Name = "bg"
                    bg_4.Parent = Label
                    bg_4.Active = true
                    bg_4.AnchorPoint = Vector2.new(0.5, 0.5)
                    bg_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bg_4.BackgroundTransparency = 1.000
                    bg_4.Position = UDim2.new(0.5, 0, 0.5, 0)
                    bg_4.Selectable = true
                    bg_4.Size = UDim2.new(1, 0, 1, 0)
                    bg_4.ZIndex = settings.ZIndex+1
                    bg_4.Image = "rbxassetid://3570695787"
                    bg_4.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    bg_4.ScaleType = Enum.ScaleType.Slice
                    bg_4.SliceCenter = Rect.new(100, 100, 100, 100)
                    bg_4.SliceScale = 0.080

                    title.Name = "title"
                    title.Parent = Label
                    title.AnchorPoint = Vector2.new(0.5, 0.5)
                    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title.BackgroundTransparency = 1.000
                    title.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title.Size = UDim2.new(0.88, 0, 0.86, 0)
                    title.ZIndex = settings.ZIndex+2
                    title.Font = Enum.Font.Ubuntu
                    title.Text = toapply['name']
                    title.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title.TextSize = 20.000
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    acorr.Name = "copy"
                    acorr.Parent = Input
                    acorr.AnchorPoint = Vector2.new(0.5, 0.5)
                    acorr.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    acorr.BackgroundTransparency = 1.000
                    acorr.Position = UDim2.new(0.5, 0, 0.5, 0)
                    acorr.Size = UDim2.new(0.88, 0, 0.86, 0)
                    acorr.ZIndex = settings.ZIndex+4
                    acorr.Font = Enum.Font.Ubuntu
                    acorr.Text = ""
                    acorr.TextEditable = false
                    acorr.TextTransparency = 1
                    acorr.TextColor3 = Color3.fromRGB(125, 125, 125)
                    acorr.TextSize = 20.000

                    icon.Name = "icon"
                    icon.Parent = Label
                    icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    icon.BackgroundTransparency = 1.000
                    icon.LayoutOrder = 9
                    icon.Position = UDim2.new(0.032, 0, 0.505, 0)
                    icon.Size = UDim2.new(0, 25, 0, 25)
                    icon.ZIndex = settings.ZIndex+2
                    icon.Image = "rbxassetid://3926307971"
                    icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
                    icon.ImageRectOffset = Vector2.new(164, 324)
                    icon.ImageRectSize = Vector2.new(36, 36)

                end

                local info = tipgen(Label,toapply['desc'])

                do
                    -- save col
                    local c = toRGB(bg_4.ImageColor3)

                    -- main func
                    local db = false
                    local isutingthis = false
                    Label.MouseButton1Up:Connect(function()
                        if not isutingthis then return end
                        isutingthis = false
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        if isonbtn then 
                            TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.label.ratio,c.G+settings.cm.label.ratio,c.B+settings.cm.label.ratio)}):Play()
                            TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play() 
                            TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                        end
                        if db then return end
                        db = true
                        if syn then setclipboard(tostring(toapply['clip'])) end

                        title.Text = "Copied"
                        wait(1)
                        title.Text = toapply['name']
                        db = false

                    end)
                
                    -- visual
                    Label.MouseButton1Down:Connect(function()
                        isutingthis = true
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.cm.label.ratio,c.G-settings.cm.label.ratio,c.B-settings.cm.label.ratio)}):Play()
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(150,150,150)}):Play() 
                    
                    end)
                    Label.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.label.ratio,c.G+settings.cm.label.ratio,c.B+settings.cm.label.ratio)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                    
                    end)
                    Label.MouseLeave:Connect(function()
                        isonbtn = false
                        isutingthis = false
                        if islistopened then return end
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        TweenService:Create(title,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(bg_4,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                    
                    end)
                end
            end
            function lib3:CreateList(fsettings,callback)
                if type(fsettings) ~= "table" then error("["..menu_name.."-"..tab_name.."] ~ 1st arg of <CreateList> must be table type");return end
                callback = callback or function() end
                counters['lists'] = counters['lists'] + 1

                local save = {num=counters['lists']}
                local toapply = {name="List name",desc="",multi=false,btns={"name is value",{"button with own value","hello world!"}}}

                for k,v in pairs(fsettings) do
                    k = tostring(k):lower()
                    if table.find({"name","title"},k) then
                        toapply['name'] = tostring(v)
                    elseif table.find({'desc','description'},k) then
                        toapply['desc'] = tostring(v)
                    elseif k == "multi" then
                        if type(v) == "boolean" then
                            toapply['multi'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateList ("..save['num']..")>") end
                    elseif table.find({'buttons','btns',"btn"},k) then
                        if type(v) == "table" then
                            toapply['btns'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateList ("..save['num']..")>") end
                    elseif k == 'exec' then
                        if type(v) == "boolean" then
                            toapply['exec'] = v
                        else warn("["..menu_name.."-"..tab_name.."] ~ key \""..k.."\" must have \"boolean type\" in <CreateToggle ("..save['num']..")>") end
                    else
                        warn("["..menu_name.."-"..tab_name.."] ~ Unknown key given: \""..k.."\" in <CreateList ("..save['num']..")>")
                    end
                end

                local List = Instance.new("TextButton")
                 local bg_33 = Instance.new("ImageLabel")
                 local title = Instance.new("TextLabel")
                 local icon = Instance.new("ImageButton")
                 local items = Instance.new("TextLabel")

                 local List1 = Instance.new("ScrollingFrame")
                 local UIGridLayout = Instance.new("UIGridLayout")
                            
                do
                    List.Name = "List"..mijntabid.."-"..save['num']
                    List.Parent = Menu1_2
                    List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    List.BackgroundTransparency = 1.000
                    List.BorderSizePixel = 0
                    List.Size = UDim2.new(0, 200, 0, 50)
                    List.ZIndex = settings.ZIndex+3
                    List.Font = Enum.Font.Ubuntu
                    List.Text = ""
                    List.TextColor3 = Color3.fromRGB(255, 255, 255)
                    List.TextSize = 16.000

                    bg_33.Name = "bg"
                    bg_33.Parent = List
                    bg_33.Active = true
                    bg_33.AnchorPoint = Vector2.new(0.5, 0.5)
                    bg_33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    bg_33.BackgroundTransparency = 1.000
                    bg_33.Position = UDim2.new(0.5, 0, 0.5, 0)
                    bg_33.Selectable = true
                    bg_33.Size = UDim2.new(1, 0, 1, 0)
                    bg_33.ZIndex = settings.ZIndex+2
                    bg_33.Image = "rbxassetid://3570695787"
                    bg_33.ImageColor3 = Color3.fromRGB(22, 22, 22)
                    bg_33.ScaleType = Enum.ScaleType.Slice
                    bg_33.SliceCenter = Rect.new(100, 100, 100, 100)
                    bg_33.SliceScale = 0.080

                    title.Name = "title"
                    title.Parent = List
                    title.AnchorPoint = Vector2.new(0.5, 0.5)
                    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    title.BackgroundTransparency = 1.000
                    title.Position = UDim2.new(0.5, 0, 0.5, 0)
                    title.Size = UDim2.new(0.88, 0, 0.86, 0)
                    title.ZIndex = settings.ZIndex+3
                    title.Font = Enum.Font.Ubuntu
                    title.Text = toapply['name']
                    title.TextColor3 = Color3.fromRGB(200, 200, 200)
                    title.TextSize = 20.000
                    title.TextXAlignment = Enum.TextXAlignment.Left

                    icon.Name = "icon"
                    icon.Parent = List
                    icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    icon.BackgroundTransparency = 1.000
                    icon.Position = UDim2.new(0.03125, 0, 0.5, 0)
                    icon.Size = UDim2.new(0, 25, 0, 25)
                    icon.ZIndex = settings.ZIndex+3
                    icon.Image = "rbxassetid://3926305904"
                    icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
                    icon.ImageRectOffset = Vector2.new(644, 364)
                    icon.ImageRectSize = Vector2.new(36, 36)

                    items.Name = "items"
                    items.Parent = List
                    items.AnchorPoint = Vector2.new(0.5, 0.5)
                    items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    items.BackgroundTransparency = 1.000
                    items.Position = UDim2.new(0.5, 0, 0.5, 0)
                    items.Size = UDim2.new(0.88, 0, 0.86, 0)
                    items.ZIndex = settings.ZIndex+3
                    items.Font = Enum.Font.Ubuntu
                    items.TextColor3 = Color3.fromRGB(200, 200, 200)
                    items.TextSize = 20.000
                    items.TextTransparency = 1.000
                    items.TextXAlignment = Enum.TextXAlignment.Left


                    List1.Name = "List"..mijntabid.."-"..save['num']
                    List1.Parent = ListSelector.bg
                    List1.Active = true
                    List1.AnchorPoint = Vector2.new(0, 0.5)
                    List1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    List1.BackgroundTransparency = 1.000
                    List1.BorderSizePixel = 0
                    List1.Position = UDim2.new(0.02, 0, 0.5, 0)
                    List1.Size = UDim2.new(0.96, 3, 0.96, 0)
                    List1.ZIndex = settings.ZIndex+26
                    List1.ScrollBarThickness = 3
        
                    UIGridLayout.Parent = List1
                    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    UIGridLayout.CellPadding = UDim2.new(0, 2, 0, 2)
                    UIGridLayout.CellSize = UDim2.new(1, 0, 0, 30)
                end

                do
                    if type(toapply['btns'][1]) == "string" then
                        if toapply["exec"] then pcall(callback,toapply['btns'][1]) end
                        items.Text = toapply['btns'][1]
                    else
                        if toapply["exec"] then pcall(callback,toapply['btns'][1][1]) end
                        items.Text = toapply['btns'][1][1]
                    end
                    local ispressed = false
                    local c = toRGB(bg_33.ImageColor3)
                    List.MouseButton1Up:Connect(function()
                        islistopened = true
                        TweenService:Create(bg_33,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        if isonbtn then 
                            TweenService:Create(bg_33,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.list.ratio,c.G+settings.cm.list.ratio,c.B+settings.cm.list.ratio)}):Play()
                            TweenService:Create(items,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play() 
                            TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                        end
                        if not ispressed then return end
                        for i,v in pairs(LSbg:GetChildren()) do
                            v.Visible = false
                        end
                        List1.Visible = true
                        ispressed = false
                        blackBg.Visible = true
                        TweenService:Create(ListSelector,TweenInfo.new(.25),{Position = UDim2.new(0.74, 0, 0.5, 0)}):Play()
                        TweenService:Create(bg_7,TweenInfo.new(.25),{ImageTransparency = 0.15}):Play()
                        
                    end)
                    
                    -- visual
                    List.MouseButton1Down:Connect(function()
                        ispressed = true
                        TweenService:Create(bg_33,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.cm.list.ratio,c.G-settings.cm.list.ratio,c.B-settings.cm.list.ratio)}):Play()
                        TweenService:Create(items,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(150,150,150)}):Play() 
                    
                    end)
                    List.MouseEnter:Connect(function()
                        if islistopened then return end
                        isonbtn = true
                        TweenService:Create(items,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                        TweenService:Create(bg_33,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.list.ratio,c.G+settings.cm.list.ratio,c.B+settings.cm.list.ratio)}):Play()
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play() 
                        TweenService:Create(title,TweenInfo.new(.25),{TextTransparency = 1}):Play() 
                        TweenService:Create(items,TweenInfo.new(.25),{TextTransparency = 0}):Play() 
                    
                    end)
                    List.MouseLeave:Connect(function()
                        isonbtn = false
                        ispressed = false
                        if islistopened then return end
                        TweenService:Create(icon,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(200,200,200)}):Play() 
                        TweenService:Create(items,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        TweenService:Create(bg_33,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                        TweenService:Create(title,TweenInfo.new(.25),{TextTransparency = 0}):Play() 
                        TweenService:Create(items,TweenInfo.new(.25),{TextTransparency = 1}):Play() 
                    
                    end)
                end

                for i,v in pairs(toapply['btns']) do
                    local Button = Instance.new("TextButton")
                    local bg_34 = Instance.new("ImageLabel")

                    local lname;
                    local lvalue;

                    if type(v) == "table" then
                        lname = v[1]
                        lvalue = v[2]
                    else lname,lvalue = v,v end
                    do
                        Button.Name = "Button"
                        Button.Parent = List1
                        Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                        Button.BackgroundTransparency = 1.000
                        Button.BorderSizePixel = 0
                        Button.Size = UDim2.new(0, 200, 0, 50)
                        Button.ZIndex = settings.ZIndex+28
                        Button.Font = Enum.Font.Ubuntu
                        Button.Text = lname
                        Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Button.TextSize = 14.000
                        
                        bg_34.Name = "bg"
                        bg_34.Parent = Button
                        bg_34.Active = true
                        bg_34.AnchorPoint = Vector2.new(0.5, 0.5)
                        bg_34.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        bg_34.BackgroundTransparency = 1.000
                        bg_34.Position = UDim2.new(0.5, 0, 0.5, 0)
                        bg_34.Selectable = true
                        bg_34.Size = UDim2.new(1, 0, 1, 0)
                        bg_34.ZIndex = settings.ZIndex+27
                        bg_34.Image = "rbxassetid://3570695787"
                        bg_34.ImageColor3 = Color3.fromRGB(25, 25, 25)
                        bg_34.ScaleType = Enum.ScaleType.Slice
                        bg_34.SliceCenter = Rect.new(100, 100, 100, 100)
                        bg_34.SliceScale = 0.080
                    end
                    do
                        local ispressed = false
                        local c = toRGB(bg_34.ImageColor3)
                        local isonbtn = false
                        Button.MouseButton1Up:Connect(function()
                            TweenService:Create(Button,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                            TweenService:Create(bg_34,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()
                            if isonbtn then
                                TweenService:Create(Button,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                                TweenService:Create(bg_34,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.list.btns.ratio,c.G+settings.cm.list.btns.ratio,c.B+settings.cm.list.btns.ratio)}):Play()
                                
                            end
                            if not ispressed then return end
                            ispressed = false
                            items.Text = lname
                            pcall(callback,lvalue)
                        end)
                        Button.MouseButton1Down:Connect(function()
                            ispressed = true
                            TweenService:Create(Button,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                            TweenService:Create(bg_34,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R-settings.cm.list.btns.ratio,c.G-settings.cm.list.btns.ratio,c.B-settings.cm.list.btns.ratio)}):Play()
                        end)
                        Button.MouseEnter:Connect(function()
                            TweenService:Create(Button,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                            TweenService:Create(bg_34,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R+settings.cm.list.btns.ratio,c.G+settings.cm.list.btns.ratio,c.B+settings.cm.list.btns.ratio)}):Play()
                        
                        end)
                        Button.MouseLeave:Connect(function()
                            ispressed = false
                            TweenService:Create(Button,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                            TweenService:Create(bg_34,TweenInfo.new(.25),{ImageColor3 = Color3.fromRGB(c.R,c.G,c.B)}):Play()

                        end)
                    end

                end
                local khm = #toapply['btns'] * (UIGridLayout.CellSize.Y.Offset + UIGridLayout.CellPadding.Y.Offset)
                TweenService:Create(List1,TweenInfo.new(.1),{CanvasSize = UDim2.new(0,0,0,khm)}):Play()
            end
            autosizeY(Menu1_2,function(_) if _ > 4 then TweenService:Create(Menu1_2,TweenInfo.new(.1),{Position = UDim2.new(0.57, 0,0.5, 0)}):Play() end; end) 
            autosizeY(NewMenuscr,function(_) if _ > 6 then TweenService:Create(NewMenuscr,TweenInfo.new(.1),{Position = UDim2.new(0.48, 0,0.5, 0)}):Play() end; end)
            --
            do -- tab changer
                local isonbtn = false
                local c = toRGB(NewMenubg.ImageColor3)
                NewMenu1.MouseButton1Up:Connect(function()
                    click("up",c,NewMenubg,NewMenu1,isonbtn,"root")
                    pcall(function() for i,v in pairs(NewMenu:GetChildren()) do
                        if "tab "..mijntabid == v.Name and v.ClassName == "ScrollingFrame" then v.Visible = true
                        elseif v.ClassName == "ScrollingFrame" then v.Visible = false end
                    end end)

                end)
                NewMenu1.MouseButton1Down:Connect(function()
                    click("down",c,NewMenubg,NewMenu1,isonbtn,"root")

                end)
                NewMenu1.MouseEnter:Connect(function()
                    if islistopened then return end
                    isonbtn = true
                    click("enter",c,NewMenubg,NewMenu1,isonbtn,"root")

                end)
                NewMenu1.MouseLeave:Connect(function()
                    isonbtn = false
                    if islistopened then return end
                    click("leave",c,NewMenubg,NewMenu1,isonbtn,"root")

                end)

            end
            return lib3
        end
        
        autosizeY(MenuChooser,function(_) if _ > 8 then TweenService:Create(MenuChooser,TweenInfo.new(.1),{Position = UDim2.new(0.57, 0,0.5, 0)}):Play() end; end) 
        return tlib
    end
    return lib2
end
getgenv().ngstloader = lib:init("nGSTLoader","https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/service.json")


getgenv().ngstloader:CustomScript("AnimHub","https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.lua")
getgenv().ngstloader:CustomScript("SSpy","https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/SimpleSpy.lua")
getgenv().ngstloader:CustomScript("BackDoor","https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/backdoor.lua")
getgenv().ngstloader:CustomScript("DelAltDel","https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/CtrlAltDel.lua")

getgenv().ngstloader:CustomScript("InfY","https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
getgenv().ngstloader:CustomScript("OwlHub","https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt")

loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AutoExec.lua"))() -- autoExec

--[[local indev = getgenv().ngstloader:AddMenu("dev")
local tab1 = indev:AddTab("test")
tab1:CreateButton({},function(_) print("clicked ".._.." times!") end)
tab1:CreateToggle({},function(_) print("state: "..tostring(_)) end)
tab1:CreateInput({},function(_) print("input text: ".._) end)
tab1:CreateSlider({},function(_) print("Int: ".._) end)
tab1:CreateBind({},function(_,_T) print("Key: ".._..", Tick: ".._T) end)
tab1:CreateLabel({})
tab1:CreateList({},function(_) print('Value is: '.._) end)
local tab2 = indev:AddTab("test1")
tab2:CreateButton({name="changed name", desc="have desc"},function(_) print("clicked ".._.." times!") end)
tab2:CreateToggle({name="changed name", desc="have desc",state=true,exec=true},function(_) print("state: "..tostring(_)) end)
tab2:CreateInput({name="Auto complete player name",desc="Auto complete Playe's Name or DisplayName",ac={game:GetService("Players"):GetChildren(),{"Name","DisplayName"}}},function(_) print("input text: ".._) end)
tab2:CreateSlider({name="changed name",desc="have desc",min=-100,def=0,max=100},function(_) print("Int: ".._) end)
tab2:CreateBind({name="changed name + loop",loop=true,desc="have desc",key="*"},function(_,_T) print("Key: ".._..", Tick: ".._T) end)
tab2:CreateLabel({name="changed name + clipboard info",copy="i'am clanged",desc="it's really changed"})
tab2:CreateList({name="changed name",multi=true,desc="have enabled multi choicer (soon)",btns={"changed name only",{"changed name + value","i like dinging"}}},function(_) print('Value is: '.._) end)]]
