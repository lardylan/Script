-- NEXXUZHUB / LARDYLAN HUB V4 (Delta Executor)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Asegurar contenedor UI
local ParentGui = game:GetService("CoreGui")
if not pcall(function() return ParentGui.Name end) then
    ParentGui = LocalPlayer:WaitForChild("PlayerGui")
end

if ParentGui:FindFirstChild("LardylanHub") then
    ParentGui.LardylanHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LardylanHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = ParentGui

-- Función Rainbow
local function Rainbow(obj, prop)
    task.spawn(function()
        local h = 0
        while obj and obj.Parent do
            h = (h + 1) % 360
            obj[prop] = Color3.fromHSV(h/360, 0.8, 1)
            task.wait(0.03)
        end
    end)
end

-- Variables Globales
local CorrectKey = "FREE-97691982B44B2FA"
local KeyDuration = 86400
local InfoStartTime = nil
local AimOn, HoloOn, SpeedOn, MusicOn = false, false, false, false
local FOVVal = 100

-- Audio
local BackgroundSound = Instance.new("Sound", ScreenGui)
BackgroundSound.SoundId = "rbxassetid://105510383063155"
BackgroundSound.Volume = 0.5
BackgroundSound.Looped = true

-- Declaraciones
local ShowKeySys, ShowMain

-- 1. PANTALLA DE CARGA
local StatusFrame = Instance.new("Frame", ScreenGui)
StatusFrame.Size = UDim2.new(0, 200, 0, 80)
StatusFrame.Position = UDim2.new(0.5, 160, 0.5, -40)
StatusFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", StatusFrame).CornerRadius = UDim.new(0, 10)
local StatusStroke = Instance.new("UIStroke", StatusFrame)
StatusStroke.Thickness = 2
Rainbow(StatusStroke, "Color")

local StatusTxt = Instance.new("TextLabel", StatusFrame)
StatusTxt.Size = UDim2.new(1, -10, 1, -10)
StatusTxt.Position = UDim2.new(0, 5, 0, 5)
StatusTxt.BackgroundTransparency = 1
StatusTxt.TextColor3 = Color3.fromRGB(255,255,255)
StatusTxt.TextScaled = true
StatusTxt.Font = Enum.Font.SourceSansBold
StatusTxt.Text = "ESTADO:\nIniciando..."

local LoadFrame = Instance.new("Frame", ScreenGui)
LoadFrame.Size = UDim2.new(0, 280, 0, 140)
LoadFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
LoadFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 12)
local LoadStroke = Instance.new("UIStroke", LoadFrame)
LoadStroke.Thickness = 3
Rainbow(LoadStroke, "Color")

local LoadTitle = Instance.new("TextLabel", LoadFrame)
LoadTitle.Size = UDim2.new(1, 0, 0.4, 0)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "LARDYLAN CARGANDO"
LoadTitle.TextScaled = true
LoadTitle.Font = Enum.Font.SourceSansBold
Rainbow(LoadTitle, "TextColor3")

local PercentTxt = Instance.new("TextLabel", LoadFrame)
PercentTxt.Size = UDim2.new(1, 0, 0.5, 0)
PercentTxt.Position = UDim2.new(0, 0, 0.4, 0)
PercentTxt.BackgroundTransparency = 1
PercentTxt.Text = "1%"
PercentTxt.TextColor3 = Color3.fromRGB(255,255,255)
PercentTxt.TextSize = 32
PercentTxt.Font = Enum.Font.SourceSansBold

task.spawn(function()
    for i = 1, 100 do
        PercentTxt.Text = i .. "%"
        StatusTxt.Text = "ESTADO:\nCargando (" .. i .. "%)"
        task.wait(0.01)
    end
    LoadFrame:Destroy()
    StatusTxt.Text = "ESTADO:\nEsperando Key..."
    ShowKeySys()
end)

-- 2. KEY SYSTEM
ShowKeySys = function()
    local KeyFrame = Instance.new("Frame", ScreenGui)
    KeyFrame.Size = UDim2.new(0, 300, 0, 180)
    KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 14)
    local KS = Instance.new("UIStroke", KeyFrame)
    KS.Thickness = 2.5
    Rainbow(KS, "Color")

    local KTitle = Instance.new("TextLabel", KeyFrame)
    KTitle.Size = UDim2.new(1, 0, 0.3, 0)
    KTitle.BackgroundTransparency = 1
    KTitle.Text = "NEXXUZHUB LARDYLAN HUB"
    KTitle.TextScaled = true
    KTitle.Font = Enum.Font.SourceSansBold
    Rainbow(KTitle, "TextColor3")

    local KInput = Instance.new("TextBox", KeyFrame)
    KInput.Size = UDim2.new(0.8, 0, 0.22, 0)
    KInput.Position = UDim2.new(0.1, 0, 0.35, 0)
    KInput.BackgroundColor3 = Color3.fromRGB(30,30,30)
    KInput.PlaceholderText = "Ingresa Key..."
    KInput.Text = ""
    KInput.TextColor3 = Color3.fromRGB(255,255,255)
    KInput.Font = Enum.Font.SourceSans
    KInput.TextSize = 16
    Instance.new("UICorner", KInput)

    local KBtn = Instance.new("TextButton", KeyFrame)
    KBtn.Size = UDim2.new(0.6, 0, 0.22, 0)
    KBtn.Position = UDim2.new(0.2, 0, 0.65, 0)
    KBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    KBtn.Text = "VERIFICAR"
    KBtn.Font = Enum.Font.SourceSansBold
    KBtn.TextSize = 16
    Rainbow(KBtn, "TextColor3")
    Instance.new("UICorner", KBtn)
    local BS = Instance.new("UIStroke", KBtn)
    Rainbow(BS, "Color")

    KBtn.MouseButton1Click:Connect(function()
        if KInput.Text == CorrectKey then
            StatusTxt.Text = "ESTADO:\nKey Correcta!"
            task.wait(0.5)
            KeyFrame:Destroy()
            StatusFrame:Destroy()
            ShowMain()
        else
            StatusTxt.Text = "ESTADO:\nKey incorrecta!"
        end
    end)
end

-- CREADOR DE SWITCHES VIRTUALES CON CIRCULO ⚪
local function CreateSwitch(parent, pos, text, onClick)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(0, 180, 0, 32)
    Container.Position = pos
    Container.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Container)
    Label.Size = UDim2.new(0, 110, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Track = Instance.new("TextButton", Container)
    Track.Size = UDim2.new(0, 50, 0, 24)
    Track.Position = UDim2.new(1, -50, 0.5, -12)
    Track.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Track.Text = ""
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("TextLabel", Track)
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 2, 0.5, -10)
    Knob.BackgroundTransparency = 1
    Knob.Text = "⚪"
    Knob.TextSize = 16
    Knob.TextColor3 = Color3.fromRGB(255,255,255)

    local state = false
    Track.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 200, 80)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -10)}):Play()
        else
            TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
        end
        onClick(state)
    end)
    return Container
end

-- 3. INTERFAZ PRINCIPAL
ShowMain = function()
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 440, 0, 290)
    Main.Position = UDim2.new(0.5, -220, 0.5, -145)
    Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    local MS = Instance.new("UIStroke", Main)
    MS.Thickness = 2
    Rainbow(MS, "Color")

    -- Top Bar
    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1, 0, 0, 35)
    Top.BackgroundColor3 = Color3.fromRGB(25,25,25)

    local Title = Instance.new("TextLabel", Top)
    Title.Size = UDim2.new(0.6, 0, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "NEXXUZHUB LARDYLAN HUB V4"
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Rainbow(Title, "TextColor3")

    local Close = Instance.new("TextButton", Top)
    Close.Size = UDim2.new(0, 28, 0, 24)
    Close.Position = UDim2.new(1, -32, 0, 5)
    Close.BackgroundColor3 = Color3.fromRGB(200,40,40)
    Close.Text = "X"
    Close.TextColor3 = Color3.fromRGB(255,255,255)
    Close.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", Close)
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Min = Instance.new("TextButton", Top)
    Min.Size = UDim2.new(0, 28, 0, 24)
    Min.Position = UDim2.new(1, -64, 0, 5)
    Min.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Min.Text = "-"
    Min.Font = Enum.Font.SourceSansBold
    Rainbow(Min, "TextColor3")
    Instance.new("UICorner", Min)

    local isMin = false
    Min.MouseButton1Click:Connect(function()
        isMin = not isMin
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = isMin and UDim2.new(0, 220, 0, 35) or UDim2.new(0, 440, 0, 290)}):Play()
    end)

    -- Paneles
    local CMain = Instance.new("Frame", Main)
    CMain.Size = UDim2.new(1, 0, 1, -35)
    CMain.Position = UDim2.new(0, 0, 0, 35)
    CMain.BackgroundTransparency = 1

    local CInfo = Instance.new("Frame", Main)
    CInfo.Size = UDim2.new(1, 0, 1, -35)
    CInfo.Position = UDim2.new(0, 0, 0, 35)
    CInfo.BackgroundTransparency = 1
    CInfo.Visible = false

    local SwitchTab = Instance.new("TextButton", Main)
    SwitchTab.Size = UDim2.new(0, 60, 0, 24)
    SwitchTab.Position = UDim2.new(0, 10, 1, -30)
    SwitchTab.BackgroundColor3 = Color3.fromRGB(30,30,30)
    SwitchTab.Text = "INFO"
    SwitchTab.Font = Enum.Font.SourceSansBold
    Rainbow(SwitchTab, "TextColor3")
    Instance.new("UICorner", SwitchTab)

    -- Círculo FOV
    local FOVFrame = Instance.new("Frame", ScreenGui)
    FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    FOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    FOVFrame.Size = UDim2.new(0, FOVVal*2, 0, FOVVal*2)
    FOVFrame.BackgroundTransparency = 1
    FOVFrame.Visible = false
    Instance.new("UICorner", FOVFrame).CornerRadius = UDim.new(1, 0)
    local FS = Instance.new("UIStroke", FOVFrame)
    FS.Color = Color3.fromRGB(255, 0, 0)
    FS.Thickness = 2

    -- 1. SWITCH AIMBOT
    CreateSwitch(CMain, UDim2.new(0.05, 0, 0.08, 0), "AIMBOT", function(on)
        AimOn = on
        FOVFrame.Visible = on
    end)

    local FOVDown = Instance.new("TextButton", CMain)
    FOVDown.Size = UDim2.new(0, 45, 0, 22)
    FOVDown.Position = UDim2.new(0.05, 0, 0.22, 0)
    FOVDown.BackgroundColor3 = Color3.fromRGB(35,35,35)
    FOVDown.Text = "FOV -"
    FOVDown.TextColor3 = Color3.fromRGB(255,255,255)
    FOVDown.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", FOVDown)

    local FOVUp = Instance.new("TextButton", CMain)
    FOVUp.Size = UDim2.new(0, 45, 0, 22)
    FOVUp.Position = UDim2.new(0.05, 50, 0.22, 0)
    FOVUp.BackgroundColor3 = Color3.fromRGB(35,35,35)
    FOVUp.Text = "FOV +"
    FOVUp.TextColor3 = Color3.fromRGB(255,255,255)
    FOVUp.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", FOVUp)

    FOVDown.MouseButton1Click:Connect(function()
        FOVVal = math.max(20, FOVVal - 10)
        FOVFrame.Size = UDim2.new(0, FOVVal*2, 0, FOVVal*2)
    end)
    FOVUp.MouseButton1Click:Connect(function()
        FOVVal = math.min(300, FOVVal + 10)
        FOVFrame.Size = UDim2.new(0, FOVVal*2, 0, FOVVal*2)
    end)

    -- 2. SWITCH HOLOGRAMA (Limpieza Corregida)
    CreateSwitch(CMain, UDim2.new(0.52, 0, 0.08, 0), "HOLOGRAMA", function(on)
        HoloOn = on
        if not HoloOn then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _, child in pairs(p.Character:GetChildren()) do
                        if child:IsA("Highlight") and child.Name == "HoloX" then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end)

    -- 3. SWITCH BOOST SPEED
    CreateSwitch(CMain, UDim2.new(0.05, 0, 0.38, 0), "BOOST SPEED", function(on)
        SpeedOn = on
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = SpeedOn and 50 or 16
        end
    end)

    -- 4. SWITCH MÚSICA
    CreateSwitch(CMain, UDim2.new(0.52, 0, 0.38, 0), "MÚSICA", function(on)
        MusicOn = on
        if MusicOn then
            BackgroundSound:Play()
        else
            BackgroundSound:Stop()
        end
    end)

    -- Loops del Juego
    RunService.RenderStepped:Connect(function()
        -- Loop Aimbot
        if AimOn then
            local target, dist = nil, FOVVal
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    if vis then
                        local mDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if mDist < dist then
                            dist = mDist
                            target = p.Character.Head
                        end
                    end
                end
            end
            if target then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            end
        end

        -- Loop Holograma
        if HoloOn then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    if not p.Character:FindFirstChild("HoloX") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "HoloX"
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = p.Character
                    end
                end
            end
        end

        -- Loop WalkSpeed
        if SpeedOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
        end
    end)

    -- Pestaña INFO
    local Scroll = Instance.new("ScrollingFrame", CInfo)
    Scroll.Size = UDim2.new(0.95, 0, 0.8, 0)
    Scroll.Position = UDim2.new(0.025, 0, 0.02, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 420)

    -- Expire Key Label
    local ExpLabel = Instance.new("TextLabel", Scroll)
    ExpLabel.Size = UDim2.new(1, -10, 0, 25)
    ExpLabel.Position = UDim2.new(0, 0, 0, 0)
    ExpLabel.BackgroundColor3 = Color3.fromRGB(25,25,25)
    ExpLabel.Text = "Expire Key: 24:00:00"
    ExpLabel.TextColor3 = Color3.fromRGB(255,255,255)
    ExpLabel.Font = Enum.Font.SourceSansBold
    ExpLabel.TextSize = 14
    Instance.new("UICorner", ExpLabel)

    SwitchTab.MouseButton1Click:Connect(function()
        CMain.Visible = not CMain.Visible
        CInfo.Visible = not CMain.Visible
        SwitchTab.Text = CMain.Visible and "INFO" or "MAIN"

        -- Iniciar contador de 24 hrs al entrar a INFO por primera vez
        if CInfo.Visible and not InfoStartTime then
            InfoStartTime = tick()
            task.spawn(function()
                while CInfo and CInfo.Parent do
                    local rem = KeyDuration - (tick() - InfoStartTime)
                    if rem <= 0 then
                        ExpLabel.Text = "KEY EXPIRADO"
                        ExpLabel.TextColor3 = Color3.fromRGB(255,50,50)
                        break
                    else
                        ExpLabel.Text = string.format("Expire Key: %02d:%02d:%02d", math.floor(rem/3600), math.floor((rem%3600)/60), math.floor(rem%60))
                    end
                    task.wait(1)
                end
            end)
        end
    end)

    -- Lista de Desarrolladores
    local P1 = Instance.new("Frame", Scroll)
    P1.Size = UDim2.new(1, -10, 0, 50)
    P1.Position = UDim2.new(0, 0, 0, 32)
    P1.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner", P1)
    
    local N1 = Instance.new("TextLabel", P1)
    N1.Size = UDim2.new(1, -10, 0.5, 0)
    N1.Position = UDim2.new(0, 10, 0, 2)
    N1.BackgroundTransparency = 1
    N1.Text = "NexxuzHub (Fide2283)"
    N1.TextColor3 = Color3.fromRGB(255,255,255)
    N1.Font = Enum.Font.SourceSansBold
    N1.TextXAlignment = Enum.TextXAlignment.Left

    local R1 = Instance.new("TextLabel", P1)
    R1.Size = UDim2.new(1, -10, 0.4, 0)
    R1.Position = UDim2.new(0, 10, 0, 25)
    R1.BackgroundTransparency = 1
    R1.Text = "Builder GUI"
    R1.TextColor3 = Color3.fromRGB(180,180,180)
    R1.Font = Enum.Font.SourceSans
    R1.TextXAlignment = Enum.TextXAlignment.Left

    local P2 = Instance.new("Frame", Scroll)
    P2.Size = UDim2.new(1, -10, 0, 50)
    P2.Position = UDim2.new(0, 0, 0, 88)
    P2.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Instance.new("UICorner", P2)

    local N2 = Instance.new("TextLabel", P2)
    N2.Size = UDim2.new(1, -10, 0.5, 0)
    N2.Position = UDim2.new(0, 10, 0, 2)
    N2.BackgroundTransparency = 1
    N2.Text = "Lardylan HUB (XxREGALITOxX34)"
    N2.TextColor3 = Color3.fromRGB(255,255,255)
    N2.Font = Enum.Font.SourceSansBold
    N2.TextXAlignment = Enum.TextXAlignment.Left

    local R2 = Instance.new("TextLabel", P2)
    R2.Size = UDim2.new(1, -10, 0.4, 0)
    R2.Position = UDim2.new(0, 10, 0, 25)
    R2.BackgroundTransparency = 1
    R2.Text = "Creator Admin"
    R2.TextColor3 = Color3.fromRGB(180,180,180)
    R2.Font = Enum.Font.SourceSans
    R2.TextXAlignment = Enum.TextXAlignment.Left

    -- Cartas
    local Card1 = Instance.new("Frame", Scroll)
    Card1.Size = UDim2.new(1, -10, 0, 120)
    Card1.Position = UDim2.new(0, 0, 0, 145)
    Card1.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", Card1)

    local TCard1 = Instance.new("TextLabel", Card1)
    TCard1.Size = UDim2.new(1, -10, 0, 80)
    TCard1.Position = UDim2.new(0, 5, 0, 5)
    TCard1.BackgroundTransparency = 1
    TCard1.Text = "NexxuzHub: 皆さん、こんにちは！私はLardylanのヘルパーをしている日本人クリエイターです。下の「翻訳」ボタンをクリックすると、スペイン語で読むことができます。私たちのプロジェクトを気に入っていただけたら嬉しいです。みんな大好き！❤️"
    TCard1.TextColor3 = Color3.fromRGB(230,230,230)
    TCard1.Font = Enum.Font.SourceSans
    TCard1.TextSize = 11
    TCard1.TextWrapped = true

    local Trad = Instance.new("TextButton", Card1)
    Trad.Size = UDim2.new(0, 120, 0, 22)
    Trad.Position = UDim2.new(0, 5, 0, 90)
    Trad.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Trad.Text = "Traducir al español"
    Trad.Font = Enum.Font.SourceSansBold
    Trad.TextSize = 11
    Rainbow(Trad, "TextColor3")
    Instance.new("UICorner", Trad)

    local isTrans = false
    Trad.MouseButton1Click:Connect(function()
        isTrans = not isTrans
        TCard1.Text = isTrans and "NexxuzHub: ¡Hola a todos! Soy un creador japonés que ayuda a Lardylan. Al hacer clic en el botón 'Traducir' de abajo, puedes leerlo en español. Esperamos que les guste nuestro proyecto. ¡Los quiero a todos! ❤️" or "NexxuzHub: 皆さん、こんにちは！私はLardylanのヘルパーをしている日本人クリエイターです。下の「翻訳」ボタンをクリックすると、スペイン語で読むことができます。私たちのプロジェクトを気に入っていただけたら嬉しいです。みんな大好き！❤️"
        Trad.Text = isTrans and "Ver en Japonés" or "Traducir al español"
    end)

    local Card2 = Instance.new("Frame", Scroll)
    Card2.Size = UDim2.new(1, -10, 0, 100)
    Card2.Position = UDim2.new(0, 0, 0, 272)
    Card2.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", Card2)

    local TCard2 = Instance.new("TextLabel", Card2)
    TCard2.Size = UDim2.new(1, -10, 1, -10)
    TCard2.Position = UDim2.new(0, 5, 0, 5)
    TCard2.BackgroundTransparency = 1
    TCard2.Text = "LARDYLAN: HOLA CH
