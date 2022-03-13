-- UNFOCUS | fps booster

for i,a in pairs(game:GetDescendants()) do
    if a.Name == "UNFOCUS" then a:Destroy() end
end

if not isfolder("LoaderRewrite/autoexecCFGs") then makefolder("LoaderRewrite/autoexecCFGs") end
if not isfile("LoaderRewrite/autoexecCFGs/UNFOCUS.cfg") then writefile("LoaderRewrite/autoexecCFGs/UNFOCUS.cfg", '0') end
local config = readfile("LoaderRewrite/autoexecCFGs/UNFOCUS.cfg")

local lv = false
local state = nil

local UNFOCUS = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local OFF = Instance.new("TextButton")
local ON = Instance.new("TextButton")

UNFOCUS.Name = "UNFOCUS"
UNFOCUS.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
UNFOCUS.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UNFOCUS.ResetOnSpawn = false

Frame.Name = "Frame"
Frame.Parent = UNFOCUS
Frame.BackgroundTransparency = 1.000
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, -1, 0, -32)
Frame.Size = UDim2.new(0, 12, 0, 32)

OFF.Name = "OFF"
OFF.Parent = Frame
OFF.BackgroundColor3 = Color3.fromRGB(65, 0, 0)
OFF.BorderSizePixel = 0
OFF.Size = Frame.Size
OFF.Text = ""

ON.Name = "ON"
ON.Parent = Frame
ON.BackgroundColor3 = Color3.fromRGB(0, 65, 0)
ON.BorderSizePixel = 0
if config == "1" then ON.Size = Frame.Size else ON.Size = UDim2.new(0, 0, 0, 32) end
ON.Text = ""

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function WindowFocusReleasedFunction()
    RunService:Set3dRenderingEnabled(false)
    setfpscap(10)
end
local function WindowFocusedFunction()
    RunService:Set3dRenderingEnabled(true)
    setfpscap(60)
end

local function con(v,q)
    if v == 0 and state then
        UserInputService.WindowFocusReleased:Disconnect(q)
    else
        state = true
        UserInputService.WindowFocusReleased:Connect(q)
    end
end

local function Initialize()
    if config == "1" then
        if state ~= nil then state:Disconnect() end
        state = UserInputService.WindowFocusReleased:Connect(WindowFocusReleasedFunction)
    else
        if state ~= nil then state:Disconnect() end
        state = UserInputService.WindowFocusReleased:Connect(WindowFocusedFunction)
    end
    writefile("LoaderRewrite/autoexecCFGs/UNFOCUS.cfg", config)
    UserInputService.WindowFocused:Connect(WindowFocusedFunction)
end

ON.MouseButton1Down:connect(function()
    if not lv then
        lv = true
        config = "0"
        ON:TweenSize(UDim2.new(0, 0, 0, 32), "InOut", "Sine", .18)
        Initialize()
        wait(.21)
        lv = false
    end
end)
OFF.MouseButton1Down:connect(function()
    if not lv then
        lv = true
        config = "1"
        ON:TweenSize(Frame.Size, "InOut", "Sine", .18)
        Initialize()
        wait(.21)
        lv = false
    end
end)

Initialize()
