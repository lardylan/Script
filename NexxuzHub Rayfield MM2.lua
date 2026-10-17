local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MM2 LARDYLAN Hub",
   LoadingTitle = "MM2 lardylan",
   LoadingSubtitle = "Por lardylan",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

local MainTab = Window:CreateTab("Principal", 4483362458)
local MovementTab = Window:CreateTab("Movimiento / Fling", 4483362458)
local ExtraTab = Window:CreateTab("EXTRA", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ESPEnabled = false
local GunESPEnabled = false
local AutoShotEnabled = false
local KillAllActive = false
local CoinFarmEnabled = false
local WalkFlingEnabled = false
local SpinFlingEnabled = false
local MurderSpinFlingActive = false
local SheriffSpinFlingActive = false
local FlingSpeed = 10000

local function GetRole(player)
    if not player or not player.Character then return "Innocent" end
    
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    if (backpack and backpack:FindFirstChild("Gun")) or (character and character:FindFirstChild("Gun")) then
        return "Sheriff"
    elseif (backpack and backpack:FindFirstChild("Knife")) or (character and character:FindFirstChild("Knife")) then
        return "Murderer"
    end
    
    return "Innocent"
end

local function IsInGame(player)
    if not player or not player.Character then return false end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    
    if not hrp or not humanoid or humanoid.Health <= 0 then return false end
    
    local lobby = workspace:FindFirstChild("Lobby")
    if lobby then
        local primary = lobby.PrimaryPart or lobby:FindFirstChildWhichIsA("BasePart")
        if primary and (hrp.Position - primary.Position).Magnitude < 150 then
            return false
        end
    end
    
    return true
end

local function IsCoinBagFull()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats and leaderstats:FindFirstChild("Coins") then
        if leaderstats.Coins.Value >= 10 then
            return true
        end
    end
    return false
end

local highlights = {}
local gunHighlights = {}

local function ClearESP()
    for _, highlight in pairs(highlights) do
        if highlight and highlight.Parent then 
            highlight:Destroy() 
        end
    end
    highlights = {}
end

local function ClearGunESP()
    for _, gh in pairs(gunHighlights) do
        if gh and gh.Parent then 
            gh:Destroy() 
        end
    end
    gunHighlights = {}
end

local function UpdateESP()
    ClearESP()
    if not ESPEnabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetRole(player)
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.Adornee = player.Character
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

            if role == "Murderer" then
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
            elseif role == "Sheriff" then
                highlight.FillColor = Color3.fromRGB(0, 100, 255)
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
            end

            highlight.Parent = player.Character
            table.insert(highlights, highlight)
        end
    end
end

local function UpdateGunESP()
    ClearGunESP()
    if not GunESPEnabled then return end

    local gunDrop = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun")
    
    if gunDrop then
        local highlight = Instance.new("Highlight")
        highlight.Name = "Gun_Highlight"
        highlight.Adornee = gunDrop
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = Color3.fromRGB(255, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
        highlight.Parent = gunDrop
        table.insert(gunHighlights, highlight)

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "Gun_Billboard"
        billboard.Adornee = gunDrop
        billboard.Size = UDim2.new(0, 120, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "🔫 ARMA AQUÍ"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.SourceSansBold

        billboard.Parent = gunDrop
        table.insert(gunHighlights, billboard)
    end
end

task.spawn(function()
    while task.wait(0.5) do
        if ESPEnabled then
            UpdateESP()
        end
        if GunESPEnabled then
            UpdateGunESP()
        end
    end
end)

MainTab:CreateToggle({
   Name = "ESP Roles (Sheriff, Murder, Inocente)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
       ESPEnabled = Value
       if not Value then
           ClearESP()
       end
   end,
})

MainTab:CreateToggle({
   Name = "ESP Arma Tirada (Gun Drop)",
   CurrentValue = false,
   Flag = "GunESPToggle",
   Callback = function(Value)
       GunESPEnabled = Value
       if not Value then
           ClearGunESP()
       end
   end,
})

MainTab:CreateToggle({
   Name = "AutoShot Murderer",
   CurrentValue = false,
   Flag = "AutoShotToggle",
   Callback = function(Value)
       AutoShotEnabled = Value
   end,
})

RunService.RenderStepped:Connect(function()
    if not AutoShotEnabled then return end
    
    local myCharacter = LocalPlayer.Character
    if not myCharacter then return end
    local gun = myCharacter:FindFirstChild("Gun") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Gun"))
    
    if gun then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and GetRole(player) == "Murderer" and IsInGame(player) then
                local murderHRP = player.Character:FindFirstChild("HumanoidRootPart")
                if murderHRP then
                    if gun.Parent ~= myCharacter then
                        gun.Parent = myCharacter
                    end
                    local knifePos = murderHRP.Position
                    gun:FindFirstChild("KnifeServer"):FindFirstChild("ShootGun"):FireServer(1, knifePos, myCharacter.HumanoidRootPart.Position)
                end
            end
        end
    end
end)

MainTab:CreateButton({
   Name = "Doble Knife (Solo Murderer)",
   Callback = function()
       local char = LocalPlayer.Character
       if not char then return end
       
       local knife = char:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
       
       if knife then
           if knife.Parent ~= char then
               knife.Parent = char
           end
           
           if char:FindFirstChild("Knife_Offhand") then return end
           
           local handle = knife:FindFirstChild("Handle")
           if handle then
               local cloneHandle = handle:Clone()
               cloneHandle.Name = "Knife_Offhand"
               cloneHandle.Parent = char
               
               local leftArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand")
               if leftArm then
                   local weld = Instance.new("Weld")
                   weld.Part0 = leftArm
                   weld.Part1 = cloneHandle
                   weld.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                   weld.Parent = cloneHandle
               end
               
               Rayfield:Notify({
                   Title = "Doble Knife",
                   Content = "¡Cuchillo secundario activado!",
                   Duration = 3,
                   Image = 4483362458,
               })
           end
       else
           Rayfield:Notify({
               Title = "Doble Knife",
               Content = "Debes tener el Cuchillo (Murderer) para usar esta función.",
               Duration = 3,
               Image = 4483362458,
           })
       end
   end,
})

MainTab:CreateButton({
   Name = "Kill All (1 Seg. por jugador)",
   Callback = function()
       if KillAllActive then return end
       KillAllActive = true
       
       local myCharacter = LocalPlayer.Character
       if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then 
           KillAllActive = false 
           return 
       end
       
       local tool = myCharacter:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
       if tool then
           tool.Parent = myCharacter
       end
       
       for _, player in pairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and IsInGame(player) then
               local targetHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
               if targetHRP and myCharacter:FindFirstChild("HumanoidRootPart") then
                   myCharacter.HumanoidRootPart.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
                   
                   if tool and tool:FindFirstChild("Stab") then
                       tool.Stab:FireServer()
                   elseif tool and tool:FindFirstChild("KnifeServer") then
                       tool.KnifeServer.ShootGun:FireServer(1, targetHRP.Position, myCharacter.HumanoidRootPart.Position)
                   end
                   
                   task.wait(1)
               end
           end
       end
       
       KillAllActive = false
   end,
})

MainTab:CreateToggle({
   Name = "Auto Farm Coins (Recoger Automático)",
   CurrentValue = false,
   Flag = "CoinFarmToggle",
   Callback = function(Value)
       CoinFarmEnabled = Value
       
       task.spawn(function()
           while CoinFarmEnabled do
               task.wait(0.2)
               
               if IsCoinBagFull() then
                   Rayfield:Notify({
                       Title = "Coin Farm",
                       Content = "¡Moneda Alcanzado / Bolsa Llena!",
                       Duration = 3,
                       Image = 4483362458,
                   })
                   CoinFarmEnabled = false
                   break
               end
               
               local myCharacter = LocalPlayer.Character
               local hrp = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
               
               if hrp and IsInGame(LocalPlayer) then
                   local coinContainer = workspace:FindFirstChild("CoinContainer") or workspace:FindFirstChild("NormalCoins")
                   
                   if coinContainer then
                       for _, coin in pairs(coinContainer:GetChildren()) do
                           if not CoinFarmEnabled then break end
                           local targetPart = coin:IsA("BasePart") and coin or coin:FindFirstChildWhichIsA("BasePart")
                           
                           if targetPart and hrp then
                               hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                               task.wait(0.2)
                           end
                       end
                   end
               end
           end
       end)
   end,
})

MovementTab:CreateToggle({
   Name = "Activar WalkFling",
   CurrentValue = false,
   Flag = "WalkFlingToggle",
   Callback = function(Value)
       WalkFlingEnabled = Value
       
       task.spawn(function()
           while WalkFlingEnabled do
               RunService.Heartbeat:Wait()
               local character = LocalPlayer.Character
               local hrp = character and character:FindFirstChild("HumanoidRootPart")
               
               if hrp then
                   local oldVelocity = hrp.Velocity
                   hrp.Velocity = Vector3.new(oldVelocity.X, FlingSpeed, oldVelocity.Z)
                   hrp.AssemblyAngularVelocity = Vector3.new(0, FlingSpeed, 0)
               end
           end
           
           local character = LocalPlayer.Character
           local hrp = character and character:FindFirstChild("HumanoidRootPart")
           if hrp then
               hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
           end
       end)
   end,
})

MovementTab:CreateToggle({
   Name = "Spin Fling",
   CurrentValue = false,
   Flag = "SpinFlingToggle",
   Callback = function(Value)
       SpinFlingEnabled = Value
       
       task.spawn(function()
           while SpinFlingEnabled do
               RunService.Heartbeat:Wait()
               local character = LocalPlayer.Character
               local hrp = character and character:FindFirstChild("HumanoidRootPart")
               
               if hrp then
                   hrp.AssemblyAngularVelocity = Vector3.new(0, FlingSpeed, 0)
               end
           end
           
           local character = LocalPlayer.Character
           local hrp = character and character:FindFirstChild("HumanoidRootPart")
           if hrp then
               hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
           end
       end)
   end,
})

MovementTab:CreateButton({
   Name = "Murder Spin Fling",
   Callback = function()
       if MurderSpinFlingActive then return end
       MurderSpinFlingActive = true
       
       local myCharacter = LocalPlayer.Character
       if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then
           MurderSpinFlingActive = false
           return
       end
       
       local murdererPlayer = nil
       for _, player in pairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and GetRole(player) == "Murderer" and IsInGame(player) then
               murdererPlayer = player
               break
           end
       end
       
       if murdererPlayer and murdererPlayer.Character and murdererPlayer.Character:FindFirstChild("HumanoidRootPart") then
           local targetHRP = murdererPlayer.Character.HumanoidRootPart
           local myHRP = myCharacter.HumanoidRootPart
           
           local connection
           local startTime = tick()
           
           connection = RunService.Heartbeat:Connect(function()
               if tick() - startTime > 2.5 or not murdererPlayer.Character or not murdererPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   connection:Disconnect()
                   myHRP.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                   MurderSpinFlingActive = false
                   return
               end
               
               myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 0)
               myHRP.AssemblyAngularVelocity = Vector3.new(0, FlingSpeed, 0)
           end)
       else
           MurderSpinFlingActive = false
       end
   end,
})

MovementTab:CreateButton({
   Name = "Sheriff Spin Fling",
   Callback = function()
       if SheriffSpinFlingActive then return end
       SheriffSpinFlingActive = true
       
       local myCharacter = LocalPlayer.Character
       if not myCharacter or not myCharacter:FindFirstChild("HumanoidRootPart") then
           SheriffSpinFlingActive = false
           return
       end
       
       local sheriffPlayer = nil
       for _, player in pairs(Players:GetPlayers()) do
           if player ~= LocalPlayer and GetRole(player) == "Sheriff" and IsInGame(player) then
               sheriffPlayer = player
               break
           end
       end
       
       if sheriffPlayer and sheriffPlayer.Character and sheriffPlayer.Character:FindFirstChild("HumanoidRootPart") then
           local targetHRP = sheriffPlayer.Character.HumanoidRootPart
           local myHRP = myCharacter.HumanoidRootPart
           
           local connection
           local startTime = tick()
           
           connection = RunService.Heartbeat:Connect(function()
               if tick() - startTime > 2.5 or not sheriffPlayer.Character or not sheriffPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   connection:Disconnect()
                   myHRP.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                   SheriffSpinFlingActive = false
                   return
               end
               
               myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 0)
               myHRP.AssemblyAngularVelocity = Vector3.new(0, FlingSpeed, 0)
           end)
       else
           SheriffSpinFlingActive = false
       end
   end,
})

local function CopyAvatarByName(targetUsername)
    local targetUserId
    pcall(function()
        targetUserId = Players:GetUserIdFromNameAsync(targetUsername)
    end)
    
    if targetUserId and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local description = Players:GetHumanoidDescriptionFromUserId(targetUserId)
            humanoid:ApplyDescription(description)
            Rayfield:Notify({
                Title = "Copiar Avatar",
                Content = "¡Avatar de " .. targetUsername .. " copiado con éxito!",
                Duration = 3,
                Image = 4483362458,
            })
        end
    else
        Rayfield:Notify({
            Title = "Copiar Avatar",
            Content = "No se pudo encontrar al usuario: " .. tostring(targetUsername),
            Duration = 3,
            Image = 4483362458,
        })
    end
end

local function EquipAnimationPackage(packId)
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local description = humanoid:GetAppliedDescription()
            description.IdleAnimation = packId
            description.WalkAnimation = packId
            description.RunAnimation = packId
            description.JumpAnimation = packId
            description.ClimbAnimation = packId
            humanoid:ApplyDescription(description)
            Rayfield:Notify({
                Title = "Animación",
                Content = "Paquete de animación aplicado.",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end
end

local function PlayEmote(emoteName)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local emoteTrack
        if emoteName == "Sit" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://250622237"
            emoteTrack = humanoid:LoadAnimation(anim)
        elseif emoteName == "Ninja Rest" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://250623128"
            emoteTrack = humanoid:LoadAnimation(anim)
        elseif emoteName == "Zen" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://313762093"
            emoteTrack = humanoid:LoadAnimation(anim)
        elseif emoteName == "Floss" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://1071434054"
            emoteTrack = humanoid:LoadAnimation(anim)
        elseif emoteName == "Dab" | emoteName == "Dab (El Dab)" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://250622313"
            emoteTrack = humanoid:L
