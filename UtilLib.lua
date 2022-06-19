--[[ UtilLib

neededhats(hats: table)
Example:
    if getgenv().neededhats({"Pal Hair",01001,{"Katana",010100}}) then
        print("All is good!")
    else print("You don't have some hats ^") end
 
CFG(location: string, action: table(save) or string(load))
Example:
    local cfg = CFG("tetris","load") -- load
    cfg["debug"] = false
    cfg["completed"] = true
    cfg["pos"] = Vector3.new(35,0,0)
    CFG("tetris",cfg) -- save

Accessory(hatName: string, parent: Instance, settings: table, callback: function(AP, AO))
Example:
    getgenv().Accessory("Dark Cyberpunk Katana",game:GetService("Players").LocalPlayer.Character["Left Arm"],{
        -- core settings
        debug = false; -- print information in console
        bloxify = false; -- from normal UGS to gray block (R6 only) (after first execution will change only for client)
        speed = 1000;
        
        position = Vector3.new(0.3,-0.5,-1.7);
        rotation = Vector3.new(180,-90,40);
        
    },function(AP,AO) -- turn off Oreintation, and will rotate
        AO.Enabled = false
        AP.RigidityEnabled = true
    end)

]]--

getgenv().neededhats = function(hats) -- table, available args: "string", nil
	if hats == nil then warn("UtilLib | Error: getgenv().neededhats("..hats..")\n                        you forgot to add argumet (table) - ^^^"); return end
	if type(hats) ~= "table" then warn("UtilLib | Error: getgenv().neededhats("..hats..")\n           that argument must be \"table\" type - ^^^"); return end
	
    local function getmesh(a)
        for i,v in pairs(a:GetDescendants()) do
            if table.find({"Mesh","SpecialMesh"},v.ClassName) then 
                local id = v.TextureId:gsub("%rbxassetid://","")
                if id:find("http") then id = id:sub(33) end
                
                local di = v.MeshId:gsub("%rbxassetid://","")
                if di:find("http") then di = di:sub(33) end
                
                return {tostring(id):lower(),tostring(di):lower(),a.Name:lower()}
            end
        end
        return {a.Name} -- if no mash found
    end
    
	local plr = game:GetService("Players").LocalPlayer
    
    local found_hats = {}
    local is_all_hats_found = true
    for q,w in pairs(hats) do
        local found = false
        for i,v in pairs(plr.Character.Humanoid:GetAccessories()) do
            local ac = getmesh(v)
            if type(w) == "table" then
                for e,r in pairs(w) do
                    if table.find(ac,tostring(r):lower()) then
                        table.insert(found_hats,v)
                        found = true
                        break
                    end
                end
                if found then break end
            else
                if table.find(ac,tostring(w):lower()) then
                    table.insert(found_hats,v)
                    found = true
                    break
                end
                if found then break end
            end
        end
        if not found then
            local name = nil
            if type(w) == "table" then
                for i,v in pairs(w) do
                    if type(v) == "string" then name = v;break end
                end
                if name == nil then name = tostring(w[1]).." (MashId or TextureId)" end
            else name = w end
            warn("You need: "..tostring(name)) 
            is_all_hats_found = false
        end
	end
    return is_all_hats_found
    
end

getgenv().CFG = function(location, action)
    if location == nil then location = "global" end
    if action == nil then action = "get" end
    location = tostring(location):lower()

    local folder = "nGSTLoader" -- root folder
    local file_type = ".txt"
    local HttpService = game:GetService("HttpService")
    
    if not isfolder(folder) then makefolder(folder) end -- root folder
    if location ~= "global" then
        folder = folder.."/"..game.PlaceId
        if not isfolder(folder) then makefolder(folder) end -- root/game folder
        folder = folder.."/"..location..file_type
        if not isfile(folder) then writefile(folder, "{}") end -- root/game/%location folder
    else 
        folder = folder.."/"..location..file_type
        if not isfile(folder) then writefile(folder, "{}") end -- root/%location folder
    end
    if type(action) == "table" then -- save
        local data = HttpService:JSONEncode(action)
        writefile(folder, data)
    else -- load
        local raw_string = readfile(folder)
        local data = HttpService:JSONDecode(raw_string)
        return data
    end

end
local default_settings = {
    debug = false; -- print some info
    bloxify = false; -- remove mesh
    speed = 100; -- Speed
    
    pos = Vector3.new(0,0,0); -- Position
    rot = Vector3.new(0,0,0); -- Rotation
}
local function neededType(value,ntype)
    if type(value) == ntype then 
        return true 
    elseif rstr == nil then 
        return false 
    end
end
local isHatChanging = false
getgenv().Accessory = function(hatName,parent,settings,callback)
    repeat wait() until isHatChanging == false
    isHatChanging = hatName
    if hatName == nil then print("hatName can't be nil.");isHatChanging=false;return nil end
    if parent == nil then print("parent can't be nil.");isHatChanging=false;return nil end
    if type(settings) ~= "table" then 
        print("loaded default settings.")
        settings = default_settings
    else
        if settings.debug == nil then settings.debug = false end
        if settings.bloxify == nil then settings.bloxify = false end
        if settings.speed == nil then settings.speed = 100 end
        if settings.pos == nil then settings.pos = Vector3.new(0,0,0) end
        if settings.rot == nil then settings.rot = Vector3.new(0,0,0) end
    end
    if callback == nil then callback = function() end end
    local function debug(str) if settings.debug then print(tostring(str)) end end
    
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character
    
    local hat = nil
    if getgenv().hats_attributes == nil then getgenv().hats_attributes = {} end
    if type(hatName) == "string" then
        for i,v in pairs(Character.Humanoid:GetAccessories()) do
            if v.Name == hatName then hat = v end
        end
    else hat = hatName end
    if hat == nil then print("Hat not found.");isHatChanging=false;return nil end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/Universal/netless.lua"))()
    pcall(function() hat.Handle.AccessoryWeld:Destroy() end)
    if hat:GetAttribute("IsReanimated") and getgenv().hats_attributes[hat.Name] then
        getgenv().hats_attributes[hat.Name].att1.Parent = parent
        getgenv().hats_attributes[hat.Name].att1.Position = settings.pos
        getgenv().hats_attributes[hat.Name].att1.Rotation = settings.rot
        getgenv().hats_attributes[hat.Name].Speed1.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Speed2.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].att0.Visible = settings.debug
        if settings.bloxify and getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat
        elseif getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat.Handle
        end
    else
        getgenv().hats_attributes[hat.Name] = {att0=nil,att1=nil,Speed1=nil,Speed2=nil,mesh=nil}
        -- Handle parent
        local att0 = Instance.new("Attachment", hat.Handle) -- hat att
        att0.Position = Vector3.new(0,0,0)
        att0.Visible = settings.debug
        getgenv().hats_attributes[hat.Name].att0 = att0
        
        local att1 = Instance.new("Attachment", parent) -- parent to
        att1.Name = hat.Name
        att1.Position = settings.pos
        att1.Rotation = settings.rot
        getgenv().hats_attributes[hat.Name].att1 = att1
        
        -- Handle parent
        local AP = Instance.new("AlignPosition", hat.Handle)
        AP.Attachment0 = att0
        AP.Attachment1 = att1
        AP.RigidityEnabled = false
        AP.ReactionForceEnabled = false
        AP.ApplyAtCenterOfMass = true
        AP.MaxForce = math.huge
        AP.MaxVelocity = math.huge
        AP.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Speed1 = AP
        
        local AO = Instance.new("AlignOrientation", hat.Handle)
        AO.Attachment0 = att0
        AO.Attachment1 = att1
        AO.ReactionTorqueEnabled = false
        AO.PrimaryAxisOnly = false
        AO.MaxTorque = math.huge
        AO.MaxAngularVelocity = math.huge
        AO.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Speed2 = AO
        
        for _,mesh in pairs(hat:GetDescendants()) do
            if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
                if settings.bloxify then
                    newmesh = mesh:Clone()
                    mesh:Destroy() 
                else newmesh = mesh end
                getgenv().hats_attributes[hat.Name].mesh = newmesh
            end
        end
        
        if settings.bloxify and getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat
        elseif getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat.Handle
        end
    
        hat:SetAttribute("IsReanimated",true)
    end
    
    spawn(function()
        callback(
            getgenv().hats_attributes[hat.Name].Speed1, -- AlignPosition
            getgenv().hats_attributes[hat.Name].Speed2  -- AlignOrientation
        )
    end)
    isHatChanging = false
    
    return hat
end
getgenv().KeyBind = function(id,key,callback)
    if id == nil then print("Id must be provided");return end
    if key == nil then print("Key must be provided");return end
    if callback == nil then print("CallBack must be provided");return end
    
    if getgenv().KeyBindsss == nil then getgenv().KeyBindsss = {} end
    if getgenv().KeyBindsss[tostring(id)] then 
        getgenv().KeyBindsss[tostring(id)]:Disconnect()
    end
    if key == false then print("Keybind "..tostring(id).." disabled");return end
    local UIS = game:GetService("UserInputService")
    getgenv().KeyBindsss[tostring(id)] = UIS.InputBegan:Connect(function(a)
        if a.KeyCode.Name:lower() == key:lower() then
            callback()
        end
    end)
end
