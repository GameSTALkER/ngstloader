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
