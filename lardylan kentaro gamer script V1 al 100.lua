local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

if CoreGui:FindFirstChild("KentaroLardylanHub") then
    CoreGui.KentaroLardylanHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KentaroLardylanHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
end

local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.BorderSizePixel = 0
IntroFrame.ZIndex = 10
IntroFrame.Parent = ScreenGui

local IntroText1 = Instance.new("TextLabel")
IntroText1.Size = UDim2.new(1, 0, 0, 80)
IntroText1.Position = UDim2.new(0, 0, 0.4, -40)
IntroText1.BackgroundTransparency = 1
IntroText1.Font = Enum.Font.GothamBold
IntroText1.Text = "KENTARO GAMER"
IntroText1.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroText1.TextSize = 36
IntroText1.TextTransparency = 1
IntroText1.ZIndex = 11
IntroText1.Parent = IntroFrame

local IntroText2 = Instance.new("TextLabel")
IntroText2.Size = UDim2.new(1, 0, 0, 50)
IntroText2.Position = UDim2.new(0, 0, 0.5, 10)
IntroText2.BackgroundTransparency = 1
IntroText2.Font = Enum.Font.Code
IntroText2.Text = ""
IntroText2.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText2.TextSize = 24
IntroText2.TextTransparency = 1
IntroText2.ZIndex = 11
IntroText2.Parent = IntroFrame

task.spawn(function()
    TweenService:Create(IntroText1, TweenInfo.new(1.5), {TextTransparency = 0}):Play()
    task.wait(2.2)
    
    TweenService:Create(IntroText2, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    local fullText = "LARDYLAN"
    for i = 1, #fullText do
        IntroText2.Text = string.sub(fullText, 1, i)
        task.wait(0.1)
    end
    
    task.wait(4)
    
    local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(IntroFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText1, fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(IntroText2, fadeInfo, {TextTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
end)

local FloatingButton = Instance.new("ImageButton")
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 55, 0, 55)
FloatingButton.Position = UDim2.new(0, 20, 0.5, -27)
FloatingButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FloatingButton.Image = "rbxthumb://type=Asset&id=118544465694154&w=420&h=420"
FloatingButton.ScaleType = Enum.ScaleType.Fit
FloatingButton.Visible = false
FloatingButton.ZIndex = 5
FloatingButton.Parent = ScreenGui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatingButton

local dragging, dragInput, dragStart, startPos
FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatingButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatingButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

task.spawn(function()
    task.wait(7.5)
    FloatingButton.Visible = true
end)

local KeySystemFrame = Instance.new("ImageLabel")
KeySystemFrame.Name = "KeySystemFrame"
KeySystemFrame.Size = UDim2.new(0, 360, 0, 240)
KeySystemFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeySystemFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
KeySystemFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeySystemFrame.Image = "rbxthumb://type=Asset&id=130712334835447&w=420&h=420"
KeySystemFrame.ScaleType = Enum.ScaleType.Slice
KeySystemFrame.SliceCenter = Rect.new(100, 100, 100, 100)
KeySystemFrame.Visible = false
KeySystemFrame.ZIndex = 6
KeySystemFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeySystemFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "KENTARO_GAMER - LARDYLAN"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 14
KeyTitle.ZIndex = 7
KeyTitle.Parent = KeySystemFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 310, 0, 45)
KeyBox.Position = UDim2.new(0.5, -155, 0, 60)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyBox.Font = Enum.Font.Code
KeyBox.PlaceholderText = "Ingresa la Key aquí..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.ZIndex = 7
KeyBox.Parent = KeySystemFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = KeyBox

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 150, 0, 38)
GetKeyBtn.Position = UDim2.new(0, 25, 0, 120)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.TextSize = 13
GetKeyBtn.ZIndex = 7
GetKeyBtn.Parent = KeySystemFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn

local GetKeyIcon = Instance.new("ImageLabel")
GetKeyIcon.Size = UDim2.new(0, 20, 0, 20)
GetKeyIcon.Position = UDim2.new(0, 8, 0.5, -10)
GetKeyIcon.BackgroundTransparency = 1
GetKeyIcon.Image = "rbxthumb://type=Asset&id=92904714959352&w=420&h=420"
GetKeyIcon.ZIndex = 8
GetKeyIcon.Parent = GetKeyBtn

local CopiedLabel = Instance.new("TextLabel")
CopiedLabel.Size = UDim2.new(1, 0, 0, 20)
CopiedLabel.Position = UDim2.new(0, 0, 0, 162)
CopiedLabel.BackgroundTransparency = 1
CopiedLabel.Font = Enum.Font.Gotham
CopiedLabel.Text = ""
CopiedLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
CopiedLabel.TextSize = 11
CopiedLabel.ZIndex = 7
CopiedLabel.Parent = KeySystemFrame

local EnterKeyBtn = Instance.new("TextButton")
EnterKeyBtn.Size = UDim2.new(0, 150, 0, 38)
EnterKeyBtn.Position = UDim2.new(0, 185, 0, 120)
EnterKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EnterKeyBtn.Font = Enum.Font.GothamBold
EnterKeyBtn.Text = "ENTER KEY"
EnterKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
EnterKeyBtn.TextSize = 13
EnterKeyBtn.ZIndex = 7
EnterKeyBtn.Parent = KeySystemFrame

local EnterCorner = Instance.new("UICorner")
EnterCorner.CornerRadius = UDim.new(0, 6)
EnterCorner.Parent = EnterKeyBtn

local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = UDim2.new(0, 420, 0, 380)
MainMenu.AnchorPoint = Vector2.new(0.5, 0.5)
MainMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainMenu.Visible = false
MainMenu.ZIndex = 10
MainMenu.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainMenu

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TopBar.ZIndex = 11
TopBar.Parent = MainMenu

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Size = UDim2.new(0, 300, 1, 0)
MenuTitle.Position = UDim2.new(0, 15, 0, 0)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.Text = "LARDYLAN KENTARO V1 script al 100"
MenuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuTitle.TextSize = 13
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.ZIndex = 12
MenuTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 12
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.ZIndex = 12
MinimizeBtn.Parent = TopBar
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Size = UDim2.new(1, -20, 1, -55)
ScrollContainer.Position = UDim2.new(0, 10, 0, 48)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 450)
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.ZIndex = 11
ScrollContainer.Parent = MainMenu

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollContainer
local function createSwitchOption(name, text, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 45)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    container.ZIndex = 12
    container.Parent = ScrollContainer
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 260, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = container

    local switchBg = Instance.new("TextButton")
    switchBg.Size = UDim2.new(0, 50, 0, 26)
    switchBg.Position = UDim2.new(1, -65, 0.5, -13)
    switchBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    switchBg.Text = ""
    switchBg.ZIndex = 13
    switchBg.Parent = container
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)

    local switchDot = Instance.new("Frame")
    switchDot.Size = UDim2.new(0, 20, 0, 20)
    switchDot.Position = UDim2.new(0, 3, 0.5, -10)
    switchDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchDot.ZIndex = 14
    switchDot.Parent = switchBg
    Instance.new("UICorner", switchDot).CornerRadius = UDim.new(1, 0)

    local toggled = false
    switchBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10)}):Play()
            TweenService:Create(switchDot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        else
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -10)}):Play()
            TweenService:Create(switchDot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end
        callback(toggled)
    end)
end

local aimbotEnabled = false
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Radius = 100
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 1.5
fovCircle.Filled = false
fovCircle.Transparency = 1

createSwitchOption("Aimbot", "AIMBOT (Mostrar FOV Radio)", function(state)
    aimbotEnabled = state
    fovCircle.Visible = state
end)

local blockFovEnabled = false
createSwitchOption("BlockFov", "BLOCK FOV (Bloquear en Centro)", function(state)
    blockFovEnabled = state
end)

local selectedPart = "Head"
local partContainer = Instance.new("Frame")
partContainer.Size = UDim2.new(1, 0, 0, 50)
partContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
partContainer.ZIndex = 12
partContainer.Parent = ScrollContainer
Instance.new("UICorner", partContainer).CornerRadius = UDim.new(0, 8)

local partLabel = Instance.new("TextLabel")
partLabel.Size = UDim2.new(0, 140, 1, 0)
partLabel.Position = UDim2.new(0, 15, 0, 0)
partLabel.BackgroundTransparency = 1
partLabel.Font = Enum.Font.GothamBold
partLabel.Text = "OBJETIVO:"
partLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
partLabel.TextSize = 12
partLabel.TextXAlignment = Enum.TextXAlignment.Left
partLabel.ZIndex = 13
partLabel.Parent = partContainer

local parts = {"Head", "Pecho", "Piernas"}
local currentPartIndex = 1

local partSelectBtn = Instance.new("TextButton")
partSelectBtn.Size = UDim2.new(0, 180, 0, 32)
partSelectBtn.Position = UDim2.new(1, -195, 0.5, -16)
partSelectBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
partSelectBtn.Font = Enum.Font.GothamBold
partSelectBtn.Text = "HEAD"
partSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
partSelectBtn.TextSize = 12
partSelectBtn.ZIndex = 13
partSelectBtn.Parent = partContainer
Instance.new("UICorner", partSelectBtn).CornerRadius = UDim.new(0, 6)

partSelectBtn.MouseButton1Click:Connect(function()
    currentPartIndex = currentPartIndex % #parts + 1
    local choice = parts[currentPartIndex]
    partSelectBtn.Text = string.upper(choice)
    if choice == "Head" then
        selectedPart = "Head"
    elseif choice == "Pecho" then
        selectedPart = "HumanoidRootPart"
    else
        selectedPart = "Left Leg"
    end
end)

local fovSliderContainer = Instance.new("Frame")
fovSliderContainer.Size = UDim2.new(1, 0, 0, 55)
fovSliderContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
fovSliderContainer.ZIndex = 12
fovSliderContainer.Parent = ScrollContainer
Instance.new("UICorner", fovSliderContainer).CornerRadius = UDim.new(0, 8)

local fovSliderLabel = Instance.new("TextLabel")
fovSliderLabel.Size = UDim2.new(1, -20, 0, 25)
fovSliderLabel.Position = UDim2.new(0, 15, 0, 5)
fovSliderLabel.BackgroundTransparency = 1
fovSliderLabel.Font = Enum.Font.GothamBold
fovSliderLabel.Text = "TAMAÑO FOV: 100"
fovSliderLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
fovSliderLabel.TextSize = 12
fovSliderLabel.TextXAlignment = Enum.TextXAlignment.Left
fovSliderLabel.ZIndex = 13
fovSliderLabel.Parent = fovSliderContainer

local sliderBar = Instance.new("TextButton")
sliderBar.Size = UDim2.new(1, -30, 0, 10)
sliderBar.Position = UDim2.new(0, 15, 0, 35)
sliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sliderBar.Text = ""
sliderBar.ZIndex = 13
sliderBar.Parent = fovSliderContainer
Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.3, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderFill.ZIndex = 14
sliderFill.Parent = sliderBar
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local sliding = false
sliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local fovVal = math.floor(50 + (pos * 350))
        fovCircle.Radius = fovVal
        fovSliderLabel.Text = "TAMAÑO FOV: " .. tostring(fovVal)
    end
end)

local rainbowEnabled = false
local rainbowBtn = Instance.new("TextButton")
rainbowBtn.Size = UDim2.new(1, 0, 0, 45)
rainbowBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
rainbowBtn.Font = Enum.Font.GothamBold
rainbowBtn.Text = "FOV RAINBOW [ APAGADO ]"
rainbowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rainbowBtn.TextSize = 12
rainbowBtn.ZIndex = 12
rainbowBtn.Parent = ScrollContainer
Instance.new("UICorner", rainbowBtn).CornerRadius = UDim.new(0, 8)

rainbowBtn.MouseButton1Click:Connect(function()
    rainbowEnabled = not rainbowEnabled
    if rainbowEnabled then
        rainbowBtn.Text = "FOV RAINBOW [ ENCENDIDO ]"
        rainbowBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        rainbowBtn.Text = "FOV RAINBOW [ APAGADO ]"
        rainbowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        fovCircle.Color = Color3.fromRGB(255, 255, 255)
    end
end)
GetKeyBtn.MouseButton1Click:Connect(function()
    local link = "https://discord.gg/CuFy5NxnQ"
    pcall(function()
        setclipboard(link)
    end)
    CopiedLabel.Text = "GET KEY COPIED LINK"
    task.delay(3, function()
        CopiedLabel.Text = ""
    end)
end)

EnterKeyBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text
    if enteredKey == "LARDYLAN-KENTARO-V1-2026" then
        KeySystemFrame.Visible = false
        MainMenu.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Key Incorrecta!"
        task.delay(1.5, function()
            KeyBox.PlaceholderText = "Ingresa la Key aquí..."
        end)
    end
end)

FloatingButton.MouseButton1Click:Connect(function()
    if not MainMenu.Visible then
        if KeySystemFrame.Visible then
            KeySystemFrame.Visible = false
        elseif MainMenu.Visible == false and KeySystemFrame.Visible == false then
            KeySystemFrame.Visible = true
        end
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    pcall(function()
        fovCircle:Remove()
    end)
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = false
end)

RunService.RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    local viewportSize = cam.ViewportSize
    
    if blockFovEnabled then
        fovCircle.Position = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    else
        local mousePos = UserInputService:GetMouseLocation()
        fovCircle.Position = mousePos
    end
    
    if rainbowEnabled then
        local hue = tick() % 5 / 5
        fovCircle.Color = Color3.fromHSV(hue, 1, 1)
    end
    
    if aimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local closestTarget = nil
        local shortestDist = fovCircle.Radius
        
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild(selectedPart) then
                local charPart = otherPlayer.Character[selectedPart]
                local screenPos, onScreen = cam:WorldToViewportPoint(charPart.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - fovCircle.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closestTarget = charPart
                    end
                end
            end
        end
        
        if closestTarget then
            cam.CFrame = CFrame.new(cam.CFrame.Position, closestTarget.Position)
        end
    end
end)
