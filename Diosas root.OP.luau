-- Clonación persistente en CoreGui para Delta Executor
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Búsqueda del RemoteEvent nativo para simulación de sincronización
local remoteEvent = ReplicatedStorage:FindFirstChild("RachaRemoteEvent") or ReplicatedStorage:FindFirstChild("StreakRemote") or Instance.new("RemoteEvent", ReplicatedStorage)
remoteEvent.Name = "LardylanRemoteSystem"

-- Evitar duplicación de interfaces en pantalla
if CoreGui:FindFirstChild("LardylanHub") then CoreGui.LardylanHub:Destroy() end

local LardylanHub = Instance.new("ScreenGui")
LardylanHub.Name = "LardylanHub"
LardylanHub.Parent = CoreGui
LardylanHub.ResetOnSpawn = false

---------------------------------------------------------
-- 1. PANTALLA DE CARGA (Negro opaco, oculta el juego)
---------------------------------------------------------
local LoadingScreen = Instance.new("Frame")
LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadingScreen.BorderSizePixel = 0
LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingScreen.Parent = LardylanHub

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(0, 200, 0, 50)
LoadingText.Position = UDim2.new(0.5, -100, 0.4, -25)
LoadingText.BackgroundTransparency = 1
LoadingText.Font = Enum.Font.GothamBold
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 32
LoadingText.Text = "0.0%"
LoadingText.Parent = LoadingScreen

-- Barra de seguimiento estilo carril _⚪_______
local TrackBar = Instance.new("TextLabel")
TrackBar.Size = UDim2.new(0, 300, 0, 30)
TrackBar.Position = UDim2.new(0.5, -150, 0.5, 0)
TrackBar.BackgroundTransparency = 1
TrackBar.Font = Enum.Font.Code
TrackBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TrackBar.TextSize = 24
TrackBar.Text = "____________________"
TrackBar.Parent = LoadingScreen

local BallIndicator = Instance.new("TextLabel")
BallIndicator.Size = UDim2.new(0, 30, 0, 30)
BallIndicator.Position = UDim2.new(0, 0, 0, -3)
BallIndicator.BackgroundTransparency = 1
BallIndicator.Font = Enum.Font.GothamBold
BallIndicator.TextColor3 = Color3.fromRGB(255, 255, 255)
BallIndicator.TextSize = 24
BallIndicator.Text = "⚪"
BallIndicator.Parent = TrackBar

---------------------------------------------------------
-- 2. MARCO PRINCIPAL (GUI LARDYLAN RACHA)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 240)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 4, 4) -- Rojo oscuro solicitado
MainFrame.BackgroundTransparency = 0.3 -- Semitransparente
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true -- Soporte de arrastre táctil para móvil
MainFrame.Parent = LardylanHub

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Bordes con Efecto Dinámico Rainbow (Arcoíris)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame
UIGradient.Parent = UIStroke

-- Hilo de ejecución para la rotación del color del gradiente
task.spawn(function()
    local currentRotation = 0
    while task.wait(0.01) do
        currentRotation = (currentRotation + 3) % 360
        UIGradient.Rotation = currentRotation
    end
end)

-- Título Principal
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 0, 40)
Title.Position = UDim2.new(0, 16, 0, 12)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Text = "LARDYLAN RACHA🔥"
Title.Parent = MainFrame

---------------------------------------------------------
-- 3. BOTONES DE ACCESIBILIDAD / AUTO-CONEXIÓN (🔴, 🔵, ⚫)
---------------------------------------------------------
local function buildIndicator(color, shiftX, channelLog)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 16, 0, 16)
    btn.Position = UDim2.new(1, shiftX, 0, 24)
    btn.BackgroundColor3 = color
    btn.Text = ""
    btn.Parent = MainFrame
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = btn

    btn.MouseButton1Click:Connect(function()
        print("[Lardylan Racha]: Canal activo automatizado -> " .. channelLog)
    end)
end

buildIndicator(Color3.fromRGB(255, 60, 60), -85, "RED_NET")
buildIndicator(Color3.fromRGB(60, 60, 255), -60, "BLUE_NET")
buildIndicator(Color3.fromRGB(20, 20, 20), -35, "BLACK_NET")

---------------------------------------------------------
-- 4. CAMPO DE ENTRADA (Líneas indicadoras de Dígitos)
---------------------------------------------------------
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0, 280, 0, 42)
InputBox.Position = UDim2.new(0.5, -140, 0.42, -10)
InputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
InputBox.BackgroundTransparency = 0.4
InputBox.Font = Enum.Font.GothamSemibold
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
InputBox.TextSize = 20
InputBox.Text = ""
InputBox.PlaceholderText = "----------" -- Línea divisoria de dígitos
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

---------------------------------------------------------
-- 5. INTERRUPTOR Y ACTUALIZACIÓN FLOTANTE (poner🔥)
---------------------------------------------------------
local SetButton = Instance.new("TextButton")
SetButton.Size = UDim2.new(0, 180, 0, 45)
SetButton.Position = UDim2.new(0.5, -90, 0.72, 5)
SetButton.BackgroundColor3 = Color3.fromRGB(210, 25, 25)
SetButton.BackgroundTransparency = 0.2
SetButton.Font = Enum.Font.GothamBold
SetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SetButton.TextSize = 21
SetButton.Text = "poner🔥"
SetButton.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 12)
BtnCorner.Parent = SetButton

-- Rastreador dinámico para alterar la etiqueta de la racha flotante en el juego
local function forzarRachaEnPersonaje(valorRecibido)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char then
        for _, component in pairs(char:GetDescendants()) do
            if component:IsA("TextLabel") then
                -- Evalúa los textos clave que usa el Billboard del juego sobre la cabeza
                if string.find(component.Text, "🔥") or string.find(component.Text, "split") or string.find(component.Text, "Esperando") then
                    component.Text = "Let's split! 🔥" .. tostring(valorRecibido)
                end
            end
        end
    end
end

SetButton.MouseButton1Click:Connect(function()
    local intVal = tonumber(InputBox.Text)
    if intVal then
        -- Tope restrictivo configurado a un máximo de 13,560 de racha
        if intVal > 13560 then intVal = 13560 end
        if intVal < 0 then intVal = 0 end
        
        -- Ejecución de envío remoto de variables al juego
        remoteEvent:FireServer(intVal)
        
        -- Inyección local para visualización directa sobre el personaje
        forzarRachaEnPersonaje(intVal)
        print("Valor de racha forzado a: " .. tostring(intVal))
    else
        InputBox.Text = ""
        InputBox.PlaceholderText = "¡Número inválido!"
    end
end)

---------------------------------------------------------
-- ANIMACIÓN SÍNCRONA DE LA BARRA DE CARGA
---------------------------------------------------------
task.spawn(function()
    local incremento = 100
    for paso = 0, incremento do
        local fraccion = paso / incremento
        LoadingText.Text = string.format("%.1f%%", fraccion * 100)
        
        -- Movimiento de la bola blanca ⚪ a lo largo de los guiones
        BallIndicator.Position = UDim2.new(fraccion * 0.9, 0, 0, -3)
        
        task.wait(0.025)
    end
    
    -- Suavizado de salida por desvanecimiento de transparencia
    local infoTrans = TweenInfo.new(0.4)
    local panelTween = TweenService:Create(LoadingScreen, infoTrans, {BackgroundTransparency = 1})
    TweenService:Create(LoadingText, infoTrans, {TextTransparency = 1}):Play()
    TweenService:Create(TrackBar, infoTrans, {TextTransparency = 1}):Play()
    TweenService:Create(BallIndicator, infoTrans, {TextTransparency = 1}):Play()
    panelTween:Play()
    
    panelTween.Completed:Connect(function()
        LoadingScreen:Destroy()
        MainFrame.Visible = true -- Muestra el Hub listo para usar
    end)
end)
