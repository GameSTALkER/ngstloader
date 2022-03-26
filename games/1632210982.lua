-- Zombie Attack

_G.anal = false
if _G.eim == nil then _G.eim = false end
if _G.PYSSIDESTOIER then _G.PYSSIDESTOIER:Disconnect() end

local main = ngstloader:AddMenu("Zombie Attack")
main = main:AddTab("Main")

main:CreateToggle({name='Auto PowerUps pickup'}, function(state)
    _G.anal = state
    local me = game.Workspace[game.Players.LocalPlayer.Name].HumanoidRootPart
    spawn(function()
        while wait() do
            if not _G.anal then break end
            pcall(function()
                for _,v in pairs(game.Workspace.Powerups:GetDescendants()) do
                    if v.Name == "TouchInterest" and v.Parent then
                        v.Parent.CFrame = me.CFrame
                    end
                end
            end)
        end
    end)
end)

main:CreateButton({name='Silent Aim'}, function()
    if not _G.eim then
        local me = game.Players.LocalPlayer
        local hed = "Head"
        local func = function()
            local aim = math.huge
            local no = nil
            for _, v in next, game.Workspace:GetDescendants() do
                if v:FindFirstChild(hed) and me.Character:FindFirstChild(hed) and not v:FindFirstChild("Guns") and v.Parent.Name ~= "deadenemies" then
                    local new_aim = (v:FindFirstChild(hed).Position - me.Character.Head.Position).magnitude
                    if new_aim < aim then
                        aim = new_aim
                        no = v
                    end
                end
            end
            return no
        end
        local mouse = me:GetMouse()
        local game_table = getrawmetatable(game)
        local game_index = game_table.__index
        setreadonly(game_table, false)
        game_table.__index = newcclosure(function(_1, _2)
                if _1 == mouse and tostring(_2) == "Hit" then
                    return func():FindFirstChild(hed).CFrame
                end
                return game_index(_1, _2)
            end
        )
        setreadonly(game_table, true)
        _G.eim = true
    end
end)
