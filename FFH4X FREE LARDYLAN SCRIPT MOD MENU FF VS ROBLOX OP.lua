-- CREADO ESPECIALMENTE PARA @lardylan
-- DISEÑO: Marco Redondo Neón Azul | Fondo Rojo Oscuro Transparente
-- SISTEMA: Key de Acceso + Expiración + Funciones Visuales y de Combate

--[[
    CARACTERÍSTICAS:
    • Menú redondo con borde neón azul brillante
    • Fondo rojo oscuro transparente
    • Botón minimizar (- / +) y botón cerrar (X)
    • Sección AIMBOT con velocidades: 75% / 35% / 1%
    • Sección VISUAL: ESP, Esqueleto, Cuadrado, Antenas (solo tú lo ves)
    • Sección CONFIG: Cambio de color del menú y vista de tu personaje
    • SISTEMA DE EXPIRACIÓN: 12/6/26 → Si pasa la fecha = Expulsión
    • KEY DE ACCESO: Key29339
    • AL EJECUTAR: Se copia automáticamente tu canal de YouTube
]]

-- COPIAR CANAL AL EJECUTAR
setclipboard("https://www.youtube.com/@lardylan")

-- CONFIGURACIÓN DE FECHA DE EXPIRACIÓN
local fechaExpiracion = {dia = 12, mes = 6, anio = 2026}
local fechaActual = os.date("*t")
if (fechaActual.year > fechaExpiracion.anio) or 
   (fechaActual.year == fechaExpiracion.anio and fechaActual.month > fechaExpiracion.mes) or 
   (fechaActual.year == fechaExpiracion.anio and fechaActual.month == fechaExpiracion.mes and fechaActual.day >= fechaExpiracion.dia) then
    game.Players.LocalPlayer:Kick("ESTE SCRIPT EXPIRADO")
    return
end

-- SERVICIOS
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- VARIABLES DE ESTADO
local Estado = {
    AimbotActivo = false,
    VelocidadAim = 0.75, -- 75% por defecto
    ESP_Activo = false,
    ESP_Esqueleto = false,
    ESP_Cuadrado = false,
    ESP_Antenas = false,
    ColorMenu = Color3.new(1, 0, 0) -- Rojo por defecto
}

-- 🟦 INTERFAZ GRÁFICA (GUI)
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "FFH4X_LARDYLAN"
MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MARCO PRINCIPAL (Redondo, Neón Azul, Fondo Rojo Transparente)
local MarcoPrincipal = Instance.new("Frame")
MarcoPrincipal.Name = "MarcoPrincipal"
MarcoPrincipal.Parent = MainGui
MarcoPrincipal.BackgroundColor3 = Color3.new(0.3, 0, 0) -- Rojo oscuro
MarcoPrincipal.BackgroundTransparency = 0.3
MarcoPrincipal.Position = UDim2.new(0.15, 0, 0.15, 0)
MarcoPrincipal.Size = UDim2.new(0, 320, 0, 450)
MarcoPrincipal.BorderSizePixel = 0
MarcoPrincipal.ClipsDescendants = true

-- ESQUINAS REDONDAS
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.15, 0)
UICorner.Parent = MarcoPrincipal

-- BORDE NEÓN AZUL BRILLANTE
local UIGradienteBorde = Instance.new("UIStroke")
UIGradienteBorde.Name = "BordeNeon"
UIGradienteBorde.Parent = MarcoPrincipal
UIGradienteBorde.Color = Color3.new(0, 0.8, 1) -- Azul neón
UIGradienteBorde.Thickness = 4
UIGradienteBorde.Transparency = 0
UIGradienteBorde.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- TITULO SUPERIOR
local TituloPrincipal = Instance.new("TextLabel")
TituloPrincipal.Name = "TituloPrincipal"
TituloPrincipal.Parent = MarcoPrincipal
TituloPrincipal.BackgroundTransparency = 1
TituloPrincipal.Position = UDim2.new(0.1, 0, 0.02, 0)
TituloPrincipal.Size = UDim2.new(0.7, 0, 0, 30)
TituloPrincipal.Font = Enum.Font.GothamBold
TituloPrincipal.Text = "FFH4X FREE LARDYLAN"
TituloPrincipal.TextColor3 = Color3.new(1, 1, 1)
TituloPrincipal.TextScaled = true

-- BOTÓN MINIMIZAR (-)
local BtnMinimizar = Instance.new("TextButton")
BtnMinimizar.Name = "BtnMinimizar"
BtnMinimizar.Parent = MarcoPrincipal
BtnMinimizar.BackgroundTransparency = 1
BtnMinimizar.Position = UDim2.new(0.8, 0, 0.02, 0)
BtnMinimizar.Size = UDim2.new(0, 25, 0, 25)
BtnMinimizar.Font = Enum.Font.GothamBold
BtnMinimizar.Text = "-"
BtnMinimizar.TextColor3 = Color3.new(1, 1, 1)
BtnMinimizar.TextScaled = true

-- BOTÓN CERRAR (X)
local BtnCerrar = Instance.new("TextButton")
BtnCerrar.Name = "BtnCerrar"
BtnCerrar.Parent = MarcoPrincipal
BtnCerrar.BackgroundTransparency = 1
BtnCerrar.Position = UDim2.new(0.9, 0, 0.02, 0)
BtnCerrar.Size = UDim2.new(0, 25, 0, 25)
BtnCerrar.Font = Enum.Font.GothamBold
BtnCerrar.Text = "X"
BtnCerrar.TextColor3 = Color3.new(1, 0, 0)
BtnCerrar.TextScaled = true

-- TEXTO LARDYLAN ARRIBA
local TextoLardylan = Instance.new("TextLabel")
TextoLardylan.Name = "TextoLardylan"
TextoLardylan.Parent = MarcoPrincipal
TextoLardylan.BackgroundTransparency = 1
TextoLardylan.Position = UDim2.new(0.05, 0, 0.08, 0)
TextoLardylan.Size = UDim2.new(0.6, 0, 0, 25)
TextoLardylan.Font = Enum.Font.GothamBold
TextoLardylan.Text = "LARDYLAN"
TextoLardylan.TextColor3 = Color3.new(0, 0.8, 1)
TextoLardylan.TextScaled = true

-- BOTÓN OCULTAR/MOSTRAR MENÚ (- / +)
local BtnOcultar = Instance.new("TextButton")
BtnOcultar.Name = "BtnOcultar"
BtnOcultar.Parent = MarcoPrincipal
BtnOcultar.BackgroundTransparency = 1
BtnOcultar.Position = UDim2.new(0.65, 0, 0.08, 0)
BtnOcultar.Size = UDim2.new(0, 25, 0, 25)
BtnOcultar.Font = Enum.Font.GothamBold
BtnOcultar.Text = "-"
BtnOcultar.TextColor3 = Color3.new(1, 1, 1)
BtnOcultar.TextScaled = true

-- CONTENEDOR DE SECCIONES
local ContenedorSecciones = Instance.new("Frame")
ContenedorSecciones.Name = "ContenedorSecciones"
ContenedorSecciones.Parent = MarcoPrincipal
ContenedorSecciones.BackgroundTransparency = 1
ContenedorSecciones.Position = UDim2.new(0.05, 0, 0.15, 0)
ContenedorSecciones.Size = UDim2.new(0.9, 0, 0.8, 0)

-- ✅ SECCIÓN AIMBOT
local SeccionAimbot = Instance.new("Frame")
SeccionAimbot.Name = "SeccionAimbot"
SeccionAimbot.Parent = ContenedorSecciones
SeccionAimbot.BackgroundColor3 = Color3.new(0.2, 0, 0)
SeccionAimbot.BackgroundTransparency = 0.5
SeccionAimbot.Position = UDim2.new(0, 0, 0, 0)
SeccionAimbot.Size = UDim2.new(1, 0, 0, 110)
SeccionAimbot.BorderSizePixel = 0

local TituloAimbot = Instance.new("TextLabel")
TituloAimbot.Name = "TituloAimbot"
TituloAimbot.Parent = SeccionAimbot
TituloAimbot.BackgroundTransparency = 1
TituloAimbot.Position = UDim2.new(0.05, 0, 0.05, 0)
TituloAimbot.Size = UDim2.new(0.6, 0, 0, 20)
TituloAimbot.Font = Enum.Font.GothamBold
TituloAimbot.Text = "AIMBOT FULL"
TituloAimbot.TextColor3 = Color3.new(1, 1, 1)
TituloAimbot.TextScaled = true

local BtnAimbot = Instance.new("TextButton")
BtnAimbot.Name = "BtnAimbot"
BtnAimbot.Parent = SeccionAimbot
BtnAimbot.BackgroundColor3 = Color3.new(0.4, 0, 0)
BtnAimbot.BackgroundTransparency = 0.3
BtnAimbot.Position = UDim2.new(0.75, 0, 0.05, 0)
BtnAimbot.Size = UDim2.new(0, 30, 0, 20)
BtnAimbot.Font = Enum.Font.GothamBold
BtnAimbot.Text = "❎"
BtnAimbot.TextColor3 = Color3.new(1, 1, 1)
BtnAimbot.TextScaled = true

-- VELOCIDADES DE APUNTADO
local BtnVelocidad = Instance.new("TextButton")
BtnVelocidad.Name = "BtnVelocidad"
BtnVelocidad.Parent = SeccionAimbot
BtnVelocidad.BackgroundColor3 = Color3.new(0.4, 0, 0)
BtnVelocidad.BackgroundTransparency = 0.3
BtnVelocidad.Position = UDim2.new(0.05, 0, 0.45, 0)
BtnVelocidad.Size = UDim2.new(0.9, 0, 0, 25)
BtnVelocidad.Font = Enum.Font.Gotham
BtnVelocidad.Text = "75% 🔼"
BtnVelocidad.TextColor3 = Color3.new(1, 1, 1)
BtnVelocidad.TextScaled = true

local OpcionesVelocidad = Instance.new("Frame")
OpcionesVelocidad.Name = "OpcionesVelocidad"
OpcionesVelocidad.Parent = SeccionAimbot
OpcionesVelocidad.BackgroundColor3 = Color3.new(0.3, 0, 0)
OpcionesVelocidad.BackgroundTransparency = 0.5
OpcionesVelocidad.Position = UDim2.new(0.05, 0, 0.72, 0)
OpcionesVelocidad.Size = UDim2.new(0.9, 0, 0, 0)
OpcionesVelocidad.Visible = false
OpcionesVelocidad.BorderSizePixel = 0

local Op1 = Instance.new("TextButton")
Op1.Name = "Op1"
Op1.Parent = OpcionesVelocidad
Op1.BackgroundTransparency = 1
Op1.Size = UDim2.new(1, 0, 0, 20)
Op1.Font = Enum.Font.Gotham
Op1.Text = "75% - Rápido"
Op1.TextColor3 = Color3.new(1, 1, 1)
Op1.TextScaled = true

local Op2 = Instance.new("TextButton")
Op2.Name = "Op2"
Op2.Parent = OpcionesVelocidad
Op2.BackgroundTransparency = 1
Op2.Position = UDim2.new(0, 0, 0.33, 0)
Op2.Size = UDim2.new(1, 0, 0, 20)
Op2.Font = Enum.Font.Gotham
Op2.Text = "35% - Medio"
Op2.TextColor3 = Color3.new(1, 1, 1)
Op2.TextScaled = true

local Op3 = Instance.new("TextButton")
Op3.Name = "Op3"
Op3.Parent = OpcionesVelocidad
Op3.BackgroundTransparency = 1
Op3.Position = UDim2.new(0, 0, 0.66, 0)
Op3.Size = UDim2.new(1, 0, 0, 20)
Op3.Font = Enum.Font.Gotham
Op3.Text = "1% - Lento"
Op3.TextColor3 = Color3.new(1, 1, 1)
Op3.TextScaled = true

-- 🎨 SECCIÓN VISUAL
local SeccionVisual = Instance.new("Frame")
SeccionVisual.Name = "SeccionVisual"
SeccionVisual.Parent = ContenedorSecciones
SeccionVisual.BackgroundColor3 = Color3.new(0.2, 0, 0)
SeccionVisual.BackgroundTransparency = 0.5
SeccionVisual.Position = UDim2.new(0, 0, 0.26, 0)
SeccionVisual.Size = UDim2.new(1, 0, 0, 160)
SeccionVisual.BorderSizePixel = 0

local TituloVisual = Instance.new("TextLabel")
TituloVisual.Name = "TituloVisual"
TituloVisual.Parent = SeccionVisual
TituloVisual.BackgroundTransparency = 1
TituloVisual.Position = UDim2.new(0.05, 0, 0.02, 0)
TituloVisual.Size = UDim2.new(0.5, 0, 0, 20)
TituloVisual.Font = Enum.Font.GothamBold
TituloVisual.Text = "VISUAL"
TituloVisual.TextColor3 = Color3.new(1, 1, 1)
TituloVisual.TextScaled = true

-- BOTONES VISUALES
local function CrearBotonVisual(nombre, posY)
    local btn = Instance.new("TextButton")
    btn.Name = "Btn"..nombre
    btn.Parent = SeccionVisual
    btn.BackgroundColor3 = Color3.new(0.4, 0, 0)
    btn.BackgroundTransparency = 0.3
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.Size = UDim2.new(0.9, 0, 0, 25)
    btn.Font = Enum.Font.Gotham
    btn.Text = nombre.." ❎"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextScaled = true
    return btn
end

local BtnESP = CrearBotonVisual("ESP", 0.15)
local BtnESPEsqueleto = CrearBotonVisual("ESP ESQUELETO", 0.38)
local BtnESPCuadrado = CrearBotonVisual("ESP CUADRADO", 0.61)
local BtnAntenas = CrearBotonVisual("ANTENAS", 0.84)

-- ⚙️ SECCIÓN CONFIGURACIÓN
local SeccionConfig = Instance.new("Frame")
SeccionConfig.Name = "SeccionConfig"
SeccionConfig.Parent = ContenedorSecciones
SeccionConfig.BackgroundColor3 = Color3.new(0.2, 0, 0)
SeccionConfig.BackgroundTransparency = 0.5
SeccionConfig.Position = UDim2.new(0, 0, 0.65, 0)
SeccionConfig.Size = UDim2.new(1, 0, 0, 120)
SeccionConfig.BorderSizePixel = 0

local TituloConfig = Instance.new("TextLabel")
TituloConfig.Name = "TituloConfig"
TituloConfig.Parent = SeccionConfig
TituloConfig.BackgroundTransparency = 1
TituloConfig.Position = UDim2.new(0.05, 0, 0.02, 0)
TituloConfig.Size = UDim2.new(0.5, 0, 0, 20)
TituloConfig.Font = Enum.Font.GothamBold
TituloConfig.Text = "CONFIG"
TituloConfig.TextColor3 = Color3.new(1, 1, 1)
TituloConfig.TextScaled = true

-- VISTA DE TU PERSONAJE
local VistaPersonaje = Instance.new("ViewportFrame")
VistaPersonaje.Name = "VistaPersonaje"
VistaPersonaje.Parent = SeccionConfig
VistaPersonaje.BackgroundColor3 = Color3.new(0.1, 0, 0)
VistaPersonaje.BackgroundTransparency = 0.5
VistaPersonaje.Position = UDim2.new(0.6, 0, 0.05, 0)
VistaPersonaje.Size = UDim2.new(0.35, 0, 0, 80)
VistaPersonaje.CurrentCamera = Instance.new("Camera")

-- OPCIÓN DE COLORES
local TextoColorMenu = Instance.new("TextLabel")
TextoColorMenu.Name = "TextoColorMenu"
TextoColorMenu.Parent = SeccionConfig
TextoColorMenu.BackgroundTransparency = 1
TextoColorMenu.Position = UDim2.new(0.05, 0, 0.25, 0)
TextoColorMenu.Size = UDim2.new(0.5, 0, 0, 20)
TextoColorMenu.Font = Enum.Font.Gotham
TextoColorMenu.Text = "Color Menu:"
TextoColorMenu.TextColor3 = Color3.new(1, 1, 1)
TextoColorMenu.TextScaled = true

local CuadroColores = Instance.new("TextButton")
CuadroColores.Name = "CuadroColores"
CuadroColores.Parent = SeccionConfig
CuadroColores.BackgroundColor3 = Color3.new(0.4, 0, 0)
CuadroColores.BackgroundTransparency = 0.3
CuadroColores.Position = UDim2.new(0.05, 0, 0.48, 0)
CuadroColores.Size = UDim2.new(0.5, 0, 0, 25)
CuadroColores.Font = Enum.Font.Gotham
CuadroColores.Text = "🔴 ROJO"
CuadroColores.TextColor3 = Color3.new(1, 1, 1)
CuadroColores.TextScaled = true

local ListaColores = Instance.new("Frame")
ListaColores.Name = "ListaColores"
ListaColores.Parent = SeccionConfig
ListaColores.BackgroundColor3 = Color3.new(0.3, 0, 0)
ListaColores.BackgroundTransparency = 0.5
ListaColores.Position = UDim2.new(0.05, 0, 0.73, 0)
ListaColores.Size = UDim2.new(0.5, 0, 0, 0)
ListaColores.Visible = false
ListaColores.BorderSizePixel = 0

local ColoresDisponibles = {
    {nombre = "AMARILLO", color = Color3.new(1,1,0)},
    {nombre = "ROJO", color = Color3.new(1,0,0)},
    {nombre = "AZUL", color = Color3.new(0,0,1)},
    {nombre = "NEGRO", color = Color3.new(0,0,0)},
    {nombre = "BLANCO", color = Color3.new(1,1,1)},
    {nombre = "ROSA", color = Color3.new(1,0,0.8)},
    {nombre = "ARCOIRIS", color = "rainbow"},
    {nombre = "GRIS", color = Color3.new(0.5,0.5,0.5)},
    {nombre = "MARRON", color = Color3.new(0.6,0.3,0)}
}

for i, info in ipairs(ColoresDisponibles) do
    local btnColor = Instance.new("TextButton")
    btnColor.Name = "Color"..info.nombre
    btnColor.Parent = ListaColores
    btnColor.BackgroundTransparency = 1
    btnColor.Size = UDim2.new(1, 0, 0, 18)
    btnColor.Position = UDim2.new(0, 0, (i-1)*0.11, 0)
    btnColor.Font = Enum.Font.Gotham
    btnColor.Text = info.nombre
    btnColor.TextColor3 = type(info.color) == "Color3" and info.color or Color3.new(1,1,1)
    btnColor.TextScaled = true
end

-- TEXTO DE EXPIRACIÓN
local TextoExpiracion = Instance.new("TextLabel")
TextoExpiracion.Name = "TextoExpiracion"
TextoExpiracion.Parent = MarcoPrincipal
TextoExpiracion.BackgroundTransparency = 1
TextoExpiracion.Position = UDim2.new(0.05, 0, 0.92, 0)
TextoExpiracion.Size = UDim2.new(0.9, 0, 0, 20)
TextoExpiracion.Font = Enum.Font.GothamBold
TextoExpiracion.Text = "EXPIRED: <font color='#00FF00'>12/6/26</font>"
TextoExpiracion.TextColor3 = Color3.new(1, 0, 0)
TextoExpiracion.TextScaled = true
TextoExpiracion.RichText = true

-- 🔑 SISTEMA DE KEY DE ACCESO
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystem"
KeyGui.Parent = LocalPlayer.PlayerGui

local MarcoKey = Instance.new("Frame")
MarcoKey.Name = "MarcoKey"
MarcoKey.Parent = KeyGui
MarcoKey.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MarcoKey.Position = UDim2.new(0.3, 0, 0.4, 0)
MarcoKey.Size = UDim2.new(0, 300, 0, 150)
MarcoKey.BorderSizePixel = 2
MarcoKey.BorderColor3 = Color3.new(0, 0.8, 1)

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0.08, 0)
UICornerKey.Parent = MarcoKey

local TextoKey = Instance.new("TextLabel")
TextoKey.Name = "TextoKey"
TextoKey.Parent = MarcoKey
TextoKey.BackgroundTransparency = 1
TextoKey.Position = UDim2.new(0.05, 0, 0.1, 0)
TextoKey.Size = UDim2.new(0.9, 0, 0, 30)
TextoKey.Font = Enum.Font.GothamBold
TextoKey.Text = "PON LA KEY DE FFH4X BETA"
TextoKey.TextColor3 = Color3.new(1, 1, 1)
TextoKey.TextScaled = true

local InputKey = Instance.new("TextBox")
InputKey.Name = "InputKey"
InputKey.Parent = MarcoKey
InputKey.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InputKey.Position = UDim2.new(0.1, 0, 0.45, 0)
InputKey.Size = UDim2.new(0.8, 0, 0, 30)
InputKey.Font = Enum.Font.Gotham
InputKey.Text = ""
InputKey.PlaceholderText = "Escribe la key aquí..."
InputKey.TextColor3 = Color3.new(1, 1, 1)
InputKey.TextScaled = true

local BtnVerificarKey = Instance.new("TextButton")
BtnVerificarKey.Name = "BtnVerificarKey"
BtnVerificarKey.Parent = MarcoKey
BtnVerificarKey.BackgroundColor3 = Color3.new(0, 0.6, 1)
BtnVerificarKey.Position = UDim2.new(0.3, 0, 0.75, 0)
BtnVerificarKey.Size = UDim2.new(0, 120, 0, 25)
BtnVerificarKey.Font = Enum.Font.GothamBold
BtnVerificarKey.Text = "VERIFICAR"
BtnVerificarKey.TextColor3 = Color3.new(1, 1, 1)
BtnVerificarKey.TextScaled = true

-- ✅ LÓGICA DE FUNCIONAMIENTO

-- VERIFICACIÓN DE KEY
local KeyCorrecta = "Key29339"
local AccesoPermitido = false

BtnVerificarKey.MouseButton1Click:Connect(function()
    if InputKey.Text == KeyCorrecta then
        AccesoPermitido = true
        KeyGui:Destroy()
        MainGui.Enabled = true
        -- Configurar vista de personaje
        task.wait(0.1)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local modelo = LocalPlayer.Character:Clone()
            modelo.Parent = VistaPersonaje
 modelo:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
            VistaPersonaje.CurrentCamera.CFrame = CFrame.new(Vector3.new(2, 1, 0), Vector3.new(0, 1, 0))
        end
    else
        InputKey.Text = ""
        InputKey.PlaceholderText = "¡KEY INCORRECTA!"
        task.wait(2)
        InputKey.PlaceholderText = "Escribe la key aquí..."
    end
end)

-- INICIALIZACIÓN
MainGui.Enabled = false

-- MINIMIZAR Y MOSTRAR/OCULTAR
local MenuOculto = false
BtnOcultar.MouseButton1Click:Connect(function()
    MenuOculto = not MenuOculto
    local objetivoY = MenuOculto and -300 or 0
    local tiempo = 0.3
    -- Animación suave
    local pasos = 20
    for i = 1, pasos do
        ContenedorSecciones.Position = UDim2.new(0.05, 0, 0.15 + (objetivoY * i/pasos), 0)
        task.wait(tiempo/pasos)
    end
    BtnOcultar.Text = MenuOculto and "+" or "-"
end)

BtnMinimizar.MouseButton1Click:Connect(function()
    MarcoPrincipal.Visible = false
    TituloPrincipal.Visible = true
end)

BtnCerrar.MouseButton1Click:Connect(function()
    MainGui:Destroy()
    -- Desactivar todos los sistemas
    Estado.AimbotActivo = false
    Estado.ESP_Activo = false
    Estado.ESP_Esqueleto = false
    Estado.ESP_Cuadrado = false
    Estado.ESP_Antenas = false
end)

-- FUNCIONES DE BOTONES
BtnAimbot.MouseButton1Click:Connect(function()
    Estado.AimbotActivo = not Estado.AimbotActivo
    BtnAimbot.Text = Estado.AimbotActivo and "✅" or "❎"
end)

BtnVelocidad.MouseButton1Click:Connect(function()
    OpcionesVelocidad.Visible = not OpcionesVelocidad.Visible
    if OpcionesVelocidad.Visible then
        OpcionesVelocidad.Size = UDim2.new(0.9, 0, 0, 60)
    else
        OpcionesVelocidad.Size = UDim2.new(0.9, 0, 0, 0)
    end
end)

Op1.MouseButton1Click:Connect(function()
    Estado.VelocidadAim = 0.75
    BtnVelocidad.Text = "75% 🔼"
    OpcionesVelocidad.Visible = false
    OpcionesVelocidad.Size = UDim2.new(0.9, 0, 0, 0)
end)

Op2.MouseButton1Click:Connect(function()
    Estado.VelocidadAim = 0.35
    BtnVelocidad.Text = "35% 🔼"
    OpcionesVelocidad.Visible = false
    OpcionesVelocidad.Size = UDim2.new(0.9, 0, 0, 0)
end)

Op3.MouseButton1Click:Connect(function()
    Estado.VelocidadAim = 0.01
    BtnVelocidad.Text = "1% 🔼"
    OpcionesVelocidad.Visible = false
    OpcionesVelocidad.Size = UDim2.new(0.9, 0, 0, 0)
end)

-- BOTONES VISUALES
BtnESP.MouseButton1Click:Connect(function()
    Estado.ESP_Activo = not Estado.ESP_Activo
    BtnESP.Text = "ESP "..(Estado.ESP_Activo and "✅" or "❎")
end)

BtnESPEsqueleto.MouseButton1Click:Connect(function()
    Estado.ESP_Esqueleto = not Estado.ESP_Esqueleto
    BtnESPEsqueleto.Text = "ESP ESQUELETO "..(Estado.ESP_Esqueleto and "✅" or "❎")
end)

BtnESPCuadrado.MouseButton1Click:Connect(function()
    Estado.ESP_Cuadrado = not Estado.ESP_Cuadrado
    BtnESPCuadrado.Text = "ESP CUADRADO "..(Estado.ESP_Cuadrado and "✅" or "❎")
end)

BtnAntenas.MouseButton1Click:Connect(function()
    Estado.ESP_Antenas = not Estado.ESP_Antenas
    BtnAntenas.Text = "ANTENAS "..(Estado.ESP_Antenas and "✅" or "❎")
end)

-- SISTEMA DE COLORES
CuadroColores.MouseButton1Click:Connect(function()
    ListaColores.Visible = not ListaColores.Visible
    if ListaColores.Visible then
        ListaColores.Size = UDim2.new(0.5, 0, 0, 110)
    else
        ListaColores.Size = UDim2.new(0.5, 0, 0, 0)
    end
end)

for _, btn in ipairs(ListaColores:GetChildren()) do
    if btn:IsA("TextButton") then
        btn.MouseButton1Click:Connect(function()
            local colorSeleccionado = nil
            local nombreColor = btn.Text
            for _, info in ipairs(ColoresDisponibles) do
                if info.nombre == nombreColor then
                    colorSeleccionado = info.color
     
