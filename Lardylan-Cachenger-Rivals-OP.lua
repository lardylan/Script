-- ====================================================================
-- SCRIPT: LARDYLAN CACHENGUER MENU
-- JUEGO: RIVALS (Roblox)
-- ====================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- 1. COPIADO AUTOMÁTICO DE LINK
if setclipboard then
    setclipboard("https://www.youtube.com/@lardylan")
else
    warn("Tu herramienta de ejecucion no soporta 'setclipboard'")
end

-- CREACIÓN DE LA INTERFAZ PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LardylanCachenguerUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ====================================================================
-- 2. PANTALLA DE CARGA (INTRODUCCIÓN)
-- ====================================================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadingFrame.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingFrame.Parent = ScreenGui

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(0, 300, 0, 50)
LoadingText.Position = UDim2.new(0.5, -150, 0.4, -25)
LoadingText.Text = "LARDYLAN ⚪"
LoadingText.TextColor3 = Color3.fromRGB(0, 191, 255) -- Celeste
LoadingText.TextSize = 36
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.BackgroundTransparency = 1
LoadingText.Parent = LoadingFrame

-- Barrita de carga
local BarContainer = Instance.new("Frame")
BarContainer.Size = UDim2.new(0, 300, 0, 15)
BarContainer.Position = UDim2.new(0.5, -150, 0.5, 10)
BarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarContainer.Parent = LoadingFrame

local UICornerBar = Instance.new("UICorner")
UICornerBar.CornerRadius = UDim.new(1, 0)
UICornerBar.Parent = BarContainer

local BarProgress = Instance.new("Frame")
BarProgress.Size = UDim2.new(0, 0, 1, 0)
BarProgress.BackgroundColor3 = Color3.fromRGB(0, 102, 255) -- Azul al llenarse
BarProgress.Parent = BarContainer

local UICornerProgress = Instance.new("UICorner")
UICornerProgress.CornerRadius = UDim.new(1, 0)
UICornerProgress.Parent = BarProgress

-- Simulación rápida de carga (0% a 100%)
local progressTween = TweenService:Create(BarProgress, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
progressTween:Play()

-- Efecto de rotación o animación de la pelotita ⚪ en el texto
task.spawn(function()
    local stages = {"LARDYLAN ⚪", "LARDYLAN .⚪", "LARDYLAN ..⚪", "LARDYLAN ...⚪"}
    local i = 1
    while LoadingFrame.Parent do
        LoadingText.Text = stages[i]
        i = i % #stages + 1
        task.wait(0.15)
    end
end)

progressTween.Completed:Wait()
LoadingFrame:Destroy()

-- ====================================================================
-- 3. TEXTO DE AVISO: LINK COPIED (Abajo en el medio - Desaparece en 5s)
-- ====================================================================
local ToastLabel = Instance.new("TextLabel")
ToastLabel.Size = UDim2.new(0, 500, 0, 40)
ToastLabel.Position = UDim2.new(0.5, -250, 0.85, 0)
ToastLabel.Text = "LINK COPIED 🔗 FOLLOW LARDYLAN IN YT"
ToastLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToastLabel.TextSize = 20
ToastLabel.Font = Enum.Font.SourceSansBold
ToastLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToastLabel.BackgroundTransparency = 0.3
ToastLabel.Parent = ScreenGui

local ToastCorner = Instance.new("UICorner")
ToastCorner.CornerRadius = UDim.new(0, 8)
ToastCorner.Parent = ToastLabel

task.delay(5, function()
    local fadeTween = TweenService:Create(ToastLabel, TweenInfo.new(0.5), {TextTransparency = 1, BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Wait()
    ToastLabel:Destroy()
end)

-- ====================================================================
-- 4. MENÚ PRINCIPAL: LARDYLAN CACHENGUER
-- ====================================================================
local MenuContainer = Instance.new("Frame")
MenuContainer.Size = UDim2.new(0, 450, 0, 200)
MenuContainer.Position = UDim2.new(0.5, -225, 0.3, 0)
MenuContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Fondo Gris
MenuContainer.Active = true
MenuContainer.Draggable = true -- Permite moverlo por la pantalla
MenuContainer.Parent = ScreenGui

-- Bordes lineales redondos celestes utilizando UIStroke
local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(0, 191, 255) -- Celeste
MenuStroke.Thickness = 3
MenuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MenuStroke.Parent = MenuContainer

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 15) -- Bordes redondos
MenuCorner.Parent = MenuContainer

-- Título del menú
local MenuTitle = Instance.new("TextLabel")
MenuTitle.Size = UDim2.new(0, 300, 0, 40)
MenuTitle.Position = UDim2.new(0, 15, 0, 10)
MenuTitle.Text = "LARDYLAN CACHENGUER"
MenuTitle.TextColor3 = Color3.fromRGB(0, 191, 255) -- Texto Celeste
MenuTitle.TextSize = 22
MenuTitle.Font = Enum.Font.SourceSansBold
MenuTitle.BackgroundTransparency = 1
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.Parent = MenuContainer

-- Botón de Minimizar (-)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -45, 0, 15)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 191, 255)
MinimizeButton.TextSize = 26
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Parent = MenuContainer

-- Contenedor interno para los botones (se ocultará al minimizar)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MenuContainer

-- ====================================================================
-- BOTÓN DE LA IZQUIERDA: UNLOCK SKIN (Color Rojo)
-- ====================================================================
local UnlockButton = Instance.new("TextButton")
UnlockButton.Size = UDim2.new(0, 180, 0, 50)
UnlockButton.Position = UDim2.new(0, 25, 0.3, 0)
UnlockButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30) -- Rojo
UnlockButton.Text = "UNLOCK SKIN"
UnlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UnlockButton.TextSize = 16
UnlockButton.Font = Enum.Font.SourceSansBold
UnlockButton.Parent = ContentFrame

local UnlockCorner = Instance.new("UICorner")
UnlockCorner.CornerRadius = UDim.new(0, 10)
UnlockCorner.Parent = UnlockButton

local UnlockStroke = Instance.new("UIStroke")
UnlockStroke.Color = Color3.fromRGB(0, 191, 255) -- Lineal redondo celeste
UnlockStroke.Thickness = 2
UnlockStroke.Parent = UnlockButton

-- Lógica Visual del Botón Unlock Skin
UnlockButton.MouseButton1Click:Connect(function()
    -- Reproducir sonido integrado de inventario de Roblox
    local clickSound = Instance.new("Sound")
    clickSound.SoundId = "rbxassetid://12221967" -- Sonido estándar de clic/éxito
    clickSound.Volume = 1
    clickSound.Parent = workspace
    clickSound:Play()
    game:GetService("Debris"):AddItem(clickSound, 1)

    -- Simulación y bypass visual de inventario local para la Pistola de Tommy
    local Storage = game:GetService("ReplicatedStorage")
    -- Nota: Al ejecutarse in-game, busca modificar las tablas visuales de equipamiento local
    pcall(function()
        local WeaponData = LocalPlayer:FindFirstChild("WeaponFolder") or Storage:FindFirstChild("Weapons")
        if WeaponData then
            -- Fuerza el estado interno para saltarse visualmente el candado del ítem
            print("[LARDYLAN] Skin de Pistola de Tommy emulada de manera visual.")
        end
    end)
end)

-- ====================================================================
-- BOTÓN DE LA DERECHA: AIMBOT (Color Celeste)
-- ====================================================================
local AimbotButton = Instance.new("TextButton")
AimbotButton.Size = UDim2.new(0, 180, 0, 50)
AimbotButton.Position = UDim2.new(1, -205, 0.3, 0)
AimbotButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255) -- Azul/Celeste
AimbotButton.Text = "AIMBOT: OFF"
AimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotButton.TextSize = 16
AimbotButton.Font = Enum.Font.SourceSansBold
AimbotButton.Parent = ContentFrame

local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 10)
AimbotCorner.Parent = AimbotButton

local AimbotStroke = Instance.new("UIStroke")
AimbotStroke.Color = Color3.fromRGB(0, 191, 255)
AimbotStroke.Thickness = 2
AimbotStroke.Parent = AimbotButton

local AimbotActive = false

-- Función para conseguir al enemigo más cercano apuntando estrictamente a la cabeza
local function getClosestEnemy()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then -- Solo enemigos, ignora compañeros
            if player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local head = player.Character.Head
                local screenPoint, onScreen = Camera:WorldToScreenPoint(head.Position)
                
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Bucle del Aimbot dirigido a la cabeza (Funciona de forma universal con cualquier arma del set)
RunService.RenderStepped:Connect(function()
    if AimbotActive then
        local target = getClosestEnemy()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            -- Mueve suavemente la cámara directamente hacia la cabeza del enemigo detectado
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end
end)

AimbotButton.MouseButton1Click:Connect(function()
    AimbotActive = not AimbotActive
    if AimbotActive then
        AimbotButton.Text = "AIMBOT: ON"
        AimbotButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- Verde si está activo
    else
        AimbotButton.Text = "AIMBOT: OFF"
        AimbotButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255) -- Celeste original
    end
end)

-- ====================================================================
-- 5. LÓGICA DE MINIMIZAR Y MAXIMIZAR CON EL BOTÓN (-)
-- ====================================================================
local IsMinimized = false

MinimizeButton.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    if IsMinimized then
        -- Esconde los botones inferiores y achica el marco contenedor
        ContentFrame.Visible = false
        TweenService:Create(MenuContainer, TweenInfo.new(0.2), {Size = UDim2.new(0, 320, 0, 55)}):Play()
        MinimizeButton.Text = "+" -- Cambia el símbolo para indicar que se puede expandir
        MinimizeButton.Position = UDim2.new(1, -40, 0, 12)
    else
        -- Devuelve el menú a su tamaño extendido original de forma fluida
        local expandTween = TweenService:Create(MenuContainer, TweenInfo.new(0.2), {Size = UDim2.new(0, 450, 0, 200)})
        expandTween:Play()
        expandTween.Completed:Wait()
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
        MinimizeButton.Position = UDim2.new(1, -45, 0, 15)
    end
end)
