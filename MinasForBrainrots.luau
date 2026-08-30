-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Variables
local InfiniteJumpEnabled = false
local Flying = false
local Speed = 50

-- Crear Pantalla Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HerculeScript"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- 🎬 ANIMACIÓN DE TEXTO 3D
local Text3D = Instance.new("TextLabel")
Text3D.Name = "TextAnim"
Text3D.Parent = ScreenGui
Text3D.Size = UDim2.new(0, 400, 0, 100)
Text3D.Position = UDim2.new(0.5, -200, -0.2, 0)
Text3D.BackgroundTransparency = 1
Text3D.Text = "MINA POR BRAINROTS!"
Text3D.Font = Enum.Font.GothamBold
Text3D.TextSize = 50
Text3D.TextColor3 = Color3.new(0, 1, 1)
Text3D.TextStrokeTransparency = 0
Text3D.TextStrokeColor3 = Color3.new(0,0,0)
Text3D.Rotation = 15

-- Animación salto + choque
local Tween1 = TweenService:Create(Text3D, TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0.3, 0), Rotation = -10})
local Tween2 = TweenService:Create(Text3D, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -200, 0.4, 0), Rotation = 0})
local Tween3 = TweenService:Create(Text3D, TweenInfo.new(0.3), {Transparency = 1, TextTransparency = 1})

Tween1:Play()
Tween1.Completed:Connect(function()
    Tween2:Play()
    Tween2.Completed:Connect(function()
        Text3D:Destroy()
        -- 📊 BARRA DE CARGA
        local BarBG = Instance.new("Frame")
        BarBG.Size = UDim2.new(0, 300, 0, 20)
        BarBG.Position = UDim2.new(0.5, -150, 0.5, 0)
        BarBG.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
        BarBG.BorderSizePixel = 0
        BarBG.Parent = ScreenGui
        BarBG.Visible = true

        local BarFill = Instance.new("Frame")
        BarFill.Size = UDim2.new(0, 0, 1, 0)
        BarFill.BackgroundColor3 = Color3.new(0, 0.8, 1)
        BarFill.BorderSizePixel = 0
        BarFill.Parent = BarBG

        -- Animación carga 0→100%
        for i=1,100 do
            BarFill.Size = UDim2.new(i/100, 0, 1, 0)
            task.wait(0.02)
        end

        BarBG:Destroy()

        -- 🔘 BOTÓN FLOTANTE 🔨LN -- REDONDO, ARRIBA Y MOVIBLE
        local FloatingBtn = Instance.new("TextButton")
        FloatingBtn.Name = "FloatingBtn"
        FloatingBtn.Size = UDim2.new(0, 55, 0, 55)
        FloatingBtn.Position = UDim2.new(0.5, -27, 0.05, 0) -- ARRIBA, CENTRADO
        FloatingBtn.BackgroundColor3 = Color3.new(0,0,0)
        FloatingBtn.Text = "🔨LN"
        FloatingBtn.Font = Enum.Font.GothamBold
        FloatingBtn.TextSize = 16
        FloatingBtn.TextColor3 = Color3.new(1,1,1)
        FloatingBtn.BorderSizePixel = 0
        FloatingBtn.Parent = ScreenGui
        -- REDONDO
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(1,0) -- 100% redondo
        BtnCorner.Parent = FloatingBtn

        -- ✅ Hacer que el botón 🔨LN se pueda mover con el dedo
        local DragBtnStart, BtnStartPos
        FloatingBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                DragBtnStart = input.Position
                BtnStartPos = FloatingBtn.Position
            end
        end)
        FloatingBtn.InputChanged:Connect(function(input)
            if DragBtnStart and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - DragBtnStart
                FloatingBtn.Position = UDim2.new(
                    BtnStartPos.X.Scale,
                    BtnStartPos.X.Offset + delta.X,
                    BtnStartPos.Y.Scale,
                    BtnStartPos.Y.Offset + delta.Y
                )
            end
        end)
        FloatingBtn.InputEnded:Connect(function() DragBtnStart = nil end)

        -- 📦 GUI PRINCIPAL -- AHORA MUY CHIQUITO
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 220, 0, 260) -- ✅ TAMAÑO MÍNIMO / CHIQUITO
        MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130) -- ✅ EMPIEZA EN EL CENTRO
        MainFrame.BackgroundColor3 = Color3.new(0,0,0)
        MainFrame.BorderSizePixel = 0
        MainFrame.Visible = false
        MainFrame.ClipsDescendants = true
        MainFrame.Parent = ScreenGui

        -- Bordes redondos
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.12,0)
        UICorner.Parent = MainFrame

        -- 📌 TITULO + CONTROLES
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Size = UDim2.new(1, -40, 0, 28)
        Title.Position = UDim2.new(0, 10, 0, 5)
        Title.BackgroundTransparency = 1
        Title.Text = "By: HERCULES YT"
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 14
        Title.TextColor3 = Color3.new(1,1,1)
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = MainFrame

        -- ✅ MOVER GUI AL MANTENER PRESIONADO EL NOMBRE
        local DragStart, StartPos
        Title.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                DragStart = input.Position
                StartPos = MainFrame.Position
            end
        end)
        Title.InputChanged:Connect(function(input)
            if DragStart and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - DragStart
                MainFrame.Position = UDim2.new(
                    StartPos.X.Scale,
                    StartPos.X.Offset + delta.X,
                    StartPos.Y.Scale,
                    StartPos.Y.Offset + delta.Y
                )
            end
        end)
        Title.InputEnded:Connect(function() DragStart = nil end)

        -- Botón Ocultar (-)
        local HideBtn = Instance.new("TextButton")
        HideBtn.Name = "HideBtn"
        HideBtn.Size = UDim2.new(0, 22, 0, 22)
        HideBtn.Position = UDim2.new(1, -52, 0, 3)
        HideBtn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
        HideBtn.Text = "-"
        HideBtn.Font = Enum.Font.GothamBold
        HideBtn.TextSize = 16
        HideBtn.TextColor3 = Color3.new(1,1,1)
        HideBtn.BorderSizePixel = 0
        HideBtn.Parent = MainFrame
        Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0.5,0)

        -- Botón Cerrar (×)
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Name = "CloseBtn"
        CloseBtn.Size = UDim2.new(0, 22, 0, 22)
        CloseBtn.Position = UDim2.new(1, -28, 0, 3)
        CloseBtn.BackgroundColor3 = Color3.new(0.8,0.1,0.1)
        CloseBtn.Text = "×"
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.TextSize = 16
        CloseBtn.TextColor3 = Color3.new(1,1,1)
        CloseBtn.BorderSizePixel = 0
        CloseBtn.Parent = MainFrame
        Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0.5,0)

        -- Botón CONFIG
        local ConfigBtn = Instance.new("TextButton")
        ConfigBtn.Name = "ConfigBtn"
        ConfigBtn.Size = UDim2.new(0.8, 0, 0, 22)
        ConfigBtn.Position = UDim2.new(0.1, 0, 0, 33)
        ConfigBtn.BackgroundColor3 = Color3.new(0,0.6,1)
        ConfigBtn.Text = "⚙️ CONFI"
        ConfigBtn.Font = Enum.Font.GothamBold
        ConfigBtn.TextSize = 12
        ConfigBtn.TextColor3 = Color3.new(1,1,1)
        ConfigBtn.BorderSizePixel = 0
        ConfigBtn.Parent = MainFrame
        Instance.new("UICorner", ConfigBtn).CornerRadius = UDim.new(0.3,0)

        -- 📄 PÁGINAS
        local Pages = {
            Main = Instance.new("Frame", MainFrame),
            Config = Instance.new("Frame", MainFrame)
        }
        for _,p in pairs(Pages) do
            p.Size = UDim2.new(1, -10, 1, -60)
            p.Position = UDim2.new(0, 5, 0, 55)
            p.BackgroundTransparency = 1
            p.Visible = false
        end
        Pages.Main.Visible = true

        -- 🧩 OPCIÓN: INFINITE JUMP -- ✅ CAMBIO IMPORTANTE
        -- AHORA: VUELA SOLO MIENTRAS MANTENES SALTAR → AL SOLTAR → DEJA DE VOLAR Y BAJA
        local InfiniteJumpBtn = Instance.new("TextButton")
        InfiniteJumpBtn.Size = UDim2.new(0.9, 0, 0, 32)
        InfiniteJumpBtn.Position = UDim2.new(0.05, 0, 0, 8)
        InfiniteJumpBtn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
        InfiniteJumpBtn.Text = "⚡ INFINITE JUMP"
        InfiniteJumpBtn.Font = Enum.Font.GothamBold
        InfiniteJumpBtn.TextSize = 13
        InfiniteJumpBtn.TextColor3 = Color3.new(1,1,1)
        InfiniteJumpBtn.BorderSizePixel = 0
        InfiniteJumpBtn.Parent = Pages.Main
        Instance.new("UICorner", InfiniteJumpBtn).CornerRadius = UDim.new(0.4,0)

        -- 📋 PÁGINA CONFIG
        -- Perfil
        local Avatar = Instance.new("ImageLabel")
        Avatar.Size = UDim2.new(0, 50, 0, 50)
        Avatar.Position = UDim2.new(0.05,0,0,5)
        Avatar.BackgroundTransparency = 1
        Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..Player.UserId.."&width=150&height=150&format=png"
        Avatar.Parent = Pages.Config

        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(0.6,0,0,18)
        NameLabel.Position = UDim2.new(0.35,0,0,8)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = Player.Name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 12
        NameLabel.TextColor3 = Color3.new(1,1,1)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Pages.Config

        local FollowersLabel = Instance.new("TextLabel")
        FollowersLabel.Size = UDim2.new(0.6,0,0,18)
        FollowersLabel.Position = UDim2.new(0.35,0,0,25)
        FollowersLabel.BackgroundTransparency = 1
        FollowersLabel.Text = "👥 Seguidores: --"
        FollowersLabel.Font = Enum.Font.Gotham
        FollowersLabel.TextSize = 11
        FollowersLabel.TextColor3 = Color3.new(0.8,0.8,0.8)
        FollowersLabel.TextXAlignment = Enum.TextXAlignment.Left
        FollowersLabel.Parent = Pages.Config

        -- Texto créditos
        local Credits = Instance.new("TextLabel")
        Credits.Size = UDim2.new(1,-10,0,70)
        Credits.Position = UDim2.new(0,5,0,55)
        Credits.BackgroundTransparency = 1
        Credits.Text = "📖 LEELO:\nNO DIGAS QUE EL SCRIPT ES TUYO\nES DE LARDYLAN\nSI ARAS TUTO MANDA CREDITOS DE\n@mininelsonbs en TikTok\nGRACIAS POR ESCOGERME"
        Credits.Font = Enum.Font.Gotham
        Credits.TextSize = 10
        Credits.TextColor3 = Color3.new(1,1,1)
        Credits.TextWrapped = true
        Credits.Parent = Pages.Config

        -- FPS
        local FpsLabel = Instance.new("TextLabel")
        FpsLabel.Size = UDim2.new(1,-10,0,18)
        FpsLabel.Position = UDim2.new(0,5,1,-20)
        FpsLabel.BackgroundTransparency = 1
        FpsLabel.Text = "⚡ FPS: 0"
        FpsLabel.Font = Enum.Font.GothamBold
        FpsLabel.TextSize = 11
        FpsLabel.TextColor3 = Color3.new(0,1,0)
        FpsLabel.Parent = Pages.Config

        -- 🎯 FUNCIONES
        -- Abrir/Cerrar GUI → ✅ AL TOCARLO APARECE EN EL CENTRO
        FloatingBtn.MouseButton1Click:Connect(function()
            MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset/2, 0.5, -MainFrame.Size.Y.Offset/2)
            MainFrame.Visible = not MainFrame.Visible
        end)

        -- Ocultar/mostrar lento
        local Hidden = false
        HideBtn.MouseButton1Click:Connect(function()
            local Goal = Hidden and {Size = UDim2.new(0,220,0,260), Position = UDim2.new(0.5, -110, 0.5, -130)} or {Size = UDim2.new(0,220,0,28), Position = UDim2.new(0.5, -110, 0.5, -10)}
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), Goal):Play()
            Hidden = not Hidden
        end)

        -- Cerrar GUI
        CloseBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = false
        end)

        -- Cambiar página
        ConfigBtn.MouseButton1Click:Connect(function()
            Pages.Main.Visible = not Pages.Main.Visible
            Pages.Config.Visible = not Pages.Config.Visible
            ConfigBtn.Text = Pages.Config.Visible and "🔙 VOLVER" or "⚙️ CONFI"
        end)

        -- ✅ INFINITE JUMP CORREGIDO: SOLO VUELA MIENTRAS MANTENES SALTAR
        -- Al SOLTAR el botón de saltar → DEJA DE VOLAR Y BAJA
        InfiniteJumpBtn.MouseButton1Click:Connect(function()
            InfiniteJumpEnabled = not InfiniteJumpEnabled
            InfiniteJumpBtn.BackgroundColor3 = InfiniteJumpEnabled and Color3.new(0,0.8,0.2) or Color3.new(0.2,0.2,0.2)
        end)

        -- Detecta cuando EMPIEZAS a saltar → ACTIVA VUELO
        UserInputService.JumpRequest:Connect(function()
            if InfiniteJumpEnabled and Humanoid and Humanoid.Health > 0 then
                Flying = true -- ✅ VUELA SOLO AHORA
            end
        end)

        -- ✅ DETECTA CUANDO SUELTAS EL BOTÓN → DEJA DE VOLAR INMEDIATAMENTE
        UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space or input.UserInputType == Enum.UserInputType.Gamepad1ButtonA or input.UserInputType == Enum.UserInputType.Touch then
                Flying = false -- ✅ AL SOLTAR → DEJA DE VOLAR → CAE
            end
        end)

        -- Actualizar vuelo + FPS
        local LastTime = os.clock()
        RunService.RenderStepped:Connect(function()
            -- ✅ VUELO: SOLO SI ESTÁS MANTENIENDO SALTAR
            if Flying and InfiniteJumpEnabled and HumanoidRootPart then
                HumanoidRootPart.Velocity = Vector3.new(
                    HumanoidRootPart.Velocity.X,
                    Speed, -- ✅ SOLO SUBE SI LO MANTIENES
                    HumanoidRootPart.Velocity.Z
                )
            end

            -- FPS
            local Now = os.clock()
            local FPS = math.floor(1/(Now - LastTime))
            LastTime = Now
            if Pages.Config.Visible then FpsLabel.Text = "⚡ FPS: "..FPS end
        end)

    end)
end)
