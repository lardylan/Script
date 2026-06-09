-- Creación de la Interfaz Base
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local NameInput = Instance.new("TextBox")
local EnterBtn = Instance.new("TextButton")
local AnnounceInput = Instance.new("TextBox")

-- Variables de Estado y Configuración
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local menuOpen = true
local currentUserName = LocalPlayer.Name -- Nombre por defecto del jugador
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Propiedades del Menu Principal
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35) -- Fondo oscuro para simular la estética
MainFrame.Position = UDim2.new(0.5, -150, 0.4, -125)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.ClipsDescendants = true

-- Bordes Redondos Negros (Lineales redondos)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 0, 0)
MainStroke.Thickness = 3
MainStroke.Parent = MainFrame

-- Barra de Título (Fhex Hub)
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(0.8, 0, 1, 0)
TitleText.Text = "Fhex Hub"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Position = UDim2.new(0, 15, 0, 0)

-- Botón de Minimizar (-)
ToggleBtn.Parent = TitleBar
ToggleBtn.Position = UDim2.new(0.85, 0, 0.1, 0)
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Text = "-"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 24
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

-- Contenedor del Contenido
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)
ContentFrame.BackgroundTransparency = 1

-- Primer EditText: Cambiar Nombre
NameInput.Parent = ContentFrame
NameInput.Position = UDim2.new(0.05, 0, 0.1, 0)
NameInput.Size = UDim2.new(0.9, 0, 0, 35)
NameInput.PlaceholderText = "Cambiar Nombre aquí..."
NameInput.Text = ""
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)

local InputCorner1 = Instance.new("UICorner")
InputCorner1.CornerRadius = UDim.new(0, 8)
InputCorner1.Parent = NameInput

-- Botón ENTERA
EnterBtn.Parent = ContentFrame
EnterBtn.Position = UDim2.new(0.05, 0, 0.33, 0)
EnterBtn.Size = UDim2.new(0.9, 0, 0, 30)
EnterBtn.Text = "ENTERA"
EnterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
EnterBtn.Font = Enum.Font.SourceSansBold

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 8)
BtnCorner2.Parent = EnterBtn

-- Segundo EditText: Announce
AnnounceInput.Parent = ContentFrame
AnnounceInput.Position = UDim2.new(0.05, 0, 0.55, 0)
AnnounceInput.Size = UDim2.new(0.9, 0, 0, 35)
AnnounceInput.PlaceholderText = "Escribe un Announce (ej: Como andan)..."
AnnounceInput.Text = ""
AnnounceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AnnounceInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)

local InputCorner2 = Instance.new("UICorner")
InputCorner2.CornerRadius = UDim.new(0, 8)
InputCorner2.Parent = AnnounceInput

-- LÓGICA DE DETONACIÓN Y FUNCIONES

-- 1. Animación Lenta de Minimizar / Maximizar
ToggleBtn.MouseButton1Click:Connect(function()
    if menuOpen then
        -- Esconder lento (Solo queda la barra de título de 40 de alto)
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 40)}):Play()
        ToggleBtn.Text = "+"
    else
        -- Abrir lento (Vuelve a su tamaño original de 250 de alto)
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 250)}):Play()
        ToggleBtn.Text = "-"
    end
    menuOpen = not menuOpen
end)

-- 2. Guardar Nombre con el botón ENTERA
EnterBtn.MouseButton1Click:Connect(function()
    if NameInput.Text ~= "" then
        currentUserName = NameInput.Text
        print("Nombre del usuario actualizado visualmente a: " .. currentUserName)
        
        -- Notificación visual interna del Script
        local originalColor = EnterBtn.BackgroundColor3
        EnterBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        EnterBtn.Text = "¡NOMBRE GUARDADO!"
        task.wait(1)
        EnterBtn.BackgroundColor3 = originalColor
        EnterBtn.Text = "ENTERA"
    end
end)

-- 3. Enviar Mensaje tipo Announce (Al presionar Enter en el teclado)
AnnounceInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and AnnounceInput.Text ~= "" then
        local mensajeCompleto = "USER: " .. currentUserName .. " | " .. AnnounceInput.Text
        
        -- Formato Visual Texturas V1 en la consola de Roblox/Delta
        print("-----------------------------------")
        print(mensajeCompleto)
        print("-----------------------------------")
        
        -- Genera un mensaje visual en el Chat del Servidor (Solo visible para ti de forma local)
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[Fhex Hub V1] " .. "USER: " .. currentUserName .. ": " .. AnnounceInput.Text,
            Color = Color3.fromRGB(255, 85, 255),
            Font = Enum.Font.SourceSansBold,
            FontSize = Enum.FontSize.Size18
        })
        
        AnnounceInput.Text = "" -- Limpia la caja después de enviar
    end
end)

-- Hacer que el menú se pueda arrastrar por la pantalla
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
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

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
