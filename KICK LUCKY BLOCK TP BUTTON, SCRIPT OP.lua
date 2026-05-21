-- Evitar duplicados en la pantalla
if game.CoreGui:FindFirstChild("KickLuckyBlockMenu") then
    game.CoreGui.KickLuckyBlockMenu:Destroy()
end

-- Contenedor Principal (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KickLuckyBlockMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Cuadro Principal del Mod Menu
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 180, 0, 110) -- Tamaño compacto y chiquito
MainFrame.Position = UDim2.new(0.5, -90, 0.4, -55) -- Centrado inicial
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Fondo de color gris
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false

-- Bordes redondeados en las puntas del menú
local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 10)
MenuCorner.Parent = MainFrame

-- Contorno / Borde exterior Azul Neón
local MenuUIStroke = Instance.new("UIStroke")
MenuUIStroke.Color = Color3.fromRGB(0, 160, 255) -- Color Azul Neón
MenuUIStroke.Thickness = 2
MenuUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MenuUIStroke.Parent = MainFrame

-- Título del menú superior
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(0, 140, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "KICK LUCKY BLOCK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto Blanco
Title.TextSize = 12
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botón de Minimizar [-]
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "[-]"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 160, 255) -- Azul Neón
MinimizeBtn.TextSize = 14
MinimizeBtn.Font = Enum.Font.SourceSansBold

-- Contenedor del contenido (Botones internos)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1

-- Botón RESET BASE (Teletransporte)
local ResetBaseBtn = Instance.new("TextButton")
ResetBaseBtn.Name = "ResetBaseBtn"
ResetBaseBtn.Parent = ContentFrame
ResetBaseBtn.Size = UDim2.new(0, 140, 0, 35)
ResetBaseBtn.Position = UDim2.new(0.5, -70, 0.5, -22)
ResetBaseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Gris oscuro interno
ResetBaseBtn.Text = "RESET BASE"
ResetBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto Blanco
ResetBaseBtn.TextSize = 12
ResetBaseBtn.Font = Enum.Font.SourceSansBold

-- Bordes redondeados para el botón interno
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ResetBaseBtn

-- Contorno Azul Neón sutil para el botón
local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(0, 160, 255)
BtnStroke.Thickness = 1
BtnStroke.Parent = ResetBaseBtn

---------------------------------------------------------
-- FUNCIONALIDADES (Lógica detrás del Mod Menu)
---------------------------------------------------------

-- 1. Función de Teletransporte (Al tocar RESET BASE)
ResetBaseBtn.MouseButton1Click:Connect(function()
    local player = game:GetService("Players").LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        -- Coordenadas exactas obtenidas de tu captura: X: 720.4, Y: 4.1, Z: 228.6
        player.Character.HumanoidRootPart.CFrame = CFrame.new(720.4, 4.1, 228.6)
    end
end)

-- 2. Función de Minimizar / Maximizar con el botón [-]
local minimizado = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if not minimizado then
        -- Minimizar: Esconde el contenido y achica el cuadro principal
        ContentFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 180, 0, 35)
        MinimizeBtn.Text = "[+]" -- Cambia el símbolo visualmente indicando que se puede expandir
        minimizado = true
    else
        -- Maximizar: Regresa a su tamaño original chiquito con su contenido
        MainFrame.Size = UDim2.new(0, 180, 0, 110)
        ContentFrame.Visible = true
        MinimizeBtn.Text = "[-]"
        minimizado = false
    end
end)

-- 3. Función del dedo para arrastrar el menú (Soporte Táctil Móvil/PC)
local UserInputService = game:GetService("UserInputService")
local arrastrando, inputInicial, posInicial

local function actualizar(input)
    local delta = input.Position - inputInicial
    MainFrame.Position = UDim2.new(posInicial.X.Scale, posInicial.X.Offset + delta.X, posInicial.Y.Scale, posInicial.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        arrastrando = true
        inputInicial = input.Position
        posInicial = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                arrastrando = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if arrastrando then
            actualizar(input)
        end
    end
end)
