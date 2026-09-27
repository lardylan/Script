--// NEXXUZ HUB
--// LocalScript -> StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

local BOOST_SPEED = 90
local DEFAULT_SPEED = 16

local savedPosition = nil
local boostEnabled = false
local musicEnabled = true
local minimized = false
local closed = false

--==================================================
-- MÚSICA
--==================================================

local music = Instance.new("Sound")
music.Name = "NexxuzHubMusic"
music.SoundId = "rbxassetid://16190782181"
music.Volume = 1
music.Looped = true
music.Parent = SoundService

local musicFailed = false

music.Loaded:Connect(function()
	musicFailed = false

	if musicEnabled and not closed then
		music:Play()
	end
end)

music.LoadFailed:Connect(function()
	musicFailed = true
	warn("Nexxuz Hub: Roblox no pudo cargar el audio 16190782181")
end)

task.spawn(function()
	music:Play()
end)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "NexxuzHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- RAINBOW
--==================================================

local rainbowConnections = {}

local function rainbowStroke(stroke)

	local hue = 0

	local connection = RunService.RenderStepped:Connect(function(dt)

		if not stroke.Parent then
			return
		end

		hue = (hue + dt * 0.25) % 1
		stroke.Color = Color3.fromHSV(hue, 1, 1)

	end)

	table.insert(rainbowConnections, connection)

end

--==================================================
-- FRAME PRINCIPAL
--==================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(300, 300)
main.Position = UDim2.new(0.5, -150, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 3
mainStroke.Parent = main

rainbowStroke(mainStroke)

--==================================================
-- ICONO
--==================================================

local icon = Instance.new("ImageLabel")
icon.Name = "HubIcon"
icon.Size = UDim2.fromOffset(32, 32)
icon.Position = UDim2.fromOffset(12, 11)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://15340056976"
icon.ScaleType = Enum.ScaleType.Fit
icon.Parent = main

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

--==================================================
-- TÍTULO
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -115, 0, 45)
title.Position = UDim2.fromOffset(50, 5)
title.BackgroundTransparency = 1
title.Text = "NEXXUZ HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

--==================================================
-- CERRAR
--==================================================

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(38, 32)
close.Position = UDim2.new(1, -45, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.BorderSizePixel = 0
close.Parent = main

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = close

--==================================================
-- MINIMIZAR
--==================================================

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(38, 32)
minimize.Position = UDim2.new(1, -88, 0, 8)
minimize.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
minimize.Text = "-"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 22
minimize.Font = Enum.Font.GothamBold
minimize.BorderSizePixel = 0
minimize.Parent = main

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimize

--==================================================
-- CREAR BOTONES
--==================================================

local function createButton(text, y)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -30, 0, 45)
	button.Position = UDim2.fromOffset(15, y)
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	button.Text = text
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextSize = 15
	button.Font = Enum.Font.GothamBold
	button.BorderSizePixel = 0
	button.Parent = main

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 14)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Parent = button

	rainbowStroke(stroke)

	return button

end

local tp1 = createButton("TP1  [ GUARDAR ]", 60)
local tp2 = createButton("TP2  [ TELEPORT ]", 112)
local boost = createButton("BOOST  [ OFF ]", 164)
local musicButton = createButton("MUSIC  [ ON ]", 216)

--==================================================
-- FOOTER
--==================================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 25)
footer.Position = UDim2.new(0, 0, 1, -27)
footer.BackgroundTransparency = 1
footer.Text = "Nexxuz Hub"
footer.TextColor3 = Color3.fromRGB(180, 180, 180)
footer.TextSize = 14
footer.Font = Enum.Font.GothamMedium
footer.Parent = main

--==================================================
-- CÍRCULO FLOTANTE
--==================================================

local floating = Instance.new("TextButton")
floating.Name = "FloatingButton"
floating.Size = UDim2.fromOffset(62, 62)
floating.Position = UDim2.new(0, 25, 0.5, -31)
floating.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
floating.Text = "N"
floating.TextColor3 = Color3.new(1, 1, 1)
floating.TextSize = 25
floating.Font = Enum.Font.GothamBold
floating.BorderSizePixel = 0
floating.Visible = false
floating.Parent = gui

local floatingCorner = Instance.new("UICorner")
floatingCorner.CornerRadius = UDim.new(1, 0)
floatingCorner.Parent = floating

local floatingStroke = Instance.new("UIStroke")
floatingStroke.Thickness = 3
floatingStroke.Parent = floating

rainbowStroke(floatingStroke)

--==================================================
-- ARRASTRAR PC + MÓVIL
--==================================================

local function makeDraggable(object)

	local dragging = false
	local dragStart
	local startPosition
	local dragInput

	object.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = object.Position

			input.Changed:Connect(function()

				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end

			end)

		end

	end)

	object.InputChanged:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			dragInput = input

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if input == dragInput and dragging then

			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)

		end

	end)

end

makeDraggable(main)
makeDraggable(floating)

--==================================================
-- TP1 - GUARDAR
--==================================================

tp1.MouseButton1Click:Connect(function()

	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	savedPosition = root.CFrame

	tp1.Text = "TP1  [ GUARDADO ✓ ]"

	task.delay(1.5, function()

		if tp1.Parent then
			tp1.Text = "TP1  [ GUARDAR ]"
		end

	end)

end)

--==================================================
-- TP2 - TELEPORT
--==================================================

tp2.MouseButton1Click:Connect(function()

	if not savedPosition then

		tp2.Text = "TP2  [ NO GUARDADO ]"

		task.delay(1.5, function()

			if tp2.Parent then
				tp2.Text = "TP2  [ TELEPORT ]"
			end

		end)

		return
	end

	local character = player.Character
	if not character then return end

	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	root.CFrame = savedPosition + Vector3.new(0, 3, 0)

end)

--==================================================
-- BOOST
--==================================================

local function setSpeed(speed)

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.WalkSpeed = speed
	end

end

boost.MouseButton1Click:Connect(function()

	boostEnabled = not boostEnabled

	if boostEnabled then
		setSpeed(BOOST_SPEED)
		boost.Text = "BOOST  [ ON ]"
	else
		setSpeed(DEFAULT_SPEED)
		boost.Text = "BOOST  [ OFF ]"
	end

end)

--==================================================
-- MÚSICA ON / OFF
--==================================================

musicButton.MouseButton1Click:Connect(function()

	musicEnabled = not musicEnabled

	if musicEnabled then

		musicButton.Text = "MUSIC  [ ON ]"

		if not musicFailed then
			music:Play()
		else
			musicButton.Text = "MUSIC  [ ERROR ]"

			task.delay(2, function()

				if musicButton.Parent and musicEnabled then
					musicButton.Text = "MUSIC  [ ON ]"
				end

			end)

		end

	else

		musicButton.Text = "MUSIC  [ OFF ]"
		music:Pause()

	end

end)

--==================================================
-- RESPAWN
--==================================================

player.CharacterAdded:Connect(function(character)

	local humanoid = character:WaitForChild("Humanoid")

	task.wait(0.2)

	if boostEnabled then
		humanoid.WalkSpeed = BOOST_SPEED
	else
		humanoid.WalkSpeed = DEFAULT_SPEED
	end

end)

--==================================================
-- MINIMIZAR
--==================================================

minimize.MouseButton1Click:Connect(function()

	minimized = true
	main.Visible = false
	floating.Visible = true

end)

--==================================================
-- RESTAURAR
--==================================================

floating.MouseButton1Click:Connect(function()

	minimized = false
	main.Visible = true
	floating.Visible = false

end)

--==================================================
-- CERRAR
--==================================================

close.MouseButton1Click:Connect(function()

	closed = true

	for _, connection in ipairs(rainbowConnections) do
		connection:Disconnect()
	end

	if music then
		music:Stop()
		music:Destroy()
	end

	gui:Destroy()

end)
