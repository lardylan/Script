-- Global Config & Key System Storage
local KEY_CORRECTA = "DELTARBX"
local KEY_DURATION = 86400 -- 24 Horas en segundos

if not _G.KeySystemStartTime then
    _G.KeySystemStartTime = os.time()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Parent ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NexxuzLardylanGui"
ScreenGui.ResetOnSpawn = false

-- Protección para Delta / Executors
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Tablas para mantener el efecto Rainbow activo
local RainbowLabels = {}
local RainbowBorders = {}

RunService.RenderStepped:Connect(function()
    local hue = (tick() % 5) / 5
    local color = Color3.fromHSV(hue, 1, 1)
    
    for _, lbl in ipairs(RainbowLabels) do
        if lbl and lbl.Parent then
            lbl.TextColor3 = color
        end
    end
    for _, uiStroke in ipairs(RainbowBorders) do
        if uiStroke and uiStroke.Parent then
            uiStroke.Color = color
        end
    end
end)

local function applyRainbowText(obj)
    table.insert(RainbowLabels, obj)
end

local function applyRainbowBorder(uiStroke)
    table.insert(RainbowBorders, uiStroke)
end

-- Panel de Estado / Notificaciones (Lado Derecho)
local StatusPanel = Instance.new("Frame")
StatusPanel.Size = UDim2.new(0, 220, 0, 100)
StatusPanel.Position = UDim2.new(0.5, 230, 0.4, 0)
StatusPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
StatusPanel.Parent = ScreenGui

local StatusUICorner = Instance.new("UICorner", StatusPanel)
StatusUICorner.CornerRadius = UDim.new(0, 12)

local StatusStroke = Instance.new("UIStroke", StatusPanel)
StatusStroke.Thickness = 2
applyRainbowBorder(StatusStroke)

local StatusTitle = Instance.new("TextLabel", StatusPanel)
StatusTitle.Size = UDim2.new(1, 0, 0, 30)
StatusTitle.BackgroundTransparency = 1
StatusTitle.Font = Enum.Font.SourceSansBold
StatusTitle.TextSize = 16
StatusTitle.Text = "[ ESTADO DEL SCRIPT ]"
applyRainbowText(StatusTitle)

local StatusText = Instance.new("TextLabel", StatusPanel)
StatusText.Size = UDim2.new(1, -20, 1, -35)
StatusText.Position = UDim2.new(0, 10, 0, 30)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.SourceSans
StatusText.TextSize = 14
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextWrapped = true
StatusText.Text = "Iniciando proceso..."

local function setStatus(msg, isError)
    StatusText.Text = msg
    if isError then
        StatusText.TextColor3 = Color3.fromRGB(255, 70, 70)
    else
        StatusText.TextColor3 = Color3.fromRGB(70, 255, 70)
    end
end

-- ==========================================
-- FASE 1: CARGADOR INICIAL (LARDYLAN CARGANDO)
-- ==========================================

local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.Size = UDim2.new(0, 350, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, -175, 0.4, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local LoadCorner = Instance.new("UICorner", LoadingFrame)
LoadCorner.CornerRadius = UDim.new(0, 16)

local LoadStroke = Instance.new("UIStroke", LoadingFrame)
LoadStroke.Thickness = 2
applyRainbowBorder(LoadStroke)

local LoadTitle = Instance.new("TextLabel", LoadingFrame)
LoadTitle.Size = UDim2.new(1, 0, 0, 50)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Font = Enum.Font.SourceSansBold
LoadTitle.TextSize = 22
LoadTitle.Text = "LARDYLAN CARGANDO"
applyRainbowText(LoadTitle)

local LoadProgress = Instance.new("TextLabel", LoadingFrame)
LoadProgress.Size = UDim2.new(1, 0, 0, 50)
LoadProgress.Position = UDim2.new(0, 0, 0, 60)
LoadProgress.BackgroundTransparency = 1
LoadProgress.Font = Enum.Font.SourceSansBold
LoadProgress.TextSize = 28
LoadProgress.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadProgress.Text = "0%"

setStatus("Cargando archivos del Script...", false)

task.spawn(function()
    for i = 1, 100 do
        LoadProgress.Text = tostring(i) .. "%"
        task.wait(0.04) -- Carga lenta y progresiva
    end
    LoadingFrame:Destroy()
    
    -- ==========================================
    -- FASE 2: KEY SYSTEM GUI
    -- ==========================================
    
    local KeyFrame = Instance.new("Frame", ScreenGui)
    KeyFrame.Size = UDim2.new(0, 400, 0, 240)
    KeyFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    
    local KeyCorner = Instance.new("UICorner", KeyFrame)
    KeyCorner.CornerRadius = UDim.new(0, 16)
    
    local KeyStroke = Instance.new("UIStroke", KeyFrame)
    KeyStroke.Thickness = 2
    applyRainbowBorder(KeyStroke)
    
    local KeyTitle = Instance.new("TextLabel", KeyFrame)
    KeyTitle.Size = UDim2.new(1, 0, 0, 45)
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Font = Enum.Font.SourceSansBold
    KeyTitle.TextSize = 20
    KeyTitle.Text = "NEXXUZHUB LARDYLAN HUB"
    applyRainbowText(KeyTitle)
    
    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
    KeyInput.Position = UDim2.new(0.1, 0, 0, 55)
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.PlaceholderText = "Ingresa la Key aquí..."
    KeyInput.Text = ""
    KeyInput.Font = Enum.Font.SourceSans
    KeyInput.TextSize = 16
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    local KeyInputCorner = Instance.new("UICorner", KeyInput)
    KeyInputCorner.CornerRadius = UDim.new(0, 8)
    
    local KeyInputStroke = Instance.new("UIStroke", KeyInput)
    KeyInputStroke.Thickness = 1.5
    applyRainbowBorder(KeyInputStroke)
    
    local SubmitBtn = Instance.new("TextButton", KeyFrame)
    SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
    SubmitBtn.Position = UDim2.new(0.1, 0, 0, 110)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SubmitBtn.Font = Enum.Font.SourceSansBold
    SubmitBtn.TextSize = 18
    SubmitBtn.Text = "VERIFICAR KEY"
    applyRainbowText(SubmitBtn)
    
    local SubmitCorner = Instance.new("UICorner", SubmitBtn)
    SubmitCorner.CornerRadius = UDim.new(0, 8)
    
    local SubmitStroke = Instance.new("UIStroke", SubmitBtn)
    SubmitStroke.Thickness = 1.5
    applyRainbowBorder(SubmitStroke)
    
    local ExpireLabel = Instance.new("TextLabel", KeyFrame)
    ExpireLabel.Size = UDim2.new(1, 0, 0, 30)
    ExpireLabel.Position = UDim2.new(0, 0, 0, 175)
    ExpireLabel.BackgroundTransparency = 1
    ExpireLabel.Font = Enum.Font.SourceSans
    ExpireLabel.TextSize = 14
    ExpireLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    -- Contador de Expiración (24 Horas)
    task.spawn(function()
        while KeyFrame and KeyFrame.Parent do
            local elapsed = os.time() - _G.KeySystemStartTime
            local remaining = KEY_DURATION - elapsed
            if remaining <= 0 then
                ExpireLabel.Text = "Expire Key: EXPIRED"
                setStatus("KEY EXPIRADO", true)
            else
                local hrs = math.floor(remaining / 3600)
                local mins = math.floor((remaining % 3600) / 60)
                local secs = remaining % 60
                ExpireLabel.Text = string.format("Expire Key: %02d:%02d:%02d", hrs, mins, secs)
            end
            task.wait(1)
        end
    end)
    
    setStatus("Esperando ingreso de Key...", false)
    
    SubmitBtn.MouseButton1Click:Connect(function()
        local elapsed = os.time() - _G.KeySystemStartTime
        if elapsed >= KEY_DURATION then
            setStatus("KEY EXPIRADO", true)
            return
        end
        
        if KeyInput.Text == KEY_CORRECTA then
            setStatus("Key Correcta. Cargando Menu...", false)
            task.wait(1)
            KeyFrame:Destroy()
            StatusPanel:Destroy()
            
            -- ==========================================
            -- FASE 3: MAIN HUB GUI
            -- ==========================================
            
            local MainFrame = Instance.new("Frame", ScreenGui)
            MainFrame.Size = UDim2.new(0, 480, 0, 320)
            MainFrame.Position = UDim2.new(0.5, -240, 0.35, 0)
            MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            MainFrame.ClipsDescendants = true
            MainFrame.Active = true
            MainFrame.Draggable = true
            
            local MainCorner = Instance.new("UICorner", MainFrame)
            MainCorner.CornerRadius = UDim.new(0, 14)
            
            local MainStroke = Instance.new("UIStroke", MainFrame)
            MainStroke.Thickness = 2
            applyRainbowBorder(MainStroke)
            
            -- Barra Superior
            local TopBar = Instance.new("Frame", MainFrame)
            TopBar.Size = UDim2.new(1, 0, 0, 40)
            TopBar.BackgroundTransparency = 1
            
            local HeaderTitle = Instance.new("TextLabel", TopBar)
            HeaderTitle.Size = UDim2.new(0.6, 0, 1, 0)
            HeaderTitle.Position = UDim2.new(0, 15, 0, 0)
            HeaderTitle.BackgroundTransparency = 1
            HeaderTitle.Font = Enum.Font.SourceSansBold
            HeaderTitle.TextSize = 18
            HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
            HeaderTitle.Text = "NEXXUZHUB LARDYLAN HUB"
            applyRainbowText(HeaderTitle)
            
            -- Botón Cerrar (X)
            local CloseBtn = Instance.new("TextButton", TopBar)
            CloseBtn.Size = UDim2.new(0, 30, 0, 30)
            CloseBtn.Position = UDim2.new(1, -35, 0, 5)
            CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            CloseBtn.Font = Enum.Font.SourceSansBold
            CloseBtn.TextSize = 16
            CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            CloseBtn.Text = "X"
            
            local CloseCorner = Instance.new("UICorner", CloseBtn)
            CloseCorner.CornerRadius = UDim.new(0, 6)
            
            CloseBtn.MouseButton1Click:Connect(function()
                ScreenGui:Destroy()
            end)
            
            -- Botón Minimizar (-)
            local MinimizeBtn = Instance.new("TextButton", TopBar)
            MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
            MinimizeBtn.Position = UDim2.new(1, -70, 0, 5)
            MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            MinimizeBtn.Font = Enum.Font.SourceSansBold
            MinimizeBtn.TextSize = 18
            MinimizeBtn.Text = "-"
            applyRainbowText(MinimizeBtn)
            
            local MinCorner = Instance.new("UICorner", MinimizeBtn)
            MinCorner.CornerRadius = UDim.new(0, 6)
            
            local MinStroke = Instance.new("UIStroke", MinimizeBtn)
            MinStroke.Thickness = 1
            applyRainbowBorder(MinStroke)
            
            local isMinimized = false
            local fullSize = UDim2.new(0, 480, 0, 320)
            local minSize = UDim2.new(0, 260, 0, 40)
            
            MinimizeBtn.MouseButton1Click:Connect(function()
                isMinimized = not isMinimized
                local targetSize = isMinimized and minSize or fullSize
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                
                TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
            end)
            
            -- Contenedor de Páginas
            local PageContainer = Instance.new("Frame", MainFrame)
            PageContainer.Size = UDim2.new(1, 0, 1, -40)
            PageContainer.Position = UDim2.new(0, 0, 0, 40)
            PageContainer.BackgroundTransparency = 1
            
            -- Página MAIN
            local MainPage = Instance.new("Frame", PageContainer)
            MainPage.Size = UDim2.new(1, 0, 1, 0)
            MainPage.BackgroundTransparency = 1
            
            -- Página INFO
            local InfoPage = Instance.new("Frame", PageContainer)
            InfoPage.Size = UDim2.new(1, 0, 1, 0)
            InfoPage.BackgroundTransparency = 1
            InfoPage.Visible = false
            
            -- Botón para alternar MAIN / INFO (Abajo a la izquierda)
            local NavBtn = Instance.new("TextButton", MainFrame)
            NavBtn.Size = UDim2.new(0, 80, 0, 30)
            NavBtn.Position = UDim2.new(0, 10, 1, -35)
            NavBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            NavBtn.Font = Enum.Font.SourceSansBold
            NavBtn.TextSize = 14
            NavBtn.Text = "INFO"
            applyRainbowText(NavBtn)
            
            local NavCorner = Instance.new("UICorner", NavBtn)
            NavCorner.CornerRadius = UDim.new(0, 6)
            
            local NavStroke = Instance.new("UIStroke", NavBtn)
            NavStroke.Thickness = 1.5
            applyRainbowBorder(NavStroke)
            
            NavBtn.MouseButton1Click:Connect(function()
                if MainPage.Visible then
                    MainPage.Visible = false
                    InfoPage.Visible = true
                    NavBtn.Text = "MAIN"
                else
                    MainPage.Visible = true
                    InfoPage.Visible = false
                    NavBtn.Text = "INFO"
                end
            end)
            
            -- ==========================================
            -- FUNCIONES: MAIN PAGE (AIMBOT & HOLOGRAMA)
            -- ==========================================
            
            -- Aimbot UI
            local AimbotBtn = Instance.new("TextButton", MainPage)
            AimbotBtn.Size = UDim2.new(0.42, 0, 0, 38)
            AimbotBtn.Position = UDim2.new(0.05, 0, 0.08, 0)
            AimbotBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            AimbotBtn.Font = Enum.Font.SourceSansBold
            AimbotBtn.TextSize = 15
            AimbotBtn.Text = "AIMBOT: OFF"
            applyRainbowText(AimbotBtn)
            
            local AimCorner = Instance.new("UICorner", AimbotBtn)
            AimCorner.CornerRadius = UDim.new(0, 8)
            
            local AimStroke = Instance.new("UIStroke", AimbotBtn)
            AimStroke.Thickness = 1.5
            applyRainbowBorder(AimStroke)
            
            -- FOV Circle & Logic
            local FOVCircle = Drawing.new("Circle")
            FOVCircle.Color = Color3.fromRGB(255, 0, 0)
            FOVCircle.Thickness = 1.5
            FOVCircle.NumSides = 50
            FOVCircle.Radius = 100
            FOVCircle.Filled = false
            FOVCircle.Visible = false
            
            local aimbotEnabled = false
            local fovVisible = false
            
            -- Toggle FOV Button
            local FOVToggleBtn = Instance.new("TextButton", MainPage)
            FOVToggleBtn.Size = UDim2.new(0.42, 0, 0, 30)
            FOVToggleBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
            FOVToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            FOVToggleBtn.Font = Enum.Font.SourceSans
            FOVToggleBtn.TextSize = 13
            FOVToggleBtn.Text = "TOGGLE FOV: OFF"
            applyRainbowText(FOVToggleBtn)
            
            local FOVTCorner = Instance.new("UICorner", FOVToggleBtn)
            FOVTCorner.CornerRadius = UDim.new(0, 6)
            
            local FOVTStroke = Instance.new("UIStroke", FOVToggleBtn)
            FOVTStroke.Thickness = 1
            applyRainbowBorder(FOVTStroke)
            
            -- Reducir FOV Button
            local FOVDownBtn = Instance.new("TextButton", MainPage)
            FOVDownBtn.Size = UDim2.new(0.42, 0, 0, 30)
            FOVDownBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
            FOVDownBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            FOVDownBtn.Font = Enum.Font.SourceSans
            FOVDownBtn.TextSize = 13
            FOVDownBtn.Text = "BAJAR TAMAÑO FOV ("..FOVCircle.Radius..")"
            applyRainbowText(FOVDownBtn)
            
            local FOVDCorner = Instance.new("UICorner", FOVDownBtn)
            FOVDCorner.CornerRadius = UDim.new(0, 6)
            
            local FOVDStroke = Instance.new("UIStroke", FOVDownBtn)
            FOVDStroke.Thickness = 1
            applyRainbowBorder(FOVDStroke)
            
            AimbotBtn.MouseButton1Click:Connect(function()
                aimbotEnabled = not aimbotEnabled
                AimbotBtn.Text = "AIMBOT: " .. (aimbotEnabled and "ON" or "OFF")
            end)
            
            FOVToggleBtn.MouseButton1Click:Connect(function()
                fovVisible = not fovVisible
                FOVToggleBtn.Text = "TOGGLE FOV: " .. (fovVisible and "ON" or "OFF")
                FOVCircle.Visible = fovVisible
            end)
            
            FOVDownBtn.MouseButton1Click:Connect(function()
                if FOVCircle.Radius > 20 then
                    FOVCircle.Radius = FOVCircle.Radius - 10
                else
                    FOVCircle.Radius = 150
                end
                FOVDownBtn.Text = "BAJAR TAMAÑO FOV ("..FOVCircle.Radius..")"
            end)
            
            -- Lógica Aimbot (Lock a Enemigos dentro del FOV)
            local function GetClosestTarget()
                local closest = nil
                local shortestDistance = FOVCircle.Radius
                local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                        local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                            if dist < shortestDistance then
                                shortestDistance = dist
                                closest = player.Character.HumanoidRootPart
                            end
                        end
                    end
                end
                return closest
            end
            
            RunService.RenderStepped:Connect(function()
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                if aimbotEnabled then
                    local target = GetClosestTarget()
                    if target then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
                    end
                end
            end)
            
            -- Botón HOLOGRAMA (XRAY Rojo)
            local HologramBtn = Instance.new("TextButton", MainPage)
            HologramBtn.Size = UDim2.new(0.42, 0, 0, 38)
            HologramBtn.Position = UDim2.new(0.53, 0, 0.08, 0)
            HologramBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            HologramBtn.Font = Enum.Font.SourceSansBold
            HologramBtn.TextSize = 15
            HologramBtn.Text = "HOLOGRAMA: OFF"
            applyRainbowText(HologramBtn)
            
            local HoloCorner = Instance.new("UICorner", HologramBtn)
            HoloCorner.CornerRadius = UDim.new(0, 8)
            
            local HoloStroke = Instance.new("UIStroke", HologramBtn)
            HoloStroke.Thickness = 1.5
            applyRainbowBorder(HoloStroke)
            
            local hologramEnabled = false
            local highlights = {}
            
            local function applyHologram(plr)
                if plr ~= LocalPlayer and plr.Character then
                    local hl = 
