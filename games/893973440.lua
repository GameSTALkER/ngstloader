-- Flee the Facility

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/synapse.luas/main/UiLibs/GUiLibRewrite.lua"))():CreateWin("Flee The Facility")
local guilib = lib:CreateTab({name="General"})

if _G.InstancesFTF == nil then _G.InstancesFTF = 0 end
if _G.players == nil then _G.players = false end
if _G.computers == nil then _G.computers = false end
if _G.pods == nil then _G.pods = false end

if _G.neverfailhack == nil then _G.neverfailhack = false end

--------------------------------------------------
guilib:CreateToggle({name='Players', state=_G.players, desc="Players wallhack"}, function(state) _G.players = state end)

guilib:CreateToggle({name='Computers', state=_G.computers, desc="Computers wallhack"}, function(state) _G.computers = state end)

guilib:CreateToggle({name='Pods', state=_G.pods, desc="Pods wallhack"}, function(state) _G.pods = state end)

guilib:CreateToggle({name='Never fail hacking', state=_G.neverfailhack, desc="Auto complete computer hacking"}, function(state) _G.neverfailhack = state end)

guilib:CreateBind({name="fun.",desc="funny.",key="Z"},function() game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(0) end)
-------------------------------------------------------------------

spawn (function()
	_G.InstancesFTF = _G.InstancesFTF + 1
	while true do
		if _G.InstancesFTF > 1 then
			_G.InstancesFTF = _G.InstancesFTF - 1
			break
		end
		wait(3)
			
		if game.ReplicatedStorage.CurrentMap.Value ~= nil then

		    game.Lighting.FogEnd = 5500
		    
			if workspace:findFirstChild("ESP") then
				workspace.ESP:remove()
			end
			if workspace:findFirstChild("ESPComputer") then
				workspace.ESPComputer:remove()
			end
			
			if workspace:findFirstChild("ESPPod") then
				workspace.ESPPod:remove()
			end
			
			function GetSizeOfObject(Obj)
				if Obj:IsA("BasePart") then
					return Obj.Size
				elseif Obj:IsA("Model") then
					return Obj:GetExtentsSize()
				end
			end
			
			local ESP = Instance.new("Folder",workspace)
			ESP.Name = "ESP"
			local ESPPC = Instance.new("Folder",workspace)
			ESPPC.Name = "ESPComputer"
			local ESPPod = Instance.new("Folder",workspace)
			ESPPod.Name = "ESPPod"
				
			function CreateESPPart(BodyPart,r,g,b)
				local ESPPartparent = BodyPart
				local Box = Instance.new("BoxHandleAdornment")
				Box.Size = GetSizeOfObject(ESPPartparent) + Vector3.new(.1, .1, .1)
				Box.Name = "ESPPart"
				Box.Adornee = ESPPartparent
				Box.Color3 = Color3.fromRGB(r,g,b)
				Box.AlwaysOnTop = true
				Box.ZIndex = 5
				Box.Transparency = .4
				Box.Parent = ESP
				if BodyPart.Parent.Name == game.Players.LocalPlayer.Name then
					Box:remove()
					spawn (function()
						while true do
							wait(.1)
							if BodyPart ~= nil then
								Box:remove()
							end
						end
					end)
				end
			end
			function plresp()
			    if _G.players then
			    	local player = game.Players:GetChildren()
			    	for i=1, #player do
			    		local bodyparts = player[i].Character:GetChildren()
			    		for i =1, #bodyparts do
			    			if bodyparts[i].ClassName == "Part" then
			    				if bodyparts[i].Parent:findFirstChild("BeastPowers") then
			    					CreateESPPart(bodyparts[i],133,0,0)
			    				else
			    					CreateESPPart(bodyparts[i],118,118,175)
			    				end
			    			end
			    		end
			    	end
			    end
            end
            pcall(plresp)
			function pcspds()
				if _G.computers or _G.pods then
					local map = workspace:findFirstChild(tostring(game.ReplicatedStorage.CurrentMap.Value))
					local children = map:GetChildren()
					for i =1, #children do
						if children[i].Name == "ComputerTable" and _G.computers then 
							local Box = Instance.new("BoxHandleAdornment")
							Box.Size = GetSizeOfObject(children[i].Screen) + Vector3.new(-.5, -.5, -.5)
							Box.Name = "ESPPart"
							Box.Adornee = children[i].Screen
							spawn (function()
								while true do
									wait(.1)
									Box.Color3 = children[i].Screen.Color
								end
							end)
							Box.AlwaysOnTop = true
							Box.ZIndex = 5
							Box.Transparency = .4
							Box.Parent = ESPPC
						end
						if children[i].Name == "FreezePod" and _G.pods then 
							local Box = Instance.new("BoxHandleAdornment")
							Box.Size = GetSizeOfObject(children[i].BasePart) + Vector3.new(.1, 5, .1)
							Box.Name = "ESPPart"
							Box.Adornee = children[i].BasePart
							Box.Color3 = Color3.fromRGB(50,165,215)
							Box.AlwaysOnTop = true
							Box.ZIndex = 5
							Box.Transparency = .8
							Box.Parent = ESPPod
						end
					end
				end
			end
			pcall(pcspds)
		end
	end
end)

spawn (function()
	while true do
		wait(.1)
		if _G.neverfailhack then
			game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult",true)
		end
	end
end)
