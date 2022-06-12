--[[ UtilLib

neededhats(hats: table, returntype: "string" or nil)
 returntype: return value at "string"-string or "table"-nil type only if some hats is not found
 
CFG(location: string, action: table(save) or string(load))

]]--

getgenv().neededhats = function(nht,returntype) -- table, available args: "string", nil
	if returntype == nil then returntype = "table" end
	if nht == nil then warn("UtilLib | Error: getgenv().neededhats("..nht..")\n                        you forgot to add argumet (table) - ^^^"); return end
	if type(nht) ~= "table" then warn("UtilLib | Error: getgenv().neededhats("..nht..")\n           that argument must be \"table\" type - ^^^"); return end
	
	local plr = game:GetService("Players").LocalPlayer
	local plrbody = plr.Character
	local havehatsnum = 0
	local hatsactive = {}
	
	for i,v in pairs(plrbody:GetChildren()) do
		if v.ClassName == "Accessory" then
			havehatsnum = havehatsnum + 1
		end
	end
	
	for i,v in pairs(plrbody:GetChildren()) do
		for q,w in pairs(nht) do
            if type(w) == "string" then
			    if v.ClassName == "Accessory" and w == v.Name then
			    	table.insert(hatsactive,v.Name)
			    end
            elseif type(w) == "table" then
                for e,r in pairs(w) do
			        if v.ClassName == "Accessory" and r == v.Name then
			        	table.insert(hatsactive,v.Name)
			        end
                end
            else warn("UtilLib | Error: "..w.."("..q..") is unsupported type | getgenv().neededhats") end
		end
	end
	
	local allisdone = true
	local neededhatstoactive = {}
	if returntype == "string" then neededhatstoactive = "" end
	local _num = 0
	for i,v in pairs(nht) do
        if type(v) == "string" then
		    if not table.find(hatsactive,v) then
		    	_num = _num + 1
		    	warn("UtilLib: Need \""..v.."\" hat for script work.")
		    	if returntype == "string" then 
		    		if havehatsnum == _num then neededhatstoactive = neededhatstoactive..v else neededhatstoactive = neededhatstoactive..v.."\n" end 
		    	else
		    		table.insert(neededhatstoactive,v)
		    	end
		    	allisdone = false
		    end
        
        elseif type(v) == "table" then
            local sifud = ""
            for q,w in pairs(v) do
                if sifud == "" then sifud = w else sifud = sifud.." or "..w end
		        if not table.find(hatsactive,w) and q == #v then
		        	_num = _num + 1
		        	warn("UtilLib: Need "..sifud.." hat for script work.")
		        	if returntype == "string" then 
		        		if havehatsnum == _num then neededhatstoactive = neededhatstoactive..w else neededhatstoactive = neededhatstoactive..w.."\n" end 
		        	else
		        		table.insert(neededhatstoactive,v)
		        	end
		        	allisdone = false
		        end
            end
        end
	end
	if allisdone then return true else return neededhatstoactive end
end

getgenv().CFG = function(location, action)
    if location == nil then location = tostring(game.PlaceId)..".gstconfig" end
    if action == nil then action = "get" end

    local folder = "nGSTLoader" -- root folder
    local HttpService = game:GetService("HttpService")
    
    if not isfolder(folder) then makefolder(folder) end -- root folder
    if not isfolder(folder..game.PlaceId) then makefolder(folder..game.PlaceId) end -- root/game folder
    if not isfile(folder..game.PlaceId..location) then writefile(folder..game.PlaceId..location, "{}") end -- root/game/%location folder

    if type(action) == "table" then -- save
        local data = HttpService:JSONEncode(action)
        writefile(folder..game.PlaceId..location, data)
    else -- load
        local raw_string = readfile(folder..game.PlaceId..location)
        local data = HttpService:JSONDecode(raw_string)
        return data
    end

end
