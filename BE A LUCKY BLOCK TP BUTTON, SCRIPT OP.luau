-- Roblox Mod Menu: BE A LUCKY BLOCK
-- Características: Arrastrable, Bordes Redondeados, Azul Neón, Animación de Cierre Lento (Tween)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Coordenadas exactas extraídas de la imagen
local targetCoords = Vector3.new(726.3, 39.9, -2124.7)

-- Crear la interfaz principal (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuckyBlockModMenu"
ScreenGui.ResetOnSpawn = false
-- Asegura compatibilidad con dispositivos móviles y PC
pcall(function()
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = game:CoreGui
end

-- Marco Principal (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 190, 0, 110) -- Tamaño chiquito
MainFrame.Position = UDim2.new(0.5, -95, 0.4, -55)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Fondo gris oscuro
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Bordes Redondeados y Contorno Azul Neón
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10) -- Puntas redondas
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 255) -- Azul Neón
UIStroke.Thickness = 2.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Título del Menú
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 140, 0, 30)
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BE A LUCKY BLOCK"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto blanco
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-- Botón de Minimizar (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- Blanco
MinimizeBtn.TextSize = 20
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Parent = MainFrame

-- Contenedor del contenido interno (para ocultarse suavemente)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Botón RESET BASE (Teleport)
local ResetBaseBtn = Instance.new("TextButton")
ResetBaseBtn.Name = "ResetBaseBtn"
ResetBaseBtn.Size = UDim2.new(0, 150, 0, 40)
ResetBaseBtn.Position = UDim2.new(0.5, -75, 0.5, -20)
ResetBaseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ResetBaseBtn.Text = "RESET BASE"
ResetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBaseBtn.TextSize = 14
ResetBaseBtn.Font = Enum.Font.SourceSansBold
ResetBaseBtn.Parent = ContentFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ResetBaseBtn

-- LÓGICA 1: Teletransporte (TP) al presionar RESET BASE
ResetBaseBtn.MouseButton1Click:Connect(function()
    local Character = LocalPlayer.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            -- Añadimos un pequeño desfase en el eje Y para evitar atascarse bajo el mapa
            HumanoidRootPart.CFrame = CFrame.new(targetCoords + Vector3.new(0, 2, 0))
        end
    end
end)

-- LÓGICA 2: Minimizar / Maximizar con efecto lento de compu (TweenService)
local isMinimized = false
local normalHeight = 110
local minimizedHeight = 40

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    local targetHeight = isMinimized and minimizedHeight or normalHeight
    local targetTransparency = isMinimized and 1 or 0
    
    -- Transición suave para ocultar el contenido de adentro
    for _, child in pairs(ContentFrame:GetChildren()) do
        if child:IsA("TextButton") then
            TweenService:Create(child, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = targetTransparency, TextTransparency = targetTransparency}):Play()
        end
    end
    
    -- Animación de cierre/apertura lento del cuadro principal
    local frameTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 190, 0, targetHeight)})
    frameTween:Play()
end)

-- LÓGICA 3: Mover el cuadro con el dedo o mouse (Mecanismo Draggable Adaptado)
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
