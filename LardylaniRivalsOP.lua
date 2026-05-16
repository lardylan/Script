-- ====================================================================
-- MOD MENÚ PREMIUM CON OCULTAMIENTO DE CLAVE - JUEGO: RIVALS (ROBLOX)
-- COMPATIBLE CON DELTA, CODEX, VEGA X (ANDROID / IOS / PC / TABLETS)
-- ====================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- CONFIGURACIÓN DE ENLACES Y LLAVES
local CORRECT_KEY = "LARDYLAN-xqctjljbcsa"
local GET_KEY_URL = "https://link-target.net/5159847/cdDlsrDF9Me8"
local YOUTUBE_URL = "https://www.youtube.com/@lardylan"
local WHATSAPP_LINK = "https://whatsapp.com"

-- Limpiar interfaces previas para evitar superposiciones o fallos de inyección
if CoreGui:FindFirstChild("RivalsKeyMenuSystem") then CoreGui.RivalsKeyMenuSystem:Destroy() end
if CoreGui:FindFirstChild("RivalsUltimateMenu") then CoreGui.RivalsUltimateMenu:Destroy() end

-- COPIA INVISIBLE DEL LINK DE WHATSAPP AL INICIAR EL SCRIPT
if setclipboard then setclipboard(WHATSAPP_LINK) end

-- ====================================================================
-- 1. ESTRUCTURA COMPLETA DEL MOD MENÚ PRINCIPAL POST-VERIFICACIÓN
-- ====================================================================
local function buildMainModMenu()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "RivalsUltimateMenu"
    mainGui.ResetOnSpawn = false
    mainGui.Parent = CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 240, 0, 110)
    frame.Position = UDim2.new(0.5, -120, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.ClipsDescendants = true 
    frame.Draggable = true 
    frame.Parent = mainGui

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 24)
    frameCorner.Parent = frame

    local frameStroke = Instance.new("UIStroke")
    frameStroke.Thickness = 2.5
    frameStroke.Color = Color3.fromRGB(0, 255, 150) -- Borde verde neón moderno
    frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    frameStroke.Parent = frame

    local textWatermark = Instance.new("TextLabel")
    textWatermark.Size = UDim2.new(0, 160, 0, 20)
    textWatermark.Position = UDim2.new(0, 15, 0, 12)
    textWatermark.BackgroundTransparency = 1
    textWatermark.Text = "Sigue a Lardylan✅"
    textWatermark.TextColor3 = Color3.fromRGB(0, 255, 150)
    textWatermark.TextSize = 14
    textWatermark.Font = Enum.Font.SourceSansBold
    textWatermark.TextXAlignment = Enum.TextXAlignment.Left
    textWatermark.Parent = frame

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 24, 0, 24)
    minimizeButton.Position = UDim2.new(1, -34, 0, 10)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
    minimizeButton.TextSize = 16
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.Parent = frame

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(1, 0) 
    minCorner.Parent = minimizeButton

    local unlockButton = Instance.new("TextButton")
    unlockButton.Size = UDim2.new(0, 100, 0, 42)
    unlockButton.Position = UDim2.new(0, 15, 0, 48)
    unlockButton.BackgroundColor3 = Color3.fromRGB(230, 150, 0) -- Naranja
    unlockButton.Text = "UNLOCK ALL"
    unlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    unlockButton.TextSize = 13
    unlockButton.Font = Enum.Font.SourceSansBold
    unlockButton.Parent = frame

    local buttonCorner1 = Instance.new("UICorner")
    buttonCorner1.CornerRadius = UDim.new(0, 18)
    buttonCorner1.Parent = unlockButton

    local aimbotButton = Instance.new("TextButton")
    aimbotButton.Size = UDim2.new(0, 100, 0, 42)
    aimbotButton.Position = UDim2.new(0, 125, 0, 48)
    aimbotButton.BackgroundColor3 = Color3.fromRGB(150, 0, 230) -- Morado
    aimbotButton.Text = "AIMBOT"
    aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimbotButton.TextSize = 14
    aimbotButton.Font = Enum.Font.SourceSansBold
    aimbotButton.Parent = frame

    local buttonCorner2 = Instance.new("UICorner")
    buttonCorner2.CornerRadius = UDim.new(0, 18)
    buttonCorner2.Parent = aimbotButton

    -- Lógica de minimizado colapsable al cuadrito flotante
    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            unlockButton.Visible = false
            aimbotButton.Visible = false
            minimizeButton.Text = "+"
            minimizeButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            frame:TweenSize(UDim2.new(0, 210, 0, 42), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
        else
            minimizeButton.Text = "-"
            minimizeButton.TextColor3 = Color3.fromRGB(255, 50, 50)
            frame:TweenSize(UDim2.new(0, 240, 0, 110), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true, function()
                unlockButton.Visible = true
                aimbotButton.Visible = true
            end)
        end
    end)

    -- Lógica interna funcional: UNLOCK ALL (Visual)
    local unlockEnabled = false
    unlockButton.MouseButton1Click:Connect(function()
        unlockEnabled = not unlockEnabled
        if unlockEnabled then
            unlockButton.Text = "ACTIVE"
            unlockButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            task.spawn(function()
                while unlockEnabled do
                    pcall(function()
                        for _, child in ipairs(ReplicatedStorage:GetDescendants()) do
                            if child:IsA("ModuleScript") and (child.Name:lower():find("skin") or child.Name:lower():find("weapon") or child.Name:lower():find("cosmetic")) then
                                local moduleData = require(child)
                                if type(moduleData) == "table" then
                                    for _, item in pairs(moduleData) do
                                        if type(item) == "table" then
                                            item.Unlocked = true
                                            item.Owned = true
                                            item.IsLocked = false
                                            if item.CustomAudio or item.SoundId then item.AudioEnabled = true end
                                        end
                                    end
                                end
                            end
                        end
                        local playerGui = localPlayer:WaitForChild("PlayerGui")
                        for _, element in ipairs(playerGui:GetDescendants()) do
                            if element:IsA("ImageLabel") and (element.Name:lower():find("lock") or element.Image:find("lock") or element.Image:find("1316")) then
                                element.Visible = false
                            end
                            if element:IsA("TextButton") or element:IsA("ImageButton") then
                                if element.Parent.Name:lower():find("weapon") or element.Name:lower():find("skin") or element.Parent:IsA("ScrollingFrame") then
                                    element.Active = true
                                    element.Selectable = true
                                    element.Interactable = true
                                end
                            end
                        end
                    end)
                    task.wait(0.4)
                end
            end)
        else
            unlockEnabled = false
            unlockButton.Text = "UNLOCK ALL"
            unlockButton.BackgroundColor3 = Color3.fromRGB(230, 150, 0)
        end
    end)

    -- Lógica interna funcional: AIMBOT (Asistencia a la Cabeza)
    local aimbotEnabled = false
    local fovRadius = 250 

    local function getClosestRivalHead()
        local closestHead = nil
        local shortestDistance = math.huge
        local myChar = localPlayer.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if myRoot then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.Team ~= localPlayer.Team then
                    local enemyChar = player.Character
                    local enemyHead = enemyChar and enemyChar:FindFirstChild("Head")
                    local enemyHumanoid = enemyChar and enemyChar:FindFirstChildOfClass("Humanoid")
                    if enemyHead and enemyHumanoid and enemyHumanoid.Health > 0 then
                        local screenPos, onScreen = camera:WorldToViewportPoint(enemyHead.Position)
                        if onScreen then
                            local mousePos = UserInputService:GetMouseLocation()
                            local distance2D = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if distance2D < shortestDistance and distance2D <= fovRadius then
                                closestHead = enemyHead
                                shortestDistance = distance2D
                            end
                        end
                    end
                end
            end
        end
        return closestHead
    end

    RunService.RenderStepped:Connect(function()
        if aimbotEnabled then
            local targetHead = getClosestRivalHead()
            if targetHead then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
            end
        end
    end)

    aimbotButton.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            aimbotButton.Text = "ACTIVE"
            aimbotButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        else
            aimbotButton.Text = "AIMBOT"
            aimbotButton.BackgroundColor3 = Color3.fromRGB(150, 0, 230)
        end
    end)
end

-- ====================================================================
-- 2. CONSTRUCCIÓN VISIBLE DE LA INTERFAZ DEL KEY SYSTEM
-- ====================================================================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "RivalsKeyMenuSystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = CoreGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 260, 0, 150)
keyFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230) -- Blanco un poco oscuro (VISIBLE)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true 
keyFrame.Parent = keyGui

local keyFrameCorner = Instance.new("UICorner")
keyFrameCorner.CornerRadius = UDim.new(0, 20) -- Bordes redondos (VISIBLE)
keyFrameCorner.Parent = keyFrame

local keyFrameStroke = Instance.new("UIStroke")
keyFrameStroke.Thickness = 2
keyFrameStroke.Color = Color3.fromRGB(120, 120, 120) -- Lineales grises (VISIBLE)
keyFrameStroke.Parent = keyFrame

-- TEXTO SUPERIOR COMPLETAMENTE VISIBLE: KEY SYSTEM
local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.Position = UDim2.new(0, 0, 0, 10)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "KEY SYSTEM"
keyTitle.TextColor3 = Color3.fromRGB(40, 40, 40)
keyTitle.TextSize = 16
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.Parent = keyFrame

-- CUADRO DE TEXTO VISIBLE CON CARACTERES OCULTOS (IsPassword = true)
local keyTextBox = Instance.new("TextBox")
keyTextBox.Size = UDim2.new(0, 220, 0, 35)
keyTextBox.Position = UDim2.new(0, 20, 0, 48)
keyTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.Text = ""
keyTextBox.PlaceholderText = "Ingresa la clave aqui..."
keyTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
keyTextBox.TextSize = 14
keyTextBox.Font = Enum.Font.SourceSans
keyTextBox.IsPassword = true -- SOLO LAS LETRAS SON INVISIBLES AL ESCRIBIRLAS O PEGARLAS
keyTextBox.Parent = keyFrame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 10)
boxCorner.Parent = keyTextBox

local boxStroke = Instance.new("UIStroke")
boxStroke.Thickness = 1
boxStroke.Color = Color3.fromRGB(160, 160, 160)
boxStroke.Parent = keyTextBox

-- BOTÓN IZQUIERDO VISIBLE: GET KEY
local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0, 105, 0, 35)
getKeyButton.Position = UDim2.new(0, 20, 0, 98)
getKeyButton.BackgroundColor3 = Color3.fromRGB(60, 150, 255) 
getKeyButton.Text = "GET KEY"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.TextSize = 14
getKeyButton.Font = Enum.Font.SourceSansBold
getKeyButton.Parent = keyFrame

local btnCorner1 = Instance.new("UICorner")
btnCorner1.CornerRadius = UDim.new(0, 12)
btnCorner1.Parent = getKeyButton

-- BOTÓN DERECHO VISIBLE: ENTER KEY
local enterKeyButton = Instance.new("TextButton")
enterKeyButton.Size = UDim2.new(0, 105, 0, 35)
enterKeyButton.Position = UDim2.new(0, 135, 0, 98)
enterKeyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100) 
enterKeyButton.Text = "ENTER KEY"
enterKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
enterKeyButton.TextSize = 14
enterKeyButton.Font = Enum.Font.SourceSansBold
enterKeyButton.Parent = keyFrame

local btnCorner2 = Instance.new("UICorner")
btnCorner2.CornerRadius = UDim.new(0, 12)
btnCorner2.Parent = enterKeyButton

-- ====================================================================
-- ACCIONES Y COMPROBACIONES DE ACCESO DEL SISTEMA
-- ====================================================================

getKeyButton.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(GET_KEY_URL) end
    pcall(function()
        local request = syn and syn.request or http_request or http and http.request or request
        if request then request({Url = GET_KEY_URL, Method = "GET"}) end
    end)
end)

enterKeyButton.MouseButton1Click:Connect(function()
    local inputKey = keyTextBox.Text
    if inputKey == CORRECT_KEY then
        keyTextBox.IsPassword = false
        keyTextBox.Text = "ACCESO CONCEDIDO!"
        keyTextBox.TextColor3 = Color3.fromRGB(0, 180, 0)
        
        -- COPIAR EL ENLACE DE YOUTUBE AUTOMÁTICAMENTE AL PORTAPAPELES AL PASAR
        if setclipboard then
            setclipboard(YOUTUBE_URL)
        elseif toclipboard then
            toclipboard(YOUTUBE_URL)
        elseif Clipboard then
            Clipboard.set(YOUTUBE_URL)
        end
        
        task.wait(0.8)
        
        -- BORRA LA KEY UI Y CONSTRUYE EL MOD MENÚ CON UNLOCK ALL / AIMBOT
        keyGui:Destroy()
        buildMainModMenu()
    else
        keyTextBox.IsPassword = false
        keyTextBox.Text = ""
        keyTextBox.PlaceholderText = "CLAVE INCORRECTA!"
        keyTextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(1)
        keyTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
        keyTextBox.IsPassword = true
        keyTextBox.PlaceholderText = "Ingresa la clave aqui..."
    end
end)
