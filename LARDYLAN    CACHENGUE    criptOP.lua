-- Servicio de almacenamiento de interfaz y animaciones
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Crear ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LARDYLAN_CACHENGUER_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Marco Principal (El menú Gris)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Fondo Gris
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Esquinas Redondeadas para el Marco Principal
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Borde Azul Alrededor
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 120, 255) -- Azul
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Barra de Título Superior
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

-- Texto LARDYLAN CACHENGUER
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.8, -10, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Text = "LARDYLAN CACHENGUER"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = TitleBar

-- Botón de Minimizar (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 2)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = TitleBar

-- Contenedor de Botones (Cuerpo del menú)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Botón LARDYLAN UNLOCK ALL
local UnlockBtn = Instance.new("TextButton")
UnlockBtn.Size = UDim2.new(0.9, 0, 0, 45)
UnlockBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
UnlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
UnlockBtn.Text = "LARDYLAN UNLOCK ALL"
UnlockBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
UnlockBtn.TextSize = 14
UnlockBtn.Font = Enum.Font.GothamBold
UnlockBtn.Parent = ContentFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = UnlockBtn

----------------------------------------------------------------
-- FUNCIONALIDAD: MINIMIZAR / MAXIMIZAR (DESPACIO Y LENTO)
----------------------------------------------------------------
local minimized = false
local normalSize = UDim2.new(0, 250, 0, 180)
local miniSize = UDim2.new(0, 250, 0, 35) -- Solo se ve la barra de título
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

MinimizeBtn.MouseButton1Click:Connect(function()
    if not minimized then
        -- Ocultar el contenido de abajo suavemente
        ContentFrame.Visible = false
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = miniSize})
        tween:Play()
        MinimizeBtn.Text = "+"
        minimized = true
    else
        -- Mostrar el menú completo suavemente
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = normalSize})
        tween:Play()
        tween.Completed:Connect(function()
            if not minimized then ContentFrame.Visible = true end
        end)
        MinimizeBtn.Text = "-"
        minimized = false
    end
end)

----------------------------------------------------------------
-- FUNCIONALIDAD: MOVER CON EL DEDO / MOUSE
----------------------------------------------------------------
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

----------------------------------------------------------------
-- ACCIÓN DEL BOTÓN: EJECUTAR MOD MENU Y FORZAR TEXTOS
----------------------------------------------------------------
UnlockBtn.MouseButton1Click:Connect(function()
    -- Cargar el mod menú original
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/hr6aouJe/raw"))()
    end)
    
    -- Corrección asíncrona para renombrar "NOKS" por tu marca
    task.spawn(function()
        local targets = {LocalPlayer:WaitForChild("PlayerGui"), CoreGui}
        -- Bucle repetitivo para asegurar que cambie aunque el mod menú tarde en cargar
        for r = 1, 20 do 
            for _, source in ipairs(targets) do
                if source then
                    for _, obj in ipairs(source:GetDescendants()) do
                        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                            local txt = string.upper(obj.Text)
                            if string.find(txt, "NOKS") or string.find(txt, "UNLOCK") then
                                obj.Text = "LARDYLAN UNLOCK ALL"
                                obj.Font = Enum.Font.GothamBold
                            end
                        end
                    end
                end
            end
            task.wait(0.5) -- Revisa cada medio segundo durante 10 segundos
        end
    end)
end)
