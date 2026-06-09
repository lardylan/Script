-- SERVICIOS DE ROBLOX
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- CONFIGURACIÓN DE LAS KEYS
local keys_2horas = {
    ["FhexHubScripts-QISW-FRBXA"] = true,
    ["FhexHubScripts-WIQW-ÑRBXJ"] = true,
    ["FhexHubScripts-JITW-FRBXP"] = true,
    ["FhexHubScripts-FICW-FRBXO"] = true,
    ["FhexHubScripts-RIXW-FRBXY"] = true
}

local keys_perma = {
    ["CARBLOXFF"] = true,
    ["FHEXHUBSCRIPT"] = true
}

-- Estado global interno para simular si la primera key ya fue usada en la sesión
local primeraKeyResgatada = false 

-- INSTANCIACIÓN DE LA INTERFAZ PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SystemKeyHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- FONDO PRINCIPAL DEL SCRIPT (GRIS Y REDONDEADO)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Fondo Gris
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12) -- Bordes redondos
MainCorner.Parent = MainFrame

-- TEXTO SUPERIOR (SYSTEM KEY)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SYSTEM KEY"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 22
TitleLabel.Parent = MainFrame

-- CUADRO DE TEXTO PARA INGRESAR LA KEY (EDIT TEXT)
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0, 280, 0, 40)
KeyInput.Position = UDim2.new(0.5, -140, 0, 60)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Lineal interno negro
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderText = "Inserta tu Key aquí..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyInput.Text = ""
KeyInput.Font = Enum.Font.SourceSans
KeyInput.TextSize = 16
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8) -- Redondeado
InputCorner.Parent = KeyInput

-- ETIQUETA DE ESTADO O ERROR
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 110)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Parent = MainFrame

-- BOTÓN GET KEY
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Name = "GetKeyBtn"
GetKeyBtn.Size = UDim2.new(0, 130, 0, 35)
GetKeyBtn.Position = UDim2.new(0, 35, 0, 150)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Lineal Negro
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.TextSize = 16
GetKeyBtn.Parent = MainFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8) -- Redondeado
GetKeyCorner.Parent = GetKeyBtn

-- BOTÓN ENTER KEY
local EnterKeyBtn = Instance.new("TextButton")
EnterKeyBtn.Name = "EnterKeyBtn"
EnterKeyBtn.Size = UDim2.new(0, 130, 0, 35)
EnterKeyBtn.Position = UDim2.new(1, -165, 0, 150)
EnterKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Lineal Negro
EnterKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterKeyBtn.Text = "ENTER KEY"
EnterKeyBtn.Font = Enum.Font.SourceSansBold
EnterKeyBtn.TextSize = 16
EnterKeyBtn.Parent = MainFrame

local EnterCorner = Instance.new("UICorner")
EnterCorner.CornerRadius = UDim.new(0, 8) -- Redondeado
EnterCorner.Parent = EnterKeyBtn

-- TEXTO ABAJO DE TODO (TIK TOK CRÉDITOS)
local FooterLabel = Instance.new("TextLabel")
FooterLabel.Name = "FooterLabel"
FooterLabel.Size = UDim2.new(1, 0, 0, 30)
FooterLabel.Position = UDim2.new(0, 0, 1, -30)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "TIK TOK: CARBLOXFF / TIK TOK: Fhex Hub Script"
FooterLabel.TextColor3 = Color3.fromRGB(0, 0, 0) -- Color NEGRO requerido
FooterLabel.Font = Enum.Font.SourceSansBold
FooterLabel.TextSize = 13
FooterLabel.Parent = MainFrame


-- LÓGICA DE TIEMPO (SACAR DEL JUEGO TRAS 2 HORAS)
local function empezarContador2Horas()
    task.spawn(function()
        task.wait(7200) -- 2 horas en segundos (7200)
        LocalPlayer:Kick("Key Invalida")
    end)
end

-- ACCIÓN: BOTÓN GET KEY (COPIAR LINK AL PORTAPAPELES)
GetKeyBtn.MouseButton1Click:Connect(function()
    local url = "https://link-hub.net/5159847/PsZTUthoE14g"
    if setclipboard then
        setclipboard(url)
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        StatusLabel.Text = "¡Link copiado al portapapeles!"
    else
        KeyInput.Text = url -- Respaldo por si el exploit no tiene setclipboard
        StatusLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
        StatusLabel.Text = "Link puesto en el cuadro de texto."
    end
end)


-- CREACIÓN DE LA INTERFAZ FLOTANTE (MIAKHALIFA TP)
local function crearBotonFlotante()
    MainFrame.Visible = false -- Oculta el menú de Keys
    
    -- Contenedor del botón flotante e indicador superior
    local FloatingContainer = Instance.new("Frame")
    FloatingContainer.Name = "FloatingContainer"
    FloatingContainer.Size = UDim2.new(0, 150, 0, 75)
    FloatingContainer.Position = UDim2.new(0.1, 0, 0.4, 0)
    FloatingContainer.BackgroundTransparency = 1
    FloatingContainer.Parent = ScreenGui
    
    -- Texto arriba del botón flotante
    local FloatingHeader = Instance.new("TextLabel")
    FloatingHeader.Name = "FloatingHeader"
    FloatingHeader.Size = UDim2.new(1, 0, 0, 25)
    FloatingHeader.BackgroundTransparency = 1
    FloatingHeader.Text = "MIAKHALIFA"
    FloatingHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatingHeader.Font = Enum.Font.SourceSansBold
    FloatingHeader.TextSize = 16
    FloatingHeader.Parent = FloatingContainer
    
    -- Botón Flotante interactivo
    local TpBtn = Instance.new("TextButton")
    TpBtn.Name = "TpBtn"
    TpBtn.Size = UDim2.new(1, 0, 0, 45)
    TpBtn.Position = UDim2.new(0, 0, 0, 25)
    TpBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Redondo y Negro
    TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpBtn.Text = "TP MIAKHALIFA"
    TpBtn.Font = Enum.Font.SourceSansBold
    TpBtn.TextSize = 14
    TpBtn.Parent = FloatingContainer
    
    local TpCorner = Instance.new("UICorner")
    TpCorner.CornerRadius = UDim.new(0, 12)
    TpCorner.Parent = TpBtn
    
    -- ACCIÓN TELEPORTACIÓN COORDINADAS (-65, 12, -131)
    TpBtn.MouseButton1Click:Connect(function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(-65, 12, -131)
        end
    end)
    
    -- SCRIPT PARA MOVER EL BOTÓN FLOTANTE CON EL DEDO / MOUSE (MOBILE FRIENDLY)
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        FloatingContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    FloatingContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = FloatingContainer.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    FloatingContainer.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end


-- ACCIÓN: BOTÓN ENTER KEY (VALIDACIÓN)
EnterKeyBtn.MouseButton1Click:Connect(function()
    local entrada = KeyInput.Text
    
    -- 1. Validar si es la primera Key específica y ya fue resgatada
    if entrada == "FhexHubScripts-QISW-FRBXA" then
        if primeraKeyResgatada then
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            StatusLabel.Text = "ERROR KEY FOI RESGASTADO"
            return
        else
            primeraKeyResgatada = true
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            StatusLabel.Text = "Key Aceptada (2 Horas)"
            task.wait(1)
            empezarContador2Horas()
            crearBotonFlotante()
            return
        end
    end
    
    -- 2. Validar el resto de las Keys de 2 horas
    if keys_2horas[entrada] then
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        StatusLabel.Text = "Key Aceptada (2 Horas)"
        task.wait(1)
        empezarContador2Horas()
        crearBotonFlotante()
        return
    end
    
    -- 3. Validar Keys Permanentes
    if keys_perma[entrada] then
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        StatusLabel.Text = "Key Permanente Aceptada"
        task.wait(1)
        crearBotonFlotante()
        return
    end
    
    -- 4. Si no coincide con ninguna, lanzar error de Key Inválida
    StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Color ROJO requerido
    StatusLabel.Text = "Key Invalida"
end)
