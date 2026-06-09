-- Creación de la Interfaz Base
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")

-- Contenedores de Pestañas
local TabBar = Instance.new("Frame")
local MenuTabBtn = Instance.new("TextButton")
local InfoTabBtn = Instance.new("TextButton")

local MenuContent = Instance.new("Frame")
local InfoContent = Instance.new("Frame")

-- Componentes de la Pestaña MENU
local NameInput = Instance.new("TextBox")
local EnterBtn = Instance.new("TextButton")
local AnnounceInput = Instance.new("TextBox")

-- Componentes de la Pestaña INFORMASI
local InfoText = Instance.new("TextLabel")

-- Variables de Estado
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local menuOpen = true
local currentUserName = LocalPlayer.Name
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Propiedades del Menú Principal
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30) -- Fondo Base
MainFrame.Position = UDim2.new(0.5, -150, 0.4, -140)
MainFrame.Size = UDim2.new(0, 300, 0, 280)
MainFrame.ClipsDescendants = true

-- Bordes Redondos Negros
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
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)

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
ToggleBtn.Position = UDim2.new(0.85, 0, 0.15, 0)
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Text = "-"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 24
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

-- Barra de Navegación (Pestañas)
TabBar.Parent = MainFrame
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.Size = UDim2.new(1, 0, 0, 35)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

MenuTabBtn.Parent = TabBar
MenuTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
MenuTabBtn.Text = "MENU"
MenuTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuTabBtn.Font = Enum.Font.SourceSansBold
MenuTabBtn.TextSize = 14
MenuTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40) -- Activo por defecto

InfoTabBtn.Parent = TabBar
InfoTabBtn.Position = UDim2.new(0.5, 0, 0, 0)
InfoTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
InfoTabBtn.Text = "INFORMASI"
InfoTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoTabBtn.Font = Enum.Font.SourceSansBold
InfoTabBtn.TextSize = 14
InfoTabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

-----------------------------------------------
-- CONTENIDO: PESTAÑA MENU (Fondo Estilo 1)
-----------------------------------------------
MenuContent.Parent = MainFrame
MenuContent.Position = UDim2.new(0, 0, 0, 75)
MenuContent.Size = UDim2.new(1, 0, 1, -75)
MenuContent.BackgroundColor3 = Color3.fromRGB(30, 25, 35) -- Tono Púrpura Oscuro
MenuContent.Visible = true

NameInput.Parent = MenuContent
NameInput.Position = UDim2.new(0.05, 0, 0.08, 0)
NameInput.Size = UDim2.new(0.9, 0, 0, 35)
NameInput.PlaceholderText = "Ubah Nama di sini..."
NameInput.Text = ""
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.BackgroundColor3 = Color3.fromRGB(45, 40, 50)

local IC1 = Instance.new("UICorner") IC1.CornerRadius = UDim.new(0, 8) IC1.Parent = NameInput

EnterBtn.Parent = MenuContent
EnterBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
EnterBtn.Size = UDim2.new(0.9, 0, 0, 35)
EnterBtn.Text = "MASUK" -- Traducido (Entera / Confirmar)
EnterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
EnterBtn.Font = Enum.Font.SourceSansBold

local BC1 = Instance.new("UICorner") BC1.CornerRadius = UDim.new(0, 8) BC1.Parent = EnterBtn

AnnounceInput.Parent = MenuContent
AnnounceInput.Position = UDim2.new(0.05, 0, 0.58, 0)
AnnounceInput.Size = UDim2.new(0.9, 0, 0, 35)
AnnounceInput.PlaceholderText = "Iklan (ej: Como andan)..."
AnnounceInput.Text = ""
AnnounceInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AnnounceInput.BackgroundColor3 = Color3.fromRGB(45, 40, 50)

local IC2 = Instance.new("UICorner") IC2.CornerRadius = UDim.new(0, 8) IC2.Parent = AnnounceInput

-----------------------------------------------
-- CONTENIDO: PESTAÑA INFORMASI (Fondo Estilo 2)
-----------------------------------------------
InfoContent.Parent = MainFrame
InfoContent.Position = UDim2.new(0, 0, 0, 75)
InfoContent.Size = UDim2.new(1, 0, 1, -75)
InfoContent.BackgroundColor3 = Color3.fromRGB(20, 30, 35) -- Tono Azulado Oscuro (Fondo diferente)
InfoContent.Visible = false

InfoText.Parent = InfoContent
InfoText.Position = UDim2.new(0.05, 0, 0.05, 0)
InfoText.Size = UDim2.new(0.9, 0, 0.9, 0)
InfoText.Text = "✅TUTORIAL CARA KERJA SCRIPT✅\n\nUBAH NAMA DAN DI BAWAH INI PADA IKLAN, MASUKKAN TEKS APA PUN, TEKAN ENTER, LALU PESAN GLOBAL AKAN MUNCUL."
InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoText.TextSize = 14
InfoText.Font = Enum.Font.SourceSansItalic
InfoText.TextWrapped = true
InfoText.TextYAlignment = Enum.TextYAlignment.Top

-----------------------------------------------
-- LOGICA DEL SCRIPT
-----------------------------------------------

-- Cambio entre Pestañas (MENU / INFORMASI)
MenuTabBtn.MouseButton1Click:Connect(function()
    MenuContent.Visible = true
    InfoContent.Visible = false
    MenuTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
end)

InfoTabBtn.MouseButton1Click:Connect(function()
    InfoContent.Visible = true
    MenuContent.Visible = false
    InfoTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    MenuTabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
end)

-- Animación de Esconder / Mostrar Menu (-)
ToggleBtn.MouseButton1Click:Connect(function()
    if menuOpen then
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 40)}):Play()
        ToggleBtn.Text = "+"
    else
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 280)}):Play()
        ToggleBtn.Text = "-"
    end
    menuOpen = not menuOpen
end)

-- Acción Botón MASUK (Guardar Nombre)
EnterBtn.MouseButton1Click:Connect(function()
    if NameInput.Text ~= "" then
        currentUserName = NameInput.Text
        
        -- Efecto de confirmación rápida en el botón
        local originalColor = EnterBtn.BackgroundColor3
        EnterBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        EnterBtn.Text = "TERSIMPAN!"
        task.wait(0.8)
        EnterBtn.BackgroundColor3 = originalColor
        EnterBtn.Text = "MASUK"
    end
end)

-- Lógica del Segundo EditText (Iklan / Announce)
AnnounceInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and AnnounceInput.Text ~= "" then
        -- Formato requerido: USER: [Nombre] | [Mensaje]
        local mensajeFormateado = "USER: " .. currentUserName .. " | " .. AnnounceInput.Text
        
        -- Imprimir en Consola de Ejecutor
        print(mensajeFormateado)
        
        -- Simulación de Mensaje Global en Chat de Roblox (Local)
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[Fhex Hub] " .. mensajeFormateado,
            Color = Color3.fromRGB(0, 255, 150),
            Font = Enum.Font.SourceSansBold,
            FontSize = Enum.FontSize.Size18
        })
        
        AnnounceInput.Text = "" -- Limpiar campo
    end
end)

-- Sistema de Arrastre Móvil / PC (Drag)
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
