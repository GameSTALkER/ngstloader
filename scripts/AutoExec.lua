do
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
    _gui = getgenv().ngstloader:AddMenu("AutoExec")
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
end
do
    local tab = _gui:AddTab("Animations")
    
    local cfgname = "FreeAnimations.json"
    
    local function cfg(val)
        if not isfile(cfgname) then writefile(cfgname,"{}") end
        if val == nil then -- load
			local data = readfile(cfgname)
            resp, err = pcall(function() data = game:GetService("HttpService"):JSONDecode(data) end)
			if not resp then
				print(cfgname.." is broken. recreating...")
				writefile(cfgname, "{}")
				
				return {}
			end
			return data
            
        else -- save
            writefile(cfgname, game:GetService("HttpService"):JSONEncode(val))
            
        end
        
    end
    
    local reanimdata = cfg(nil)
    local function ReAnimate(id,Anim)
        pcall(function()
            local mychar = game.Players.LocalPlayer.Character
	    if mychar.Humanoid.RigType == Enum.HumanoidRigType.R6 then return end
            reanimdata[Anim] = id
            cfg(reanimdata)
            if id == -1 then return end
            local AnimateScript = mychar:WaitForChild("Animate")
            if type(id) == "table" then
                if Anim == "idle" then
                    for k,w in pairs(id) do
                        for i,v in pairs(AnimateScript[Anim]:GetChildren()) do
                            if v.ClassName == "Animation" and v.Name == "Animation"..k then v.AnimationId = "rbxassetid://"..w end

                        end

                    end

                elseif Anim == "swim" then
                    for i,v in pairs(AnimateScript[Anim]:GetChildren()) do
                        if v.ClassName == "Animation" and v.Name == "swim" then v.AnimationId = "rbxassetid://"..id[1] 
                        elseif v.ClassName == "Animation" and v.Name == "swimIdle" then v.AnimationId = "rbxassetid://"..id[2] end

                    end

                end
            
            else
                for i,v in pairs(AnimateScript[Anim]:GetChildren()) do
                    if v.ClassName == "Animation" then v.AnimationId = "rbxassetid://"..id end
                    
                end
            
            end
            mychar.Humanoid:ChangeState(5)
        end)
    end
    if getgenv().FreeAnimationsCon ~= nil then getgenv().FreeAnimationsCon:Disconnect() end
    getgenv().FreeAnimationsCon = game.Players.LocalPlayer.CharacterAdded:Connect(function()
        for k,v in pairs(reanimdata) do
            if v ~= -1 then 
                ReAnimate(v,k)
                wait()
            
            end
    
        end 
            
    end)
    local animbtn = {}
    tab:CreateList({name="Animation Pack",active=reanimdata.Pack,btns={{"OFF",{run=-1,walk=-1,fall=-1,jump=-1,idle=-1,swim=-1,climb=-1}},
        {"None",{run=0,walk=0,fall=0,jump=0,idle={0,0},swim={0,0},climb=0}},
        {"Oldschool",{run=5319844329,walk=5319847204,fall=5319839762,jump=5319841935,idle={5319828216,5319831086},swim={5319850266,5319852613},climb=5319816685}},
        {"Toy",{run=782842708,walk=782843345,fall=782846423,jump=782847020,idle={782841498,782845736},swim={782844582,782845186},climb=782843869}},
        {"Stylish",{run=616140816,walk=616146177,fall=616134815,jump=616139451,idle={616136790,616138447},swim={616143378,616144772},climb=616133594}},
        {"Robot",{run=616091570,walk=616095330,fall=616087089,jump=616090535,idle={616088211,616089559},swim={616092998,616094091},climb=616086039}},
        {"Zombie",{run=616163682,walk=616168032,fall=616157476,jump=616161997,idle={616158929,616160636},swim={616165109,616166655},climb=616156119}},
        {"Bubbly",{run=910025107,walk=910034870,fall=910001910,jump=910016857,idle={910004836,910009958},swim={910028158,910030921},climb=909997997}},
        {"Ninja",{run=656118852,walk=656121766,fall=656115606,jump=656117878,idle={656117400,656118341},swim={656119721,656121397},climb=707826056}},
        {"Cartoony",{run=742638842,walk=742640026,fall=742637151,jump=742637942,idle={742637544,742638445},swim={742639220,742639812},climb=742636889}},
        {"Mage",{run=707861613,walk=707897309,fall=707829716,jump=707853694,idle={707742142,707855907},swim={707876443,707894699},climb=656114359}},
        {"Rthro",{run=2510198475,walk=2510202577,fall=2510195892,jump=2510197830,idle={2510196951,2510197257},swim={2510199791,2510201162},climb=845392038}},
        {"WereWolf",{run=1083216690,walk=1083178339,fall=1083189019,jump=1083218792,idle={1083195517,1083214717},swim={1083222527,1083225406},climb=1083182000}},
        {"Elder",{run=845386501,walk=845403856,fall=845396048,jump=845398858,idle={845397899,845400520},swim={845401742,845403127},climb=2510192778}},
        {"Vampire",{run=1083462077,walk=1083473930,fall=1083443587,jump=1083455352,idle={1083445855,1083450166},swim={1083464683,1083467779},climb=1083439238}},
        {"Astronaut",{run=891636393,walk=891636393,fall=891617961,jump=891627522,idle={891621366,891633237},swim={891639666,891663592},climb=891609353}},
        {"Superhero",{run=616117076,walk=616122287,fall=616108001,jump=616115533,idle={616111295,616113536},swim={616119360,616120861},climb=616104706}},
        {"Levitation",{run=616010382,walk=616013216,fall=616005863,jump=616008936,idle={616006778,616008087},swim={616011509,616012453},climb=616003713}},
        {"Knight",{run=657564596,walk=657552124,fall=657600338,jump=658409194,idle={657595757,657568135},swim={657560551,657557095},climb=658360781}},
        {"Pirate",{run=750783738,walk=750785693,fall=750780242,jump=750782230,idle={750781874,750782770},swim={750784579,750785176},climb=750779899}}
    }},function(id,name)
    	reanimdata.Pack = name
    	reanimdata.idleName=name
    	reanimdata.swimName=name
        for k,v in pairs(id) do
            animbtn[k]:Active(name)
            ReAnimate(v,k)
            
        end
    
    end)
    animbtn['run'] = tab:CreateList({name="Run Animation",exec=true,active=reanimdata.run,btns={{"OFF",-1},
        {"None",0},
        {"Oldschool",5319844329},
        {"Toy",782842708},
        {"Stylish",616140816},
        {"Robot",616091570},
        {"Zombie",616163682},
        {"Bubbly",910025107},
        {"Ninja",656118852},
        {"Cartoony",742638842},
        {"Mage",707861613},
        {"Rthro",2510198475},
        {"Rthro Heavy",3236836670},
        {"WereWolf",1083216690},
        {"Elder",845386501},
        {"Vampire",1083462077},
        {"Astronaut",891636393},
        {"Superhero",616117076},
        {"Levitation",616010382},
        {"Knight",657564596},
        {"Pirate",750783738},
        {"Mr. Toilet Run",4417979645}
    }},function(id,name)
        ReAnimate(id,"run")
        
    end)
    animbtn['walk'] = tab:CreateList({name="Walk Animation",exec=true,active=reanimdata.walk,btns={{"OFF",-1},
        {"None",0},
        {"Oldschool",5319847204},
        {"Toy",782843345},
        {"Stylish",616146177},
        {"Robot",616095330},
        {"Zombie",616168032},
        {"Bubbly",910034870},
        {"Ninja",656121766},
        {"Cartoony",742640026},
        {"Mage",707897309},
        {"Rthro",2510202577},
        {"WereWolf",1083178339},
        {"Elder",845403856},
        {"Vampire",1083473930},
        {"Astronaut",891636393},
        {"Superhero",616122287},
        {"Levitation",616013216},
        {"Knight",657552124},
        {"Pirate",750785693},
        {"Ud'zal's Walk",3303162967}
    }},function(id)
        ReAnimate(id,"walk")
        
    end)
    animbtn['fall'] = tab:CreateList({name="Fall Animation",exec=true,active=reanimdata.fall,btns={{"OFF",-1},
        {"None",0},
        {"Oldschool",5319839762},
        {"Toy",782846423},
        {"Stylish",616134815},
        {"Robot",616087089},
        {"Zombie",616157476},
        {"Bubbly",910001910},
        {"Ninja",656115606},
        {"Cartoony",742637151},
        {"Mage",707829716},
        {"Rthro",2510195892},
        {"WereWolf",1083189019},
        {"Elder",845396048},
        {"Vampire",1083443587},
        {"Astronaut",891617961},
        {"Superhero",616108001},
        {"Levitation",616005863},
        {"Knight",657600338},
        {"Pirate",750780242}
    }},function(id)
        ReAnimate(id,"fall")
        
    end)
    animbtn['jump'] = tab:CreateList({name="Jump Animation",exec=true,active=reanimdata.jump,btns={{"OFF",-1},
        {"None",0},
        {"Oldschool",5319841935},
        {"Toy",782847020},
        {"Stylish",616139451},
        {"Robot",616090535},
        {"Zombie",616161997},
        {"Bubbly",910016857},
        {"Ninja",656117878},
        {"Cartoony",742637942},
        {"Mage",707853694},
        {"Rthro",2510197830},
        {"WereWolf",1083218792},
        {"Elder",845398858},
        {"Vampire",1083455352},
        {"Astronaut",891627522},
        {"Superhero",616115533},
        {"Levitation",616008936},
        {"Knight",658409194},
        {"Pirate",750782230}
    }},function(id)
        ReAnimate(id,"jump")
        
    end)
    animbtn['idle'] = tab:CreateList({name="Idle Animation",exec=true,active=reanimdata.idleName,btns={{"OFF",-1},
        {"None",{0,0}},
        {"Oldschool",{5319828216,5319831086}},
        {"Toy",{782841498,782845736}},
        {"Stylish",{616136790,616138447}},
        {"Robot",{616088211,616089559}},
        {"Zombie",{616158929,616160636}},
        {"Bubbly",{910004836,910009958}},
        {"Ninja",{656117400,656118341}},
        {"Cartoony",{742637544,742638445}},
        {"Mage",{707742142,707855907}},
        {"Rthro",{2510196951,2510197257}},
        {"WereWolf",{1083195517,1083214717}},
        {"Elder",{845397899,845400520}},
        {"Vampire",{1083445855,1083450166}},
        {"Astronaut",{891621366,891633237}},
        {"Superhero",{616111295,616113536}},
        {"Levitation",{616006778,616008087}},
        {"Knight",{657595757,657568135}},
        {"Pirate",{750781874,750782770}},
        {"Borock's Idle",{3293641938,3293642554}},
        {"Mr. Toilet Idle",{4417977954,4417978624}},
        {"Ud'zal's Idle",{3303162274,3303162549}}
    }},function(id,name)
    	reanimdata.idleName = name
        ReAnimate(id,"idle")
        
    end)
    animbtn['swim'] = tab:CreateList({name="Swim Animation",exec=true,active=reanimdata.swimName,btns={{"OFF",-1},
        {"None",{0,0}},
        {"Oldschool",{5319850266,5319852613}},
        {"Toy",{782844582,782845186}},
        {"Stylish",{616143378,616144772}},
        {"Robot",{616092998,616094091}},
        {"Zombie",{616165109,616166655}},
        {"Bubbly",{910028158,910030921}},
        {"Ninja",{656119721,656121397}},
        {"Cartoony",{742639220,742639812}},
        {"Mage",{707876443,707894699}},
        {"Rthro",{2510199791,2510201162}},
        {"WereWolf",{1083222527,1083225406}},
        {"Elder",{845401742,845403127}},
        {"Vampire",{1083464683,1083467779}},
        {"Astronaut",{891639666,891663592}},
        {"Superhero",{616119360,616120861}},
        {"Levitation",{616011509,616012453}},
        {"Knight",{657560551,657557095}},
        {"Pirate",{750784579,750785176}}
    }},function(id,name)
    	reanimdata.swimName = name
        ReAnimate(id,"swim")
        
    end)
    animbtn['climb'] = tab:CreateList({name="Climb Animation",exec=true,active=reanimdata.climb,btns={{"OFF",-1},
        {"None",0},
        {"Oldschool",5319816685},
        {"Toy",782843869},
        {"Stylish",616133594},
        {"Robot",616086039},
        {"Zombie",616156119},
        {"Bubbly",909997997},
        {"Ninja",656114359},
        {"Cartoony",742636889},
        {"Mage",707826056},
        {"Rthro",2510192778},
        {"WereWolf",1083182000},
        {"Elder",845392038},
        {"Vampire",1083439238},
        {"Astronaut",891609353},
        {"Superhero",616104706},
        {"Levitation",616003713},
        {"Knight",658360781},
        {"Pirate",750779899}
    }},function(id)
        ReAnimate(id,"climb")
        
    end)

end
