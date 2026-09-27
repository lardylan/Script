local P=game:GetService("Players")
local U=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local SS=game:GetService("SoundService")
local pl=P.LocalPlayer
local pg=pl:WaitForChild("PlayerGui")

local old=pg:FindFirstChild("NexxuzHub")
if old then old:Destroy() end

local G=Instance.new("ScreenGui",pg)
G.Name="NexxuzHub"
G.ResetOnSpawn=false

local function C(x)
	local c=Instance.new("UICorner",x)
	c.CornerRadius=UDim.new(0,12)
end

local function R(x)
	local s=Instance.new("UIStroke",x)
	s.Thickness=2
	task.spawn(function()
		local h=0
		while s.Parent do
			h=(h+.01)%1
			s.Color=Color3.fromHSV(h,1,1)
			task.wait()
		end
	end)
end

local function B(p,t,pos,size)
	local b=Instance.new("TextButton",p)
	b.Text=t
	b.Size=size
	b.Position=pos
	b.BackgroundColor3=Color3.fromRGB(18,18,18)
	b.BorderSizePixel=0
	b.TextColor3=Color3.new(1,1,1)
	b.TextScaled=true
	b.Font=Enum.Font.GothamBold
	C(b) R(b)
	return b
end

local function Drag(f)
	local down,start,pos
	f.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
			down=true start=i.Position pos=f.Position
		end
	end)
	U.InputChanged:Connect(function(i)
		if down and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
			local d=i.Position-start
			f.Position=UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
		end
	end)
	U.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
			down=false
		end
	end)
end

-- KEY

local key=Instance.new("Frame",G)
key.Size=UDim2.fromOffset(350,220)
key.Position=UDim2.new(.5,-175,.5,-110)
key.BackgroundColor3=Color3.fromRGB(5,5,5)
key.BorderSizePixel=0
C(key) R(key) Drag(key)

local title=Instance.new("TextLabel",key)
title.Size=UDim2.new(1,0,0,40)
title.Position=UDim2.fromOffset(0,20)
title.BackgroundTransparency=1
title.Text="Nexxuz Hub | Lardylan"
title.TextColor3=Color3.new(1,1,1)
title.TextScaled=true
title.Font=Enum.Font.GothamBold

local ver=Instance.new("TextLabel",key)
ver.Size=UDim2.new(1,0,0,25)
ver.Position=UDim2.fromOffset(0,58)
ver.BackgroundTransparency=1
ver.Text="DMvsS V2"
ver.TextColor3=Color3.fromRGB(150,150,150)
ver.TextScaled=true

local box=Instance.new("TextBox",key)
box.Size=UDim2.new(1,-30,0,40)
box.Position=UDim2.fromOffset(15,90)
box.BackgroundColor3=Color3.fromRGB(20,20,20)
box.BorderSizePixel=0
box.PlaceholderText="INTRODUCE LA KEY"
box.Text=""
box.TextColor3=Color3.new(1,1,1)
box.TextScaled=true
C(box) R(box)

local get=B(key,"GET KEY",UDim2.fromOffset(15,145),UDim2.fromOffset(155,42))
local login=B(key,"LOGIN",UDim2.fromOffset(180,145),UDim2.fromOffset(155,42))

get.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://pastebin.com/raw/0jBevTEu")
	end
	get.Text="COPIADO ✅"
	task.wait(1)
	get.Text="GET KEY"
end)

login.MouseButton1Click:Connect(function()
	if box.Text~="Delta. TP" then
		login.Text="KEY INCORRECTA ❌"
		task.wait(1)
		login.Text="LOGIN"
		return
	end

	key:Destroy()

	-- MAIN

	local main=Instance.new("Frame",G)
	main.Size=UDim2.fromOffset(390,290)
	main.Position=UDim2.new(.5,-195,.5,-145)
	main.BackgroundColor3=Color3.fromRGB(5,5,5)
	main.BorderSizePixel=0
	C(main) R(main) Drag(main)

	local t=Instance.new("TextLabel",main)
	t.Size=UDim2.new(1,-50,0,35)
	t.Position=UDim2.fromOffset(10,8)
	t.BackgroundTransparency=1
	t.Text="Nexxuz Hub | Lardylan"
	t.TextColor3=Color3.new(1,1,1)
	t.TextScaled=true
	t.Font=Enum.Font.GothamBold

	local v=Instance.new("TextLabel",main)
	v.Size=UDim2.new(1,0,0,20)
	v.Position=UDim2.fromOffset(0,42)
	v.BackgroundTransparency=1
	v.Text="DMvsS V2"
	v.TextColor3=Color3.fromRGB(150,150,150)
	v.TextScaled=true

	local minus=B(main,"-",UDim2.fromOffset(345,8),UDim2.fromOffset(30,30))

	local tp1=B(main,"TP1 GUARDADO",UDim2.fromOffset(15,70),UDim2.fromOffset(170,43))
	local tp2=B(main,"TP2 TEPEARSE",UDim2.fromOffset(205,70),UDim2.fromOffset(170,43))
	local anim=B(main,"ANIMACIÓN",UDim2.fromOffset(15,122),UDim2.fromOffset(170,43))
	local info=B(main,"INFO",UDim2.fromOffset(205,122),UDim2.fromOffset(170,43))
	local music=B(main,"EHYUU! 🎵",UDim2.fromOffset(15,175),UDim2.fromOffset(360,43))

	local saved

	tp1.MouseButton1Click:Connect(function()
		local c=pl.Character
		local r=c and c:FindFirstChild("HumanoidRootPart")
		if r then
			saved=r.CFrame
			tp1.Text="GUARDADO ✅"
		end
	end)

	tp2.MouseButton1Click:Connect(function()
		local c=pl.Character
		local r=c and c:FindFirstChild("HumanoidRootPart")
		if r and saved then r.CFrame=saved end
	end)

	-- ANIMACIÓN

	anim.MouseButton1Click:Connect(function()

		if G:FindFirstChild("AnimPanel") then return end

		local p=Instance.new("Frame",G)
		p.Name="AnimPanel"
		p.Size=UDim2.fromOffset(360,220)
		p.Position=UDim2.new(.5,-180,.5,-110)
		p.BackgroundColor3=Color3.fromRGB(5,5,5)
		p.BorderSizePixel=0
		C(p) R(p) Drag(p)

		local tt=Instance.new("TextLabel",p)
		tt.Size=UDim2.new(1,-50,0,35)
		tt.Position=UDim2.fromOffset(10,10)
		tt.BackgroundTransparency=1
		tt.Text="ANIMACIÓN"
		tt.TextColor3=Color3.new(1,1,1)
		tt.TextScaled=true
		tt.Font=Enum.Font.GothamBold

		local x=B(p,"X",UDim2.fromOffset(320,10),UDim2.fromOffset(30,30))

		local id=Instance.new("TextBox",p)
		id.Size=UDim2.new(1,-20,0,42)
		id.Position=UDim2.fromOffset(10,55)
		id.BackgroundColor3=Color3.fromRGB(20,20,20)
		id.BorderSizePixel=0
		id.PlaceholderText="ID DE ANIMACIÓN"
		id.Text=""
		id.TextColor3=Color3.new(1,1,1)
		id.TextScaled=true
		C(id) R(id)

		local play=B(p,"PLAY",UDim2.fromOffset(10,110),UDim2.fromOffset(165,42))
		local stop=B(p,"STOP",UDim2.fromOffset(185,110),UDim2.fromOffset(165,42))

		local status=Instance.new("TextLabel",p)
		status.Size=UDim2.new(1,-20,0,40)
		status.Position=UDim2.fromOffset(10,160)
		status.BackgroundTransparency=1
		status.Text=""
		status.TextColor3=Color3.new(1,1,1)
		status.TextScaled=true

		local track

		play.MouseButton1Click:Connect(function()

			local number=tonumber(id.Text)
			if not number then
				status.Text="ID INCORRECTO ❌"
				return
			end

			local c=pl.Character
			local h=c and c:FindFirstChildOfClass("Humanoid")
			if not h then return end

			local a=h:FindFirstChildOfClass("Animator")
			if not a then
				a=Instance.new("Animator",h)
			end

			if track then
				pcall(function() track:Stop() end)
			end

			local an=Instance.new("Animation")
			an.AnimationId="rbxassetid://"..number

			local ok,res=pcall(function()
				local tr=a:LoadAnimation(an)
				tr.Looped=true
				tr:Play()
				return tr
			end)

			if ok then
				track=res
				status.Text="ANIMACIÓN ACTIVADA ✅"
			else
				status.Text="ID INCORRECTO ❌"
			end
		end)

		stop.MouseButton1Click:Connect(function()
			if track then
				pcall(function() track:Stop() end)
				track=nil
			end
			status.Text="DETENIDA"
		end)

		x.MouseButton1Click:Connect(function()
			p:Destroy()
		end)
	end)

	-- INFO

	info.MouseButton1Click:Connect(function()

		if G:FindFirstChild("InfoPanel") then return end

		local p=Instance.new("Frame",G)
		p.Name="InfoPanel"
		p.Size=UDim2.fromOffset(360,220)
		p.Position=UDim2.new(.5,-180,.5,-110)
		p.BackgroundColor3=Color3.fromRGB(5,5,5)
		p.BorderSizePixel=0
		C(p) R(p) Drag(p)

		local x=B(p,"X",UDim2.fromOffset(320,10),UDim2.fromOffset(30,30))

		local text=Instance.new("TextLabel",p)
		text.Size=UDim2.new(1,-20,1,-60)
		text.Position=UDim2.fromOffset(10,50)
		text.BackgroundTransparency=1
		text.Text="BIENVENIDOS ALA V2 DEL SCRIPT YA NO SERA DE GENERAR ROBUX SI NO DE TEPEARSE/ANIMACIONES/ETC DISFRUTA DEL V2"
		text.TextColor3=Color3.new(1,1,1)
		text.TextWrapped=true
		text.TextScaled=true
		text.Font=Enum.Font.GothamBold

		x.MouseButton1Click:Connect(function()
			p:Destroy()
		end)
	end)

	-- MÚSICA

	music.MouseButton1Click:Connect(function()
		local s=SS:FindFirstChild("NexxuzMusic")

		if not s then
			s=Instance.new("Sound",SS)
			s.Name="NexxuzMusic"
			s.SoundId="rbxassetid://16190782181"
			s.Volume=1
			s.Looped=true
		end

		if s.IsPlaying then
			s:Pause()
			music.Text="EHYUU! ▶"
		else
			s:Play()
			music.Text="EHYUU! ⏸"
		end
	end)

	-- MINIMIZAR LENTO

	local mini=Instance.new("TextButton",G)
	mini.Size=UDim2.fromOffset(220,45)
	mini.Position=main.Position
	mini.BackgroundColor3=Color3.fromRGB(5,5,5)
	mini.BorderSizePixel=0
	mini.Text="Nexxuz Hub | Lardylan  +"
	mini.TextColor3=Color3.new(1,1,1)
	mini.TextScaled=true
	mini.Font=Enum.Font.GothamBold
	mini.Visible=false
	C(mini) R(mini) Drag(mini)

	minus.MouseButton1Click:Connect(function()

		local pos=main.Position
		mini.Position=pos
		mini.Visible=true

		TS:Create(
			main,
			TweenInfo.new(.7,Enum.EasingStyle.Quad,Enum.EasingDirection.In),
			{Size=UDim2.fromOffset(390,0)}
		):Play()

		task.wait(.7)
		main.Visible=false
	end)

	mini.MouseButton1Click:Connect(function()

		main.Position=mini.Position
		main.Size=UDim2.fromOffset(390,0)
		main.Visible=true
		mini.Visible=false

		TS:Create(
			main,
			TweenInfo.new(.7,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
			{Size=UDim2.fromOffset(390,290)}
		):Play()
	end)
end)
