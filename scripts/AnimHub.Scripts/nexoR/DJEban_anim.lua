local Rme,hat = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/nexoR/core.lua"))()

Rme()

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

speed = 1
sine = 1
srv = game:GetService('RunService')

reanim = game.Players.LocalPlayer.Character

m=game.Players.LocalPlayer:GetMouse()
RJ = reanim.HumanoidRootPart.RootJoint
RS = reanim.Torso['Right Shoulder']
LS = reanim.Torso['Left Shoulder']
RH = reanim.Torso['Right Hip']
LH = reanim.Torso['Left Hip']
Root = reanim.HumanoidRootPart
NECK = reanim.Torso.Neck
NECK.C0 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
NECK.C1 = CF(0,-0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RJ.C1 = CF(0,-1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RJ.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RS.C1 = CF(0,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LS.C1 = CF(0,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))

ModeChange = 'off'
ModeChange2 = 'off'
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 8
mode=m.KeyDown:Connect(function(a)
if a == getgenv().change_mode_key:lower() and ModeChange == 'off' then
ModeChange = 'on'
elseif a == getgenv().change_mode_key:lower() and ModeChange == 'on' then
ModeChange = 'off'
elseif a == getgenv().hand_move_key:lower() and ModeChange2 == "off" then
    ModeChange2 = 'on'
elseif a == getgenv().hand_move_key:lower() and ModeChange2 == "on" then
    ModeChange2 = 'off'
elseif a == getgenv().sprint_key:lower() then
if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed == 8 then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 21 else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 8 end
end
end)

coroutine.wrap(function()
    while true do -- anim changer
        if HumanDied then mode:Disconnect();break end
        sine = sine + speed
        local rlegray = Ray.new(reanim["Right Leg"].Position + Vector3.new(0, 0.5, 0), Vector3.new(0, -2, 0))
        local rlegpart, rlegendPoint = workspace:FindPartOnRay(rlegray, char)
        local llegray = Ray.new(reanim["Left Leg"].Position + Vector3.new(0, 0.5, 0), Vector3.new(0, -2, 0))
        local llegpart, llegendPoint = workspace:FindPartOnRay(llegray, char)
        local rightvector = (Root.Velocity * Root.CFrame.rightVector).X + (Root.Velocity * Root.CFrame.rightVector).Z
        local lookvector = (Root.Velocity * Root.CFrame.lookVector).X + (Root.Velocity * Root.CFrame.lookVector).Z
        if lookvector > reanim.Humanoid.WalkSpeed then
            lookvector = reanim.Humanoid.WalkSpeed
        end
        if lookvector < -reanim.Humanoid.WalkSpeed then
            lookvector = -reanim.Humanoid.WalkSpeed
        end
        if rightvector > reanim.Humanoid.WalkSpeed then
            rightvector = reanim.Humanoid.WalkSpeed
        end
        if rightvector < -reanim.Humanoid.WalkSpeed then
            rightvector = -reanim.Humanoid.WalkSpeed
        end
        local lookvel = lookvector / reanim.Humanoid.WalkSpeed
        local rightvel = rightvector / reanim.Humanoid.WalkSpeed
        if ModeChange == "on" then
            hat('BoomBox','Torso',CFrame.new(0,0,0),CFrame.new(0.3+0*math["cos"](sine/10),-1.5+0*math["cos"](sine/10),-1+0*math["cos"](sine/10))*CFrame.Angles(math.rad(0+0*math["cos"](sine/10)),math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            if reanim.Humanoid.Jump then -- jump
                --jump clerp here
            elseif Root.Velocity.y < -1 and reanim.Humanoid.Jump then -- fall
                --fall clerp here
            elseif Root.Velocity.Magnitude < 2 then -- idle
                --idle clerp here
                NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0.1*math.sin(sine/30),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(5+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                if ModeChange2 == "off" then
                    RS.C0=RS.C0:Lerp(CFrame.new(1.5+0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(-9.7+0*math.cos(sine/10)),math.rad(5+3*math.sin(sine/50))),.2) 
                else RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),1+0.3*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(180+30*math.sin(sine/5)),math.rad(0+15*math.sin(sine/5)),math.rad(0+-10*math.sin(sine/5))),.2) 
                end
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+-0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(166.06+1*math.cos(sine/10)),math.rad(13.23+0.5*math.cos(sine/10)),math.rad(-9.7+0.5*math.cos(sine/10))),.2) 
                RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.1*math.sin(sine/30),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+0*math.cos(sine/10)),math.rad(-10+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.sin(sine/30),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+0*math.cos(sine/10)),math.rad(10+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
            elseif Root.Velocity.Magnitude < 20 then -- walk
                --walk clerp here
                NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+0*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10)),math.rad(0+-2*math.cos(sine/10))),.2) 
                RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.sin(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(5+0*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 
                if ModeChange2 == "off" then
                    RS.C0=RS.C0:Lerp(CFrame.new(1.5+0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-15*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(5+3*math.cos(sine/10))),.2) 
                else RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),1+0.3*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(180+30*math.sin(sine/5)),math.rad(0+15*math.sin(sine/5)),math.rad(0+-10*math.sin(sine/5))),.2) 
                end
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+-0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(166.06+1*math.cos(sine/10)),math.rad(13.23+0.5*math.cos(sine/10)),math.rad(-9.7+0.5*math.cos(sine/10))),.2) 
                RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+30*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+-30*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
            elseif Root.Velocity.Magnitude > 20 then -- run
                --run clerp here
                NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(8+0*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10)),math.rad(0+2*math.cos(sine/10))),.2) 
                RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-10+0*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                if ModeChange2 == "off" then
                    RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+25*math.cos(sine/10)),math.rad(0+15*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10))),.2) 
                else RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),1+0.3*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(180+30*math.sin(sine/5)),math.rad(0+15*math.sin(sine/5)),math.rad(0+-10*math.sin(sine/5))),.2) 
                end
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+-0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(166.06+1*math.cos(sine/10)),math.rad(13.23+0.5*math.cos(sine/10)),math.rad(-9.7+0.5*math.cos(sine/10))),.2) 
                RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(10+-35*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10))),.2) 
                LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(10+35*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10))),.2)
            end
        elseif ModeChange == "off" then
            hat('BoomBox','Left Arm',CFrame.new(0,0,0),CFrame.new(-0.5+0*math["cos"](sine/10),1.5+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(0+0*math["cos"](sine/10)),math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            if reanim.Humanoid.Jump then -- jump
                --jump clerp here
            elseif Root.Velocity.y < -1 and reanim.Humanoid.Jump then -- fall
                --fall clerp here
            elseif Root.Velocity.Magnitude < 2 then -- idle
                --idle clerp here
                NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0.1*math.sin(sine/30),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(5+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                if ModeChange2 == "off" then
                    RS.C0=RS.C0:Lerp(CFrame.new(1.5+0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(-9.7+0*math.cos(sine/10)),math.rad(5+3*math.sin(sine/50))),.2) 
                else RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),1+0.3*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(180+30*math.sin(sine/5)),math.rad(0+15*math.sin(sine/5)),math.rad(0+-10*math.sin(sine/5))),.2) 
                end
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+-0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(20+1*math.cos(sine/10)),math.rad(5+0.5*math.cos(sine/10)),math.rad(-2+0.5*math.cos(sine/10))),.2) 
                RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.1*math.sin(sine/30),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+0*math.cos(sine/10)),math.rad(-10+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.sin(sine/30),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+0*math.cos(sine/10)),math.rad(10+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
            elseif Root.Velocity.Magnitude < 20 then -- walk
                --walk clerp here
                NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+0*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10)),math.rad(0+-2*math.cos(sine/10))),.2) 
                RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.sin(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(5+0*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 
                if ModeChange2 == "off" then
                    RS.C0=RS.C0:Lerp(CFrame.new(1.5+0.01*math.cos(sine/10),0.5+0.01*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-15*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(5+3*math.cos(sine/10))),.2) 
                else RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),1+0.3*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(180+30*math.sin(sine/5)),math.rad(0+15*math.sin(sine/5)),math.rad(0+-10*math.sin(sine/5))),.2) 
                end
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(20+-3*math.cos(sine/10)),math.rad(5+0.5*math.cos(sine/10)),math.rad(-2+0.5*math.cos(sine/10))),.2) 
                RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+30*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+-30*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
            elseif Root.Velocity.Magnitude > 20 then -- run
                --run clerp here
                NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(8+0*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10)),math.rad(0+2*math.cos(sine/10))),.2) 
                RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-10+0*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
                if ModeChange2 == "off" then
                    RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+25*math.cos(sine/10)),math.rad(0+15*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10))),.2) 
                else RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),1+0.3*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(180+30*math.sin(sine/5)),math.rad(0+15*math.sin(sine/5)),math.rad(0+-10*math.sin(sine/5))),.2) 
                end
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(15+-3*math.cos(sine/10)),math.rad(15+0*math.cos(sine/10)),math.rad(-10+2*math.cos(sine/10))),.2) 
                RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(10+-35*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10))),.2) 
                LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(10+35*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10)),math.rad(0+-5*math.cos(sine/10))),.2)
            end
        end
        srv.RenderStepped:Wait()
    end
end)()
