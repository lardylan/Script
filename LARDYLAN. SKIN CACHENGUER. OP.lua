-- [[ LARDYLAN GUI HUB - VERSIÓN FINAL RECONSTRUIDA ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Crear ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LardyLanHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ==========================================
-- FUNCIÓN GLOBAL: MOVIMIENTO (DEDOS Y MOUSE)
-- ==========================================
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==========================================
-- FUNCIÓN GLOBAL: DISEÑO MODERNIZADO LARDYLAN
-- ==========================================
local function ApplyStyle(frame, title, sizeX, sizeY)
    frame.Size = UDim2.new(0, sizeX, 0, sizeY)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Fondo Gris
    frame.BorderSizePixel = 0
    frame.Active = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14) -- Redondeado
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 120, 255) -- Lineales Redondos Azules
    stroke.Thickness = 2.5
    stroke.Parent = frame

    -- Barra superior de Título
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundTransparency = 1
    topBar.Parent = frame

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(0.7, 0, 1, 0)
    txt.Position = UDim2.new(0, 18, 0, 0)
    txt.Text = title
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.TextSize = 22
    txt.Font = Enum.Font.GothamBold
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.BackgroundTransparency = 1
    txt.Parent = topBar

    -- Botón de Minimizar (-)
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 35, 0, 35)
    minBtn.Position = UDim2.new(1, -45, 0, 5)
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 26
    minBtn.Font = Enum.Font.GothamBold
    minBtn.BackgroundTransparency = 1
    minBtn.Parent = topBar

    -- Contenedor interno deslizable/ocultable
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, 0, 1, -45)
    container.Position = UDim2.new(0, 0, 0, 45)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    container.Parent = frame

    -- Animación de minimizado suave (0.6 segundos)
    local isMin = false
    minBtn.MouseButton1Click:Connect(function()
        local targetSize = isMin and UDim2.new(0, sizeX, 0, sizeY) or UDim2.new(0, sizeX, 0, 45)
        local contentSize = isMin and UDim2.new(1, 0, 1, -45) or UDim2.new(1, 0, 0, 0)
        
        container:TweenSize(contentSize, "Out", "Quad", 0.6, true)
        TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        isMin = not isMin
    end)

    MakeDraggable(frame)
    return container
end

-- ==========================================
-- CONSTRUCCIÓN: MENÚ PRINCIPAL LARDYLAN
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.Parent = ScreenGui
local MainContent = ApplyStyle(MainFrame, "LARDYLAN", 350, 250)

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 15)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center
Layout.Parent = MainContent

local function CreateButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 290, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamSemibold
    
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 8) c.Parent = btn
    local s = Instance.new("UIStroke") s.Color = Color3.fromRGB(0, 120, 255) s.Thickness = 1 s.Parent = btn
    btn.Parent = MainContent
    return btn
end

local AimbotBtn = CreateButton("AIMBOT: OFF")
local SkinsBtn = CreateButton("LARDYLAN Skins")

-- ==========================================
-- LÓGICA: AIMBOT FIJO A LA CABEZA
-- ==========================================
local aimbotEnabled = false
local function getClosestEnemyHead()
    local closestHead = nil
    local shortestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            if player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character.Humanoid.Health > 0 then
                local head = player.Character.Head
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < shortestDistance then
                        closestHead = head
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    return closestHead
end

AimbotBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotBtn.Text = aimbotEnabled and "AIMBOT: ON" or "AIMBOT: OFF"
    AimbotBtn.TextColor3 = aimbotEnabled and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 255, 255)
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local targetHead = getClosestEnemyHead()
        if targetHead then Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position) end
    end
end)

-- ==========================================
-- LÓGICA CON RECONSTRUCCIÓN: LARDYLAN SKIN
-- ==========================================
SkinsBtn.MouseButton1Click:Connect(function()
    -- Crear de inmediato la ventana secundaria con el mismo diseño nativo
    local SkinFrame = Instance.new("Frame")
    SkinFrame.Position = UDim2.new(0.5, -175, 0.5, 140) -- Se posiciona un poco más abajo para no encimarse
    SkinFrame.Parent = ScreenGui
    local SkinContent = ApplyStyle(SkinFrame, "LARDYLAN SKIN", 350, 300)

    -- Crear contenedor interno deslizable para almacenar las armas del mod original
    local Scrolling = Instance.new("ScrollingFrame")
    Scrolling.Size = UDim2.new(1, -20, 1, -20)
    Scrolling.Position = UDim2.new(0, 10, 0, 10)
    Scrolling.BackgroundTransparency = 1
    Scrolling.CanvasSize = UDim2.new(0, 0, 2, 0)
    Scrolling.ScrollBarThickness = 4
    Scrolling.Parent = SkinContent

    local SkinLayout = Instance.new("UIListLayout")
    SkinLayout.Padding = UDim.new(0, 10)
    SkinLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SkinLayout.Parent = Scrolling

    -- Ejecuta el mod de skins aislando los elementos viejos y pasándolos a nuestra ventana
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/hr6aouJe/raw"))()
        end)

        -- Esperar a que los botones del mod carguen y moverlos limpiamente a nuestra interfaz
        local coreGui = game:GetService("CoreGui")
        local targets = {LocalPlayer:FindFirstChild("PlayerGui"), coreGui}
        
        for i = 1, 50 do
            for _, source in ipairs(targets) do
                if source then
                    for _, obj in ipairs(source:GetDescendants()) do
                        -- Si detecta el menú feo original de Noks, lo oculta para que no estorbe
                        if obj:IsA("Frame") and obj ~= MainFrame and obj ~= SkinFrame and (obj.Name == "SkinsFrame" or string.find(string.lower(obj.Name), "skin")) then
                            obj.Transparency = 1
                            obj.Visible = false
                            -- Mueve todos sus botones interactivos de armas a nuestra lista limpia LARDYLAN
                            for _, weaponBtn in ipairs(obj:GetChildren()) do
                                if weaponBtn:IsA("TextButton") then
                                    weaponBtn.Parent = Scrolling
                                    weaponBtn.Size = UDim2.new(0, 280, 0, 40)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)
