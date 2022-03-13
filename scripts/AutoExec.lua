local function cfg(act,v)
    if not isfile("AutoExec.json") then writefile("AutoExec.json", "{}") end
    if act:lower() == "save" then
        writefile("AutoExec.json", game:GetService("HttpService"):JSONEncode(v))
        
    else local data = readfile("AutoExec.json") 
        return game:GetService("HttpService"):JSONDecode(data) end
    
end
local states = cfg("load",nil)

if getgenv().AutoExecPuppy ~= nil then
    for i,v in pairs(getgenv().AutoExecPuppy[1]) do
        pcall(function() v:Disconnect() end)
        
    end
    getgenv().AutoExecPuppy = nil
    
end
if getgenv().AutoExecPuppy == nil then getgenv().AutoExecPuppy = {[1]={}, [2]={}} end

-- interface
local _gui = getgenv().ngstloader:AddMenu("AutoExec")
local _general = _gui:AddTab("General")
local f = {af=false,uf=false,em=false}

_general:CreateToggle({name="anti-afk", desc="Prevent to be kicked from place", state=states["anti-afk"], exec=true}, function(_)
    if game.PlaceId == 2768379856 then return end -- will dont work in this places
    if _ then
        local vu = game:GetService("VirtualUser")
        getgenv().AutoExecPuppy[1]["anti-afk"] = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            
        end)
        
    else pcall(function() getgenv().AutoExecPuppy[1]["anti-afk"]:Disconnect() end) end
    if not f.af then f.af = true;return end
    states['anti-afk'] = _
    cfg("save",states)
    
end)
_general:CreateToggle({name="unfocus", desc="When roblox is not focused it will reduce RAM and CPU usage by roblox", state=states["unfocus"], exec=true}, function(_)
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

    if _ then
        getgenv().AutoExecPuppy[1]["unfocus"] = UserInputService.WindowFocusReleased:Connect(WindowFocusReleasedFunction)
    else pcall(function() getgenv().AutoExecPuppy[1]["unfocus"]:Disconnect() end) end
    if getgenv().AutoExecPuppy[2]["unfocus"] == nil then getgenv().AutoExecPuppy[2]["unfocus"] = UserInputService.WindowFocused:Connect(WindowFocusedFunction) end

    if not f.uf then f.uf = true;return end
    states['unfocus'] = _
    cfg("save",states)
end)
_general:CreateToggle({name="free emotes (/e %emotename)", desc="dance4-dance30 + names from avatar shop", state=states["emotes"], exec=true}, function(_)
    if _ then
        local emotes = { -- all emotes from catalog + aliases
            ["monkey"] = 3333499508,                    ["monke"] = 3333499508,                 ["dance4"] = 3333499508,
            ["curtsy"] = 4555816777,
            ["happy"] = 4841405708,
            ["quiet waves"] = 7465981288,               ["qwaves"] = 7465981288,
            ["sleep"] = 4686925579,
            ["floss dance"] = 5917459365,               ["floss"] = 5917459365,                 ["dance5"] = 5917459365,
            ["shy"] = 3337978742,
            ["godlike"] = 3337994105,                   ["god like"] = 3337994105,
            ["high wave"] = 5915690960,                 ["hwave"] = 5915690960,
            ["hero landing"] = 5104344710,              ["hero"] = 5104344710,
            ["salute"] = 3333474484,                    ["salut"] = 3333474484,
            ["tilt"] = 3334538554,
            ["applaud"] = 5915693819,
            ["bored"] = 5230599789,
            ["show dem wrists"] = 7198989668,           ["sdw"] = 7198989668,                   ["dance25"] = 7198989668,
            ["cower"] = 4940563117,
            ["celebrate"] = 3338097973,
            ["baby dance"] = 4265725525,                ["baby"] = 4265725525,                  ["dance6"] = 4265725525,
            ["lasso turn"] = 7942896991,                ["lstv"] = 7942896991,
            ["line dance"] = 4049037604,                ["line"] = 4049037604,                  ["dance7"] = 4049037604,
            ["haha"] = 3337966527,
            ["samba"] = 6869766175,                     ["sambo"] = 6869766175,                 ["dance26"] = 6869766175,
            ["old town road dance"] = 5937560570,       ["otrd"] = 5937560570,                  ["dance8"] = 5937560570,
            ["side to side"] = 3333136415,              ["sts"] = 3333136415,
            ["hips poppin"] = 6797888062,               ["hp"] = 6797888062,                    ["dance9"] = 6797888062,
            ["on the outside"] = 7422779536,            ["oto"] = 7422779536,                   ["dance10"] = 7422779536,
            ["wake up call"] = 7199000883,              ["wuc"] = 7199000883,                   ["dance11"] = 7199000883,
            ["break dance"] = 5915648917,               ["break"] = 5915648917,                 ["dance12"] = 5915648917,
            ["confused"] = 4940561610,
            ["dolphin dance"] = 5918726674,             ["dolphin"] = 5918726674,               ["dance13"] = 5918726674,
            ["cha cha"] = 6862001787,                                                           ["dance14"] = 6862001787,
            ["shuffle"] = 4349242221,                                                           ["dance27"] = 4349242221,
            ["shrug"] = 3334392772,
            ["boxing punch"] = 7202863182,              ["punch"] = 7202863182,                 ["boxing"] = 7202863182,
            ["point2"] = 3344585679,
            ["stadium"] = 3338055167,
            ["twirl"] = 3334968680,                                                             ["dance28"] = 3334968680,
            ["sad"] = 4841407203,
            ["take me under"] = 6797890377,             ["tmu"] = 6797890377,                   ["dance15"] = 6797890377,
            ["holiday dance"] = 5937558680,             ["holiday"] = 5937558680,               ["dance16"] = 5937558680,
            ["hello"] = 3344650532,                     ["wave"] = 3344650532,
            ["flowing breeze"] = 7465946930,            ["fb"] = 7465946930,                    ["dance29"] = 7465946930,
            ["greatest"] = 3338042785,
            ["fashionable"] = 3333331310,               ["fash"] = 3333331310,                  ["fisting"] = 3333331310,
            ["jumping wave"] = 4940564896,              ["jwave"] = 4940564896,
            ["bodybuilder"] = 3333387824,               ["bb"] = 3333387824,
            ["fast hands"] = 4265701731,                ["fh"] = 4265701731,                    ["dance30"] = 4265701731,
            ["beckon"] = 5230598276,
            ["block partier"] = 6862022283,             ["blockp"] = 6862022283,                ["dance31"] = 6862022283,
            ["tree"] = 4049551434,
            ["dizzy"] = 3361426436,                     ["head"] = 3361426436,
            ["rodeo dance"] = 5918728267,               ["rodeo"] = 5918728267,                 ["dance17"] = 5918728267,
            ["agree"] = 4841397952,                     ["yes"] = 4841397952,
            ["jumping cheer"] = 5895324424,             ["jcheer"] = 5895324424,
            ["dancing shoes"] = 7404878500,             ["shoes"] = 7404878500,                 ["dance18"] = 7404878500,
            ["disagree"] = 4841401869,                  ["no"] = 4841401869,
            ["dorky dance"] = 4212455378,               ["dorky"] = 4212455378,                 ["dance19"] = 4212455378,
            ["rock on"] = 5915714366,
            ["cobra arms"] = 7942890105,                                                        ["dance32"] = 7942890105,
            ["it aint my fault"] = 6797891807,          ["iamf"] = 6797891807,                  ["dance20"] = 6797891807,
            ["power blast"] = 4841403964,               ["pb"] = 4841403964,
            ["t"] = 3338010159,                         ["t pose"] = 3338010159,                ["tpose"] = 3338010159,
            ["zombie"] = 4210116953,
            ["panini dance"] = 5915713518,              ["panini"] = 5915713518,                ["dance21"] = 5915713518,
            ["around town"] = 3303391864,                                                       ["dance33"] = 3303391864,
            ["saturday dance"] = 7422807549,            ["saturday"] = 7422807549,              ["dance22"] = 7422807549,
            ["tantrum"] = 5104341999,                                                           ["dance34"] = 5104341999,
            ["robot"] = 3338025566,
            ["aok"] = 7942885103,                                                               ["dance35"] = 7942885103,
            ["keeping time"] = 4555808220,             ["ktime"] = 4555808220,                  ["dance36"] = 4555808220,
            ["fishing"] = 3334832150,
            ["top rock"] = 3361276673,                                                          ["dance37"] = 3361276673,
            ["fancy feet"] = 3333432454,                                                        ["dance38"] = 3333432454,
            ["idol"] = 4101966434,                                                              ["dance24"] = 4101966434,
            ["air dance"] = 4555782893,                 ["air"] = 4555782893,                   ["dance23"] = 4555782893,
            ["get out"] = 3333272779,                   ["getout"] = 3333272779,
            ["rock guitar"] = 6532134724,
            ["swish"] = 3361481910,
            ["jacks"] = 3338066331,
            ["rock star"] = 6533093212,
            ["y"] = 4349285876,                         ["y pose"] = 4349285876,                ["ypose"] = 4349285876,
            ["drum solo"] = 6532839007,                 ["sdrum"] = 6532839007,
            ["drum master"] = 6531483720,               ["mdrum"] = 6531483720,
            ["up and down"] = 7422797678,               ["uad"] = 7422797678,
            ["swan dance"] = 7465997989,                ["swan"] = 7465997989,
            ["drummer moves"] = 7422527690,             ["dmoves"] = 7422527690,
            ["sneaky"] = 3334424322,
            ["louder"] = 3338083565,
            ["summon"] = 3303161675
        
        }
        
        local active = {}
        local function AnimateMe(animid)
            for i,v in pairs(active) do
                v:Stop()
                active[i] = nil
        
            end
        
            local Character = game.Players.LocalPlayer.Character
            local Anim = Instance.new("Animation")
            Anim.AnimationId = "rbxassetid://"..animid
            
            Character.Animate.Disabled = true
            local toplay = Character.Humanoid.Animator:LoadAnimation(Anim)
            toplay:Play()
            
            active[animid] = toplay
            con = Character.Humanoid.Running:connect(function(speed)
                if speed > 3 then
                    Character.Animate.Disabled = false
                    toplay:Stop()
                    active[animid] = nil
                    con:Disconnect()
        
                end
        
            end)
        
            jumpcon = Character.Humanoid.Jumping:connect(function()
                Character.Animate.Disabled = false
                toplay:Stop()
                active[animid] = nil
                jumpcon:Disconnect()
        
            end)
            
        end
        
        getgenv().AutoExecPuppy[1]["emotes"] = (game.Players.LocalPlayer).Chatted:Connect(function(msg)
            msg = string.lower(msg)
            
            local separate = string.sub(msg,1,3)
            if separate == "/e " then
                local cmd = string.sub(msg,4,string.len(msg))
                
                if emotes[cmd] then AnimateMe(emotes[cmd])
                elseif tonumber(cmd) then AnimateMe(tonumber(cmd)) end
        
            end
        
        end)
    
    else pcall(function() getgenv().AutoExecPuppy[1]["emotes"]:Disconnect() end) end

    if not f.em then f.em = true;return end
    states['emotes'] = _
    cfg("save",states)
end)
