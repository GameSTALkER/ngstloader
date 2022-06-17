local Rme,hat = loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/nexoR/core.lua"))()

Rme(0)

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

weaponsType = 0
reanim.Humanoid.WalkSpeed = 12
mode=m.KeyDown:Connect(function(a)
    if a:lower() == getgenv().sprint_key:lower() and reanim.Humanoid.WalkSpeed == 12 then
        reanim.Humanoid.WalkSpeed = 21
    elseif a:lower() == getgenv().sprint_key:lower() and reanim.Humanoid.WalkSpeed ~= 12 then
        reanim.Humanoid.WalkSpeed = 12
    elseif a:lower() == getgenv().change_mode_key:lower() then
        if weaponsType >= 3 then weaponsType = 0 else weaponsType = weaponsType + 1 end
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
        if weaponsType == 1 then
            hat('Tactical Cyberpunk Railgun Sniper Rifle','Torso',CFrame.new(0,0,0),CFrame.new(-0.7+0*math["cos"](sine/10),-1+0*math["cos"](sine/10),0+0.05*math["cos"](sine/10))*CFrame.Angles(math.rad(90+1.5*math["cos"](sine/10)),math.rad(90+1*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            hat('VN9K [Pistol]','Torso',CFrame.new(0,0,0),CFrame.new(0.8+0.05*math["cos"](sine/10),0+0*math["cos"](sine/10),1.1+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+1*math["cos"](sine/10)),math.rad(0+2*math["cos"](sine/10)),math.rad(-90+0.5*math["cos"](sine/10))),false)
        elseif weaponsType == 2 then
            hat('Tactical Cyberpunk Railgun Sniper Rifle','Torso',CFrame.new(0,0,0),CFrame.new(-0.7+0*math["cos"](sine/10),-1+0*math["cos"](sine/10),0+0.05*math["cos"](sine/10))*CFrame.Angles(math.rad(90+1.5*math["cos"](sine/10)),math.rad(90+1*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            hat('Dark Cyberpunk Katana','Torso',CFrame.new(0,0,0),CFrame.new(-0.5+0*math["cos"](sine/10),-0.2+-0.05*math["cos"](sine/10),-0.6+0*math["cos"](sine/10))*CFrame.Angles(math.rad(0+3*math["cos"](sine/10)),math.rad(0+-1*math["cos"](sine/10)),math.rad(120+1*math["cos"](sine/10))),false)
        elseif weaponsType == 3 then
            hat('Dark Cyberpunk Katana','Torso',CFrame.new(0,0,0),CFrame.new(-0.5+0*math["cos"](sine/10),-0.2+-0.05*math["cos"](sine/10),-0.6+0*math["cos"](sine/10))*CFrame.Angles(math.rad(0+3*math["cos"](sine/10)),math.rad(0+-1*math["cos"](sine/10)),math.rad(120+1*math["cos"](sine/10))),false)
            hat('VN9K [Pistol]','Torso',CFrame.new(0,0,0),CFrame.new(0.8+0.05*math["cos"](sine/10),0+0*math["cos"](sine/10),1.1+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+1*math["cos"](sine/10)),math.rad(0+2*math["cos"](sine/10)),math.rad(-90+0.5*math["cos"](sine/10))),false)
        else
            hat('Tactical Cyberpunk Railgun Sniper Rifle','Torso',CFrame.new(0,0,0),CFrame.new(-0.7+0*math["cos"](sine/10),-1+0*math["cos"](sine/10),0+0.05*math["cos"](sine/10))*CFrame.Angles(math.rad(90+1.5*math["cos"](sine/10)),math.rad(90+1*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            hat('Dark Cyberpunk Katana','Torso',CFrame.new(0,0,0),CFrame.new(-0.5+0*math["cos"](sine/10),-0.2+-0.05*math["cos"](sine/10),-0.6+0*math["cos"](sine/10))*CFrame.Angles(math.rad(0+3*math["cos"](sine/10)),math.rad(0+-1*math["cos"](sine/10)),math.rad(120+1*math["cos"](sine/10))),false)
            hat('VN9K [Pistol]','Torso',CFrame.new(0,0,0),CFrame.new(0.8+0.05*math["cos"](sine/10),0+0*math["cos"](sine/10),1.1+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+1*math["cos"](sine/10)),math.rad(0+2*math["cos"](sine/10)),math.rad(-90+0.5*math["cos"](sine/10))),false)
        end

        if reanim.Humanoid.Jump then -- jump
            --jump clerp here
        elseif Root.Velocity.y < -1 and reanim.Humanoid.Jump then -- fall
            --fall clerp here
        elseif Root.Velocity.Magnitude < 2 then -- idle
            --idle clerp here
            if weaponsType == 1 then -- hands
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(8+0*math.cos(sine/10)),math.rad(-8+0*math.cos(sine/10)),math.rad(12+0*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-6+-1*math.cos(sine/10)),math.rad(10+1*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 

                hat('Dark Cyberpunk Katana','Right Arm',CFrame.new(0,0,0),CFrame.new(-1.5+0*math["cos"](sine/10),1+0*math["cos"](sine/10),-0.5+0*math["cos"](sine/10))*CFrame.Angles(math.rad(80+0*math["cos"](sine/10)),math.rad(-130+0*math["cos"](sine/10)),math.rad(250+0*math["cos"](sine/10))),false)
            elseif weaponsType == 2 then
                RS.C0=RS.C0:Lerp(CFrame.new(1.3+0.03*math.cos(sine/10),0.3+0.01*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(60+1*math.cos(sine/10)),math.rad(20+0*math.cos(sine/10)),math.rad(-55+1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.3+0.03*math.cos(sine/10),0.3+0.01*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(32+0.5*math.cos(sine/10)),math.rad(5+1*math.cos(sine/10)),math.rad(20+0.5*math.cos(sine/10))),.2) 

                hat('VN9K [Pistol]','Right Arm',CFrame.new(0,0,0),CFrame.new(1.1+0*math["cos"](sine/10),-0.55+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10)),math.rad(-90+0*math["cos"](sine/10))),false)
            elseif weaponsType == 3 then
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.1+0.06*math.cos(sine/10),0.3+0*math.cos(sine/10))*CFrame.Angles(math.rad(-145+0.5*math.cos(sine/10)),math.rad(90+1*math.cos(sine/10)),math.rad(0+-1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.1+-0.06*math.cos(sine/10),0.3+0*math.cos(sine/10))*CFrame.Angles(math.rad(-145+-0.5*math.cos(sine/10)),math.rad(90+-1*math.cos(sine/10)),math.rad(0+-1*math.cos(sine/10))),.2) 

                hat('Tactical Cyberpunk Railgun Sniper Rifle','Torso',CFrame.new(0,0,0),CFrame.new(-1+0*math["cos"](sine/10),-0.9+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(-90+0.5*math["cos"](sine/10)),math.rad(-20+-0.5*math["cos"](sine/10)),math.rad(-90+-0.5*math["cos"](sine/10))),false)
            else 
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-6+1*math.cos(sine/10)),math.rad(-10+-1*math.cos(sine/10)),math.rad(12+-1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-6+-1*math.cos(sine/10)),math.rad(10+1*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 
            end

            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-3*math.cos(sine/10)),math.rad(20+1*math.cos(sine/10)),math.rad(0+-1*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(5+0*math.cos(sine/10)),math.rad(-20+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0.01*math.cos(sine/10))*CFrame.Angles(math.rad(-5.5+0*math.cos(sine/10)),math.rad(-3+0*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0.01*math.cos(sine/10))*CFrame.Angles(math.rad(-5.5+0*math.cos(sine/10)),math.rad(18+0*math.cos(sine/10)),math.rad(1+0*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude < 20 then -- walk
            --walk clerp here
            if weaponsType == 1 then -- hands
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-18+2*math.cos(sine/10)),math.rad(-10+3*math.cos(sine/10)),math.rad(16+-1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+-0.3*math.cos(sine/10))*CFrame.Angles(math.rad(0+30*math.cos(sine/10)),math.rad(0+-20*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10))),.2) 

                hat('Dark Cyberpunk Katana','Right Arm',CFrame.new(0,0,0),CFrame.new(-1.5+0*math["cos"](sine/10),1.7+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(-116.68+0*math["cos"](sine/10)),math.rad(-170.18+0*math["cos"](sine/10)),math.rad(273.05+0*math["cos"](sine/10))),false)
            elseif weaponsType == 2 then
                RS.C0=RS.C0:Lerp(CFrame.new(1.3+0.03*math.cos(sine/10),0.3+0.01*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(60+1*math.cos(sine/10)),math.rad(20+0*math.cos(sine/10)),math.rad(-55+1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.3+0.03*math.cos(sine/10),0.3+0.01*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(32+0.5*math.cos(sine/10)),math.rad(5+1*math.cos(sine/10)),math.rad(20+0.5*math.cos(sine/10))),.2) 

                hat('VN9K [Pistol]','Right Arm',CFrame.new(0,0,0),CFrame.new(1.1+0*math["cos"](sine/10),-0.55+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10)),math.rad(-90+0*math["cos"](sine/10))),false)
            elseif weaponsType == 3 then
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0.03*math.cos(sine/10),0.5+0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(145+-2*math.cos(sine/10)),math.rad(20+1*math.cos(sine/10)),math.rad(20+-1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-6+-1*math.cos(sine/10)),math.rad(10+1*math.cos(sine/10)),math.rad(0+1*math.cos(sine/10))),.2) 

                hat('Tactical Cyberpunk Railgun Sniper Rifle','Right Arm',CFrame.new(0,0,0),CFrame.new(0.2+0*math["cos"](sine/10),-0.5+0*math["cos"](sine/10),1.9+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            else
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0.3*math.cos(sine/10))*CFrame.Angles(math.rad(0+-30*math.cos(sine/10)),math.rad(0+-20*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+-0.3*math.cos(sine/10))*CFrame.Angles(math.rad(0+30*math.cos(sine/10)),math.rad(0+-20*math.cos(sine/10)),math.rad(0+5*math.cos(sine/10))),.2) 
            end

            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(1.5+0*math.cos(sine/10)),math.rad(0+3*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-2+0*math.cos(sine/10)),math.rad(0+-3*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+30*math.cos(sine/10)),math.rad(0+3*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+-0.1*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(0+-30*math.cos(sine/10)),math.rad(0+3*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10))),.2)
        elseif Root.Velocity.Magnitude > 20 then -- run
            --run clerp here
            if weaponsType == 1 then -- hands
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(70+-1*math.cos(sine/10)),math.rad(70+1*math.cos(sine/10)),math.rad(-2+1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-45+2*math.cos(sine/10)),math.rad(12+2*math.cos(sine/10)),math.rad(-8+1*math.cos(sine/10))),.2) 

                hat('Dark Cyberpunk Katana','Right Arm',CFrame.new(0,0,0),CFrame.new(-1.5+0*math["cos"](sine/10),1+0*math["cos"](sine/10),-0.5+0*math["cos"](sine/10))*CFrame.Angles(math.rad(80+0*math["cos"](sine/10)),math.rad(-130+0*math["cos"](sine/10)),math.rad(250+0*math["cos"](sine/10))),false)
            elseif weaponsType == 2 then
                RS.C0=RS.C0:Lerp(CFrame.new(1.3+0.03*math.cos(sine/10),0.3+0.01*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(60+1*math.cos(sine/10)),math.rad(20+0*math.cos(sine/10)),math.rad(-55+1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.3+0.03*math.cos(sine/10),0.3+0.01*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(32+0.5*math.cos(sine/10)),math.rad(5+1*math.cos(sine/10)),math.rad(20+0.5*math.cos(sine/10))),.2) 

                hat('VN9K [Pistol]','Right Arm',CFrame.new(0,0,0),CFrame.new(1.1+0*math["cos"](sine/10),-0.55+0*math["cos"](sine/10),0+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10)),math.rad(-90+0*math["cos"](sine/10))),false)
            elseif weaponsType == 3 then
                RS.C0=RS.C0:Lerp(CFrame.new(1.3+0*math.cos(sine/10),0.4+0*math.cos(sine/10),-0.8+0*math.cos(sine/10))*CFrame.Angles(math.rad(90+2*math.cos(sine/10)),math.rad(15+-1*math.cos(sine/10)),math.rad(-62+1*math.cos(sine/10))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.3+0*math.cos(sine/10),0.3+0*math.cos(sine/10),-0.5+0*math.cos(sine/10))*CFrame.Angles(math.rad(55+2*math.cos(sine/10)),math.rad(0+0*math.cos(sine/10)),math.rad(10+1*math.cos(sine/10))),.2) 

                hat('Tactical Cyberpunk Railgun Sniper Rifle','Right Arm',CFrame.new(0,0,0),CFrame.new(0.2+0*math["cos"](sine/10),-0.5+0*math["cos"](sine/10),1.9+0*math["cos"](sine/10))*CFrame.Angles(math.rad(90+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10)),math.rad(0+0*math["cos"](sine/10))),false)
            else
                RS.C0=RS.C0:Lerp(CFrame.new(1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+35*math.sin(sine/5)),math.rad(0+20*math.sin(sine/5)),math.rad(0+-15*math.sin(sine/5))),.2) 
                LS.C0=LS.C0:Lerp(CFrame.new(-1.5+0*math.cos(sine/10),0.5+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-5+-35*math.sin(sine/5)),math.rad(0+20*math.sin(sine/5)),math.rad(0+-15*math.sin(sine/5))),.2) 
            end

            NECK.C0=NECK.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),1+0*math.cos(sine/10),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(10+0*math.cos(sine/10)),math.rad(0+-4*math.sin(sine/5)),math.rad(0+0*math.cos(sine/10))),.2) 
            RJ.C0=RJ.C0:Lerp(CFrame.new(0+0*math.cos(sine/10),-1+0.05*math.sin(sine/5),0+0*math.cos(sine/10))*CFrame.Angles(math.rad(-15+0*math.cos(sine/10)),math.rad(0+5*math.sin(sine/5)),math.rad(0+0*math.cos(sine/10))),.2) 
            RH.C0=RH.C0:Lerp(CFrame.new(0.5+0*math.cos(sine/10),-1+-0.2*math.sin(sine/5),-0.5+0.5*math.sin(sine/5))*CFrame.Angles(math.rad(0+-35*math.sin(sine/5)),math.rad(0+-5*math.sin(sine/5)),math.rad(0+0*math.cos(sine/10))),.2) 
            LH.C0=LH.C0:Lerp(CFrame.new(-0.5+0*math.cos(sine/10),-1+0.2*math.sin(sine/5),-0.5+-0.5*math.sin(sine/5))*CFrame.Angles(math.rad(0+35*math.sin(sine/5)),math.rad(0+-5*math.sin(sine/5)),math.rad(0+0*math.cos(sine/10))),.2)
        end
        srv.RenderStepped:Wait()
    end
end)()
