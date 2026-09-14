-- ⚔️ LARDYLAN HUB / DUELOS VS SHERIFFS ⚔️
-- ✅ Clave: ELLARDYLANHUBXD
-- ✅ SOLO ACTIVO EN PVP | En Obby NO funciona | VEE A TRAVÉS DE PAREDES | Solo Enemigos | Líneas Blancas | HitBox Verde | Muerte Segura

repeat task.wait() until game:IsLoaded()

-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- CONFIGURACIÓN
_G.HitboxSize = Vector3.new(4, 6, 4)       -- Tamaño del cuadro verde
_G.LineColor = Color3.new(1, 1, 1)         -- Blanco
_G.BoxColor = Color3.new(0, 1, 0)           -- Verde
_G.TeamCheck = true                          -- ✅ IGNORA A TU EQUIPO
_G.VerParedes = true                         -- ✅ ACTIVADO: VER TODO A TRAVÉS DE MUROS

-- INTERFAZ PRINCIPAL
local UI = Instance.new("ScreenGui")
UI.Name = "LARDYLAN_HUB_DUELS"
UI.Parent = LocalPlayer:WaitForChild("PlayerGui")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.AlwaysOnTop = true -- Para que nada lo tape
UI.Enabled = false -- 🔴 EMPIEZA DESACTIVADO HASTA ENTRAR A PVP

-- TITULO ARRIBA
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 320, 0, 42)
Title.Position = UDim2.new(0.5, -160, 0, 10)
Title.BackgroundTransparency = 0.7
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.Text = "DUELS ASESINO VS SHERIFFS"
Title.TextColor3 = Color3.new(0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 19
Title.Parent = UI
Title.AnchorPoint = Vector2.new(0.5, 0)

-- ALMACENAMIENTO
local Drawings = {}
local EnZonaPVP = false -- 🔴 VARIABLE PARA SABER DONDE ESTÁS

-- ✅ DETECTAR SI ESTÁS EN ZONA DE PVP
local function RevisarZona()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        EnZonaPVP = false
        return
    end

    -- RAYO HACIA ABAJO PARA DETECTAR EL SUELO
    local suelo = Workspace:FindPartOnRay(Ray.new(char.HumanoidRootPart.Position, Vector3.new(0, -15, 0)), char)

    -- ✅ SI EL SUELO SE LLAMA: PVP, DUELO, COMBATE O ARENA → SE ACTIVA
    if suelo and (
       suelo.Name:lower():find("pvp") or 
       suelo.Name:lower():find("duelo") or 
       suelo.Name:lower():find("combate") or 
       suelo.Name:lower():find("arena")
    ) then
        EnZonaPVP = true
        UI.Enabled = true
    else
        -- SI ES OBBY, INICIO O CUALQUIER OTRA COSA → SE DESACTIVA
        EnZonaPVP = false
        UI.Enabled = false
        -- BORRA MARCAS SI SALES DE PVP
        for _,d in pairs(Drawings) do if d then d:Remove() end end
        Drawings = {}
    end
end

-- FUNCIONES
local function EsEnemigo(jugador)
    if jugador == LocalPlayer then return false end
    if _G.TeamCheck and jugador.Team == LocalPlayer.Team then return false end
    return true
end

-- CREA EL HITBOX FÍSICO VERDE
local function CrearHitbox(personaje)
    if not personaje:FindFirstChild("Hitbox") then
        local Hitbox = Instance.new("Part")
        Hitbox.Name = "Hitbox"
        Hitbox.Size = _G.HitboxSize
        Hitbox.Color = Color3.new(0, 1, 0)
        Hitbox.Transparency = 0.6 -- Un poco transparente pero se ve
        Hitbox.CanCollide = false
        Hitbox.Anchored = true
        Hitbox.Parent = personaje
        Hitbox.CFrame = personaje.Head.CFrame
        
        -- SEGUIR LA CABEZA SOLO SI ESTÁ EN PVP
        RunService.RenderStepped:Connect(function()
            if personaje and personaje:FindFirstChild("Head") and Hitbox then
                if EnZonaPVP then
                    Hitbox.CFrame = personaje.Head.CFrame
                    Hitbox.Visible = true -- ✅ SIEMPRE VISIBLE, AUN DETRÁS DE PAREDES
                else
                    Hitbox.Visible = false -- 🔴 OCULTO FUERA DE PVP
                end
            end
        end)
    end
end

-- DIBUJAR LÍNEAS Y CUADROS (SOLO SI ESTÁ EN PVP)
RunService.RenderStepped:Connect(function()
    RevisarZona() -- 🔴 REVISA LA ZONA CADA FRAME

    -- 🚫 SI NO ESTÁS EN PVP, NO DIBUJA NADA
    if not EnZonaPVP then
        for _, dibujo in pairs(Drawings) do
            if dibujo then dibujo:Remove() end
        end
        Drawings = {}
        return
    end

    -- ✅ SI ESTÁ EN PVP, HACE LO DE SIEMPRE
    -- BORRA DIBUJOS ANTERIORES
    for _, dibujo in pairs(Drawings) do
        if dibujo then dibujo:Remove() end
    end
    Drawings = {}

    -- RECORRER TODOS LOS JUGADORES
    for _, jugador in pairs(Players:GetPlayers()) do
        if EsEnemigo(jugador) and jugador.Character and jugador.Character:FindFirstChild("Head") then
            local char = jugador.Character
            local cabeza = char.Head
            
            -- ✅ OBTENER POSICIÓN Y OMITIR SI ESTÁ OCULTO (FORZAMOS VISUALIZACIÓN)
            local posicionPantalla, visible = Camera:WorldToViewportPoint(cabeza.Position)
            visible = true -- <<< TRUCO: FORZAMOS QUE SE VEA SIEMPRE, IGUAL SI HAY MUROS

            if visible then
                -- 🔹 LÍNEA BLANCA DESDE TU PIE HASTA EL ENEMIGO
                local Linea = Instance.new("Frame", UI)
                Linea.BackgroundColor3 = _G.LineColor
                Linea.BorderSizePixel = 0
                Linea.AnchorPoint = Vector2.new(0.5, 0.5)

                local inicio = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                local fin = Vector2.new(posicionPantalla.X, posicionPantalla.Y)

                local dx = fin.X - inicio.X
                local dy = fin.Y - inicio.Y
                local largo = math.sqrt(dx*dx + dy*dy)
                local angulo = math.deg(math.atan2(dy, dx))

                Linea.Size = UDim2.new(0, largo, 0, 1.2)
                Linea.Position = UDim2.new(0, (inicio.X + fin.X)/2, 0, (inicio.Y + fin.Y)/2)
                Linea.Rotation = angulo
                Linea.ZIndex = 10 -- Para que esté por encima de todo

                -- 🔹 CUADRO VERDE (MARCADOR DEL HITBOX)
                local Cuadro = Instance.new("Frame", UI)
                Cuadro.BackgroundTransparency = 1
                Cuadro.BorderColor3 = _G.BoxColor
                Cuadro.BorderSizePixel = 2
                Cuadro.Size = UDim2.new(0, 42, 0, 62)
                Cuadro.Position = UDim2.new(0, posicionPantalla.X - 21, 0, posicionPantalla.Y - 31)
                Cuadro.ZIndex = 10 -- SIEMPRE VISIBLE

                table.insert(Drawings, Linea)
                table.insert(Drawings, Cuadro)

                -- CREA Y MANTIENE EL HITBOX FÍSICO
                CrearHitbox(char)
            end
        end
    end
end)

-- 🔫 DETECCIÓN DE TIRO: SOLO FUNCIONA SI ESTÁS EN PVP
Mouse.Button1Down:Connect(function()
    if not EnZonaPVP then return end -- 🚫 SI NO ES PVP, EL TIRO NO HACE NADA

    local rayo = Ray.new(Camera.CFrame.Position, (Mouse.Hit.Position - Camera.CFrame.Position).Unit * 1000)
    -- <<< PARÁMETRO ESPECIAL: OMITIR OBSTÁCULOS AL DETECTAR EL TIRO
    local parte, posicionGolpe = Workspace:FindPartOnRay(rayo, LocalPlayer.Character, false, true)

    if parte then
        -- SI LO QUE TOCAMOS ES EL HITBOX VERDE
        if parte.Name == "Hitbox" then
            local personajeGolpeado = parte.Parent
            if personajeGolpeado and personajeGolpeado:FindFirstChild("Humanoid") then
                personajeGolpeado.Humanoid.Health = 0 -- 💥 MUERTE INSTANTE
            end
        end
    end
end)

-- MENSAJE DE CARGA
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✅ LARDYLAN HUB CARGADO",
    Text = "Esperando zona de PVP...",
    Duration = 4
})
