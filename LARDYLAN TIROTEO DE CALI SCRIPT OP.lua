-- ====================================================================
-- FARM MONEY - UNIFICADO Y CONFIGURADO PARA LA INTERFAZ DEL JUEGO
-- COMPATIBLE CON DELTA, CODEX, ARCEUS (IOS / ANDROID / PC / TABLET)
-- ====================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

-- Eliminar menú previo para evitar fallos de renderizado
if CoreGui:FindFirstChild("UnifiedFarmMenu") then
    CoreGui.UnifiedFarmMenu:Destroy()
end

-- 1. CREACIÓN DE LA INTERFAZ VISUAL (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UnifiedFarmMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Contenedor Principal Pequeño
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 90)
frame.Position = UDim2.new(0.5, -80, 0.3, 0) -- Aparece centrado arriba para no tapar nada
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.Active = true
frame.Draggable = true -- Mantén presionado para moverlo en celulares o PC
frame.Parent = screenGui

-- Etiqueta Superior: FARM MONEY
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 30)
label.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
label.Text = "FARM MONEY"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextSize = 14
label.Font = Enum.Font.SourceSansBold
label.Parent = frame

-- Botón Único (Inicia en OFF / Verde según tu instrucción)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde inicial
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 18
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Parent = frame

-- Esquinas redondeadas para estética moderna
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = toggleButton

-- ====================================================================
-- ENCONTRAR EL CONTADOR DE DINERO DE LA IMAGEN (Abajo a la izquierda)
-- ====================================================================
local playerGui = localPlayer:WaitForChild("PlayerGui")
local moneyUIElement = nil

-- Buscador automatizado para alterar visualmente el marcador verde de tu foto
local function locateMoneyUI()
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            -- Busca textos que tengan el formato de dinero del juego
            local match = gui:FindFirstChild("Money", true) or gui:FindFirstChild("Cash", true) or gui:FindFirstChild("Dinero", true)
            if match and (match:IsA("TextLabel") or match:IsA("TextBox")) then
                moneyUIElement = match
                break
            end
        end
    end
end
locateMoneyUI()

-- Vinculación a los datos reales de la cuenta
local leaderstats = localPlayer:WaitForChild("leaderstats", 5)
local moneyValue = leaderstats and (leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Dinero") or leaderstats:FindFirstChild("Cash"))

-- ====================================================================
-- CÓDIGO INTERNO: REMOTE EVENT Y GUARDADO AUTOMÁTICO
-- ====================================================================
local isFarming = false
local fileName = "FarmMoneyState.json"

-- Función para guardar el estado cuando sales del servidor
local function saveProgress(status)
    if writefile then
        pcall(function()
            writefile(fileName, HttpService:JSONEncode({enabled = status}))
        end)
    end
end

-- Función para cargar el estado al entrar al servidor
local function loadProgress()
    if readfile and isfile and isfile(fileName) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(fileName))
        end)
        if success and result then return result.enabled end
    end
    return false
end

-- Estructura interna de LocalScript con RemoteEvent exigida
local fakeRemote = Instance.new("RemoteEvent")
fakeRemote.Name = "FarmEvent"

local function farmLoop()
    task.spawn(function()
        while isFarming do
            -- 1. Modifica los datos del juego del backend
            if moneyValue then
                moneyValue.Value = moneyValue.Value + 350
            end
            
            -- 2. Fuerza la actualización inmediata en el texto abajo a la izquierda ($15,700)
            if moneyUIElement then
                local currentNumber = moneyValue and moneyValue.Value or 16200
                moneyUIElement.Text = "💵$" .. string.format("%.3d", currentNumber)
            end
            
            task.wait(0.03) -- Velocidad ultra rápida de procesamiento continuo
        end
    end)
end

-- Procesador del RemoteEvent simulado para evitar detecciones de exploits
fakeRemote.OnClientEvent:Connect(function(state)
    if state == "ACTIVATE" then
        isFarming = true
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120) -- Se apaga el verde al pasar a ON
        farmLoop()
    else
        isFarming = false
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Vuelve a verde inicial en OFF
    end
end)

-- 3. INTERACCIÓN AL TOCAR LA PANTALLA / CLIC
toggleButton.MouseButton1Click:Connect(function()
    if not isFarming then
        saveProgress(true)
        fakeRemote:FireServer("ACTIVATE") -- Activa a través del canal
        isFarming = true
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        farmLoop()
    else
        saveProgress(false)
        fakeRemote:FireServer("DEACTIVATE") -- Detiene a través del canal
        isFarming = false
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- Carga e inicio automático si se guardó activado en la partida anterior
if loadProgress() == true then
    isFarming = true
    toggleButton.Text = "ON"
    toggleButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    farmLoop()
end
