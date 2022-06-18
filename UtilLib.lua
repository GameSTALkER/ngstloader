--[[ UtilLib

neededhats(hats: table, returntype: "string" or nil)
 returntype: return value at "string"-string or "table"-nil type only if some hats is not found
 
CFG(location: string, action: table(save) or string(load))

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

getgenv().Accessory = function(hatName,parent,settings)
    
    local default_settings = {
        -- core settings
        debug = true; -- print information in console
        bloxify = false; -- from normal UGS to gray block (R6 only)
        speed = 100;
        
        pos = Vector3.new(0,0,0);
        rot = Vector3.new(0,0,0);
    }
    local function neededType(value,ntype)
        if type(value) == ntype then 
            return true 
        elseif rstr == nil then 
            return false 
        end
    end
    
    if hatName == nil then print("hatName can't be nil.");return nil end
    if parent == nil then print("parent can't be nil.");return nil end
    if type(settings) ~= "table" then 
        print("loaded default settings.")
        settings = default_settings
    else
        for i,v in pairs(settings) do
            if (i:lower() == "debug") and neededType(v,"boolean") then 
                default_settings.debug = v
            elseif (i:lower() == "bloxify" or i:lower() == "mesh") and neededType(v,"boolean") then
                default_settings.bloxify = v
            elseif (i:lower() == "speed") and neededType(v,"number") then 
                default_settings.speed = v
            elseif (i:lower() == "pos" or i:lower() == "position" or i:lower() == "p") and neededType(v,"vector") then 
                default_settings.pos = v
            elseif (i:lower() == "rot" or i:lower() == "rotation" or i:lower() == "r") and neededType(v,"vector") then 
                default_settings.rot = v
            else print(i.."="..tostring(v).."("..type(v)..") is unknown or has incorrect value type.")
            end
        end
        settings = default_settings
    end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/Universal/netless.lua"))()
    local function debug(str) if settings.debug then print(tostring(str)) end end
    
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character
    
    local hat = nil
    if getgenv().hats_attributes == nil then getgenv().hats_attributes = {} end
    for i,v in pairs(Character.Humanoid:GetAccessories()) do
        if v.Name == hatName then hat = v end
    end
    if hat == nil then print("Hat not found."); return nil end
    pcall(function() hat.Handle.AccessoryWeld:Destroy() end)
    local temp_mesh = nil
    for _,mesh in pairs(hat:GetDescendants()) do
        if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
            temp_mesh = mesh
        end
    end
    if hat:GetAttribute("IsReanimated") == true and getgenv().hats_attributes[hat.Name] then
        getgenv().hats_attributes[hat.Name].att1.Parent = parent
        getgenv().hats_attributes[hat.Name].att1.Position = settings.pos
        getgenv().hats_attributes[hat.Name].att1.Rotation = settings.rot
        getgenv().hats_attributes[hat.Name].Speed1.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Speed2.Responsiveness = settings.speed
        if settings.bloxify then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat
        else 
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat.Handle
        end
    else
        getgenv().hats_attributes[hat.Name] = {att0=nil,att1=nil,Speed1=nil,Speed2=nil,mesh=temp_mesh}
        -- Handle parent
        local att0 = Instance.new("Attachment", hat.Handle) -- hat att
        att0.Position = Vector3.new(0,0,0)
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
        
        if settings.bloxify then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat
        else 
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat.Handle
        end
    
        hat:SetAttribute("IsReanimated",true)
    end
    return hat
end
