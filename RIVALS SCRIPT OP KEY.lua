local MarketplaceService = game:GetService("MarketplaceService")
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)

local RIVALS_PLACE_ID = 17625359962 
if game.PlaceId ~= RIVALS_PLACE_ID 
then 
    game:GetService("Players").LocalPlayer:Kick("ESTE SCRIPT ES PARA RIVALS")
    return
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "NexxuzHub|LARDYLAN V1",
    LoadingTitle = "NexxuzHub",
    LoadingSubtitle = "by LARDYLAN",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "NexxuzHubRivals"
    },
    KeySystem = true,
    KeySettings = {
        Title = "NexxuzHub | Key System",
        Subtitle = "Introduce la Key para continuar",
        Note = "Key: FREEKEY24HOURS_5678_LARDYLAN_SINGLN",
        FileName = "NexxuzHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"FREEKEY24HOURS_5678_LARDYLAN_SINGLN"}
    }
)

local CombatTab = Window:CreateTab("COMBAT", 4483362458)
local VisualTab = Window:CreateTab("VISUAL", 4483362458)

local AimbotFovEnabled = false
local FovSizeValue = 100
local FovColorValue = Color3.fromRGB(255, 255, 255)
local RainbowFovEnabled = false
local SelectedHitbox = "HEAD"
local AimbotNoFovEnabled = false
local AutoShotEnabled = false
local AutoShotAimbotEnabled = false
local ChanceDisparo = 100

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Transparency = 1
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false

game:GetService("RunService").RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    FOVCircle.Position = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    FOVCircle.Radius = FovSizeValue
    
    if RainbowFovEnabled then
        local hue = tick() % 5 / 5
        FOVCircle.Color = Color3.fromHSV(hue, 1, 1)
    else
        FOVCircle.Color = FovColorValue
    end

    FOVCircle.Visible = AimbotFovEnabled

    local localPlayer = game:GetService("Players").LocalPlayer
    local target = nil
    local shortestDistance = math.huge

    if AimbotFovEnabled or AimbotNoFovEnabled or AutoShotAimbotEnabled then
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local character = player.Character
                local hitboxPart = character:FindFirstChild(SelectedHitbox) or character:FindFirstChild("HumanoidRootPart")
                
                if hitboxPart then
                    local screenPoint, onScreen = cam:WorldToViewportPoint(hitboxPart.Position)
                    if onScreen then
                        local mousePos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude

                        if AimbotFovEnabled and distance <= FovSizeValue then
                            if distance < shortestDistance then
                                shortestDistance = distance
                                target = hitboxPart
                            end
                        elseif AimbotNoFovEnabled or AutoShotAimbotEnabled then
                            if distance < shortestDistance then
                                shortestDistance = distance
                                target = hitboxPart
                            end
                        end
                    end
                end
            end
        end

        if target then
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.Position)
            
            if AutoShotAimbotEnabled or AutoShotEnabled then
                if math.random(1, 100) <= ChanceDisparo then
                    task.spawn(function()
                        mouse1click()
                    end)
                end
            end
        end
    end
end)

CombatTab:CreateToggle({
    Name = "AIMBOT CON FOV",
    CurrentValue = false,
    Flag = "AimbotFovToggle",
    Callback = function(Value)
        AimbotFovEnabled = Value
        if not Value then
            RainbowFovEnabled = false
        end
    end,
})

CombatTab:CreateDropdown({
    Name = "CHECK HUMANOID",
    Options = {"HEAD", "BELLY", "RIGHT ARM", "LEFT ARM", "RIGHT LEG", "LEFT LEG"},
    CurrentOption = "HEAD",
    Flag = "HumanoidDropdown",
    Callback = function(Option)
        SelectedHitbox = Option
    end,
})

CombatTab:CreateSlider({
    Name = "Tamaño del FOV",
    Range = 10,
    Increment = 5,
    CurrentValue = 100,
    Suffix = "px",
    Flag = "FovSizeSlider",
    Callback = function(Value)
        FovSizeValue = Value
    end,
})

CombatTab:CreateColorPicker({
    Name = "Color del FOV",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "FovColorPicker",
    Callback = function(Value)
        FovColorValue = Value
    end,
})

CombatTab:CreateToggle({
    Name = "RAINBOW FOV",
    CurrentValue = false,
    Flag = "RainbowFovToggle",
    Callback = function(Value)
        RainbowFovEnabled = Value
    end,
})

CombatTab:CreateToggle({
    Name = "AIMBOT SIN FOV",
    CurrentValue = false,
    Flag = "AimbotNoFovToggle",
    Callback = function(Value)
        AimbotNoFovEnabled = Value
    end,
})

CombatTab:CreateToggle({
    Name = "AUTO SHOT",
    CurrentValue = false,
    Flag = "AutoShotToggle",
    Callback = function(Value)
        AutoShotEnabled = Value
    end,
})

CombatTab:CreateSlider({
    Name = "CHANCE DE DISPARO (%)",
    Range = 10,
    Increment = 5,
    CurrentValue = 100,
    Suffix = "%",
    Flag = "ChanceSlider",
    Callback = function(Value)
        ChanceDisparo = Value
    end,
})

CombatTab:CreateToggle({
    Name = "AUTO SHOT AIMBOT",
    CurrentValue = false,
    Flag = "AutoShotAimbotToggle",
    Callback = function(Value)
        AutoShotAimbotEnabled = Value
    end,
})

CombatTab:CreateDropdown({
    Name = "AUTO SHOT AIMBOT HUMANOID",
    Options = {"HEAD", "BELLY", "RIGHT ARM", "LEFT ARM", "RIGHT LEG", "LEFT LEG"},
    CurrentOption = "HEAD",
    Flag = "AutoHumanoidDropdown",
    Callback = function(Option)
        SelectedHitbox = Option
    end,
})

local ESPEnabled = false
local BoxESPEnabled = false
local SkeletonESPEnabled = false
local TracersEnabled = false
local NameESPEnabled = false
local DistanceESPEnabled = false
local EspLineEnabled = false
local EspColorValue = Color3.fromRGB(255, 255, 255)

VisualTab:CreateToggle({
    Name = "ESP (General / Paredes)",
    CurrentValue = false,
    Flag = "EspToggle",
    Callback = function(Value)
        ESPEnabled = Value
    end,
})

VisualTab:CreateToggle({
    Name = "Box ESP (Corner / Full / 3D)",
    CurrentValue = false,
    Flag = "BoxEspToggle",
    Callback = function(Value)
        BoxESPEnabled = Value
    end,
})

VisualTab:CreateToggle({
    Name = "Skeleton ESP",
    CurrentValue = false,
    Flag = "SkeletonEspToggle",
    Callback = function(Value)
        SkeletonESPEnabled = Value
    end,
})

VisualTab:CreateToggle({
    Name = "Tracers (Snaplines)",
    CurrentValue = false,
    Flag = "TracersToggle",
    Callback = function(Value)
        TracersEnabled = Value
    end,
})

VisualTab:CreateToggle({
    Name = "Name ESP",
    CurrentValue = false,
    Flag = "NameEspToggle",
    Callback = function(Value)
        NameESPEnabled = Value
    end,
})

VisualTab:CreateToggle({
    Name = "Distance ESP",
    CurrentValue = false,
    Flag = "DistanceEspToggle",
    Callback = function(Value)
        DistanceESPEnabled = Value
    end,
})

VisualTab:CreateToggle({
    Name = "ESP LINE (Hacia el cielo)",
    CurrentValue = false,
    Flag = "EspLineToggle",
    Callback = function(Value)
        EspLineEnabled = Value
    end,
})

VisualTab:CreateColorPicker({
    Name = "Color de todos los ESP",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "EspColorPicker",
    Callback = function(Value)
        EspColorValue = Value
    end,
})

game:GetService("RunService").RenderStepped:Connect(function()
    local localPlayer = game:GetService("Players").LocalPlayer
    
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local rootPart = character.HumanoidRootPart
            local head = character:FindFirstChild("Head")
            
            if EspLineEnabled and head then
                local cam = workspace.CurrentCamera
                local headPos, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen then
                end
            end
        end
    end
end)

Rayfield:LoadConfiguration()
  
