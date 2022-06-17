local Rme,hat = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/nexoR/core.lua"))();Rme()

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

coroutine.wrap(function()
    while true do -- anim changer
        if HumanDied then break end
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
        if reanim.Humanoid.Jump then -- jump
            --jump clerp here
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(20.87+2*math.sin(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.sin(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-10+0*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10)),math.rad(0+1*math.sin(sine/8))),.2) 
            RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-32.62+1*math.sin(sine/8)),math.rad(13.23+1*math.sin(sine/8)),math.rad(-2.06+1*math.sin(sine/8))),.2) 
            LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-32.62+3*math.cos(sine/10)),math.rad(36.15+2*math.cos(sine/10)),math.rad(-9.7+-1*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-9.7+2*math.cos(sine/10)),math.rad(-15+3*math.cos(sine/10)),math.rad(2+1*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10))*CFrame.Angles(math.rad(-2.06+-3*math.cos(sine/10)),math.rad(5.58+-2*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2)
        elseif Root.Velocity.y < -1 and reanim.Humanoid.Jump then -- fall
            --fall clerp here
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-30+1*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+-1*math.cos(sine/8))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+-0.2*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(15+-1*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 
            RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-47.91+1*math.cos(sine/10)),math.rad(13.23+2*math.cos(sine/10)),math.rad(-2.06+1*math.cos(sine/10))),.2) 
            LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-9.7+1*math.cos(sine/10)),math.rad(-40.27+2*math.cos(sine/10)),math.rad(-78.48+1*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-17.34+1*math.cos(sine/10)),math.rad(-9.7+2*math.cos(sine/10)),math.rad(2+-3*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.6+0*math.cos(sine/10),-0.5+0*math.cos(sine/10),-0.7+0*math.cos(sine/10))*CFrame.Angles(math.rad(-3+-2.06*math.cos(sine/10)),math.rad(20.87+-1*math.cos(sine/10)),math.rad(-2+1*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude < 2 then -- idle
            --idle clerp here
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-9.7+-1*math.cos(sine/10)),math.rad(13.23+0*math.cos(sine/10)),math.rad(3+1*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(6+1*math.cos(sine/10)),math.rad(-17+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-24.98+1*math.cos(sine/10)),math.rad(36.15+2*math.cos(sine/10)),math.rad(-32.62+0*math.cos(sine/10))),.2) 
            LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.3+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(20.87+0*math.cos(sine/10)),math.rad(-24.98+-1*math.cos(sine/10)),math.rad(13.23+-1*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-9.7+-1*math.cos(sine/10)),math.rad(-17.34+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-8+0*math.cos(sine/100)),math.rad(28+0*math.cos(sine/10)),math.rad(-2.06+0*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude < 20 then -- walk
            --walk clerp here
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(5.58+-2*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+-1*math.cos(sine/50))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-10+2*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-32.62+-2*math.cos(sine/10)),math.rad(28.51+2*math.cos(sine/10)),math.rad(-17.34+-1*math.cos(sine/10))),.2) 
            LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(15+20*math.cos(sine/10)),math.rad(0+-30*math.cos(sine/10)),math.rad(0+10*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0.1*math.cos(sine/10),-1+0.3*math.sin(sine/-10),-0.3+-0.3*math.cos(sine/10))*CFrame.Angles(math.rad(0+20*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.3*math.sin(sine/-10),-0.3+0.3*math.cos(sine/10))*CFrame.Angles(math.rad(0+-20*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude > 20 then -- run
            --run clerp here
            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-2.06*math.cos(sine/10)),math.rad(13.23+-2.06*math.cos(sine/10)),math.rad(0+-2.06*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),0+-0.14*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-17.34+-1.5*math.cos(sine/10)),math.rad(-17.34+1*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 
            RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-24.98+0*math.cos(sine/10)),math.rad(20.87+0*math.cos(sine/10)),math.rad(0+-2.06*math.cos(sine/10))),.2) 
            LS.C0=LS.C0:Lerp(CFrame.new(-1.22+0*math.cos(sine/10),0.6+-0.14*math.cos(sine/10),-1+0*math.cos(sine/10))*CFrame.Angles(math.rad(143.14+-9.7*math.cos(sine/10)),math.rad(-2.06+0*math.cos(sine/10)),math.rad(66.72+1*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-17.34+5.58*math.cos(sine/10)),math.rad(-2.06+0*math.cos(sine/10)),math.rad(-8+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-0.3+-0.1*math.cos(sine/10),-0.68+0*math.cos(sine/10))*CFrame.Angles(math.rad(-9.7+-2.06*math.cos(sine/10)),math.rad(13.23+0*math.cos(sine/10)),math.rad(5.58+0*math.cos(sine/10))),.2)
        end
        srv.RenderStepped:Wait()
    end
end)()
