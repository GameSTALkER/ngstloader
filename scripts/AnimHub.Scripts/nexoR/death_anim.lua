local Rme,hat = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/nexoR/core.lua"))()

Rme(1)

if getgenv().change_mode_key == nil then getgenv().change_mode_key = "q" end
if getgenv().sprint_key == nil then getgenv().sprint_key = "z" end

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

Mode = 0
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 8
mode=m.KeyDown:Connect(function(a)
    if a == getgenv().sprint_key:lower() and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed == 21 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 8
    elseif a == getgenv().sprint_key:lower() then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 21
    elseif a == getgenv().changemode_key:lower() then
        if Mode == 1 then Mode = 0 else Mode = 1 end
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

        if Mode == 1 then -- attack
            hat('Volcanic Scythe','Right Arm',CFrame.new(0,0,0),CFrame.new(-2+0*math["cos"](sine/10),-0.8+0*math["cos"](sine/10),0.4+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(-60+0*math["cos"](sine/10)),math.rad(74.36+0*math["cos"](sine/10))),false)
            RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+1*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(90+95*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(-25+50*math.cos(sine/10))),.2) 
            LS.C0=LS.C0:Lerp(CFrame.new(-0.68+0*math.cos(sine/10),0.5+1*math.cos(sine/10),-1+0*math.cos(sine/10))*CFrame.Angles(math.rad(90+95*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(65+20*math.cos(sine/10))),.2) 
        end

        if reanim.Humanoid.Jump then -- jump
            --jump clerp here
        elseif Root.Velocity.y < -1 and reanim.Humanoid.Jump then -- fall
            --fall clerp here
        elseif Root.Velocity.Magnitude < 2 then -- idle
            --idle clerp here
            if Mode ~= 1 then
                hat('Volcanic Scythe','Right Arm',CFrame.new(0,0,0),CFrame.new(-2+0*math["cos"](sine/10),-0.6+0*math["cos"](sine/10),0.5+0*math["cos"](sine/10))*CFrame.Angles(math.rad(127.85+0*math["cos"](sine/10)),math.rad(-63.19+0*math["cos"](sine/10)),math.rad(82+0*math["cos"](sine/10))),false)
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0.1*math.sin(sine/20),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(50+1*math.sin(sine/20)),math.rad(35+-5*math.sin(sine/20)),math.rad(-15+0*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+-0.1*math.sin(sine/20),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(70+0*math.cos(sine/10)),math.rad(50+0*math.cos(sine/10)),math.rad(0+-10*math.sin(sine/20))),.2) 
            end
            hat('black metal wings','Torso',CFrame.new(0,0,0),CFrame.new(-2+0*math["cos"](sine/10),-1+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(5+0*math["cos"](sine/10)),math.rad(180+0*math["cos"](sine/10)),math.rad(-47.91+0*math["cos"](sine/10))),false)
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+-0.1*math.sin(sine/15),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+1*math.sin(sine/25)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0.1*math.sin(sine/15),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-1*math.sin(sine/25)),math.rad(-15+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+0.1*math.sin(sine/15),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-1*math.sin(sine/25)),math.rad(5+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude < 20 then -- walk
            --walk clerp here
            if Mode ~= 1 then
                hat('Volcanic Scythe','Right Arm',CFrame.new(0,0,0),CFrame.new(-1.5+0*math["cos"](sine/10),-0.6+0*math["cos"](sine/10),0.3+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(-135+0*math["cos"](sine/10)),math.rad(90+0*math["cos"](sine/10))),false)
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(50+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(5+0*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+30*math.cos(sine/10)),math.rad(0+1*math.sin(sine/10)),math.rad(-5+1*math.sin(sine/10))),.2) 
            end
            hat('black metal wings','Torso',CFrame.new(0,0,0),CFrame.new(-2.5+0*math["cos"](sine/10),-1.5+0*math["cos"](sine/10),-0.5+0*math["cos"](sine/10))*CFrame.Angles(math.rad(30+0*math["cos"](sine/10)),math.rad(150+1*math["cos"](sine/10)),math.rad(-45+1*math["cos"](sine/10))),false)
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0.1*math.sin(sine/25),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-3+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0.1*math.sin(sine/25),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+35*math.sin(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.sin(sine/25),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-35*math.sin(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude > 20 then -- run
            --run clerp here
            if Mode ~= 1 then
                hat('Volcanic Scythe','Right Arm',CFrame.new(0,0,0),CFrame.new(-1.76+0*math["cos"](sine/10),-0.5+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(-90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10)),math.rad(90+0*math["cos"](sine/10))),false)
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+-0.15*math.sin(sine/20),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-10+-1*math.cos(sine/10)),math.rad(-6+0*math.cos(sine/10)),math.rad(8+0*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+-0.15*math.sin(sine/20),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-30+5*math.sin(sine/5)),math.rad(15+0*math.cos(sine/10)),math.rad(-15+0*math.cos(sine/20))),.2) 
            end
            hat('black metal wings','Torso',CFrame.new(0,0,0),CFrame.new(-3+0*math["cos"](sine/10),-1+0*math["cos"](sine/10),-0.3+0*math["cos"](sine/10))*CFrame.Angles(math.rad(-15+0*math["cos"](sine/10)),math.rad(150+-15*math["sin"](sine/5)),math.rad(-10+0*math["cos"](sine/10))),false)
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),0+0.1*math.sin(sine/20),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-15+1*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0.1*math.sin(sine/-20),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-25+5*math.sin(sine/5)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.2*math.sin(sine/-20),-0.8+0*math.cos(sine/10))*CFrame.Angles(math.rad(-25+5*math.sin(sine/5)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
        end
        srv.RenderStepped:Wait()
    end
end)()
