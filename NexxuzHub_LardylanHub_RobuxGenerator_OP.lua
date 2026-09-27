--========================================================
-- NEXXUZHUB | LARDYLANHUB
-- VISUAL DEMO / LOCAL ONLY
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- CONFIG
--========================================================

local CORRECT_KEY = "Delta. Robux"

-- Audio solicitado
local MUSIC_ID = "rbxassetid://16190782181"

local VISUAL_ROBUX = 0

-- Estas son SOLO condiciones internas del GUI.
-- No modifican las opciones reales de Delta.
local AntiScam = false
local DisableRobux = false
local VerifyTeleports = false

-- Inventario exclusivamente visual
local VisualInventory = {}

--========================================================
-- GUI
--========================================================

local gui = Instance.new("ScreenGui")
gui.Name = "NexxuzHub_LardylanHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

--========================================================
-- UTILIDADES
--========================================================

local function AddCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = obj
    return c
end

local function AddRainbowStroke(obj, thickness)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness or 2
    s.Parent = obj

    task.spawn(function()
        local hue = 0

        while s.Parent do
            hue = (hue + 0.008) % 1
            s.Color = Color3.fromHSV(hue, 1, 1)
            task.wait()
        end
    end)

    return s
end

local function Label(parent, text, size, position, textSize)
    local l = Instance.new("TextLabel")

    l.BackgroundTransparency = 1
    l.Size = size
    l.Position = position
    l.Text = text
    l.TextColor3 = Color3.new(1,1,1)
    l.TextSize = textSize or 16
    l.Font = Enum.Font.GothamBold
    l.Parent = parent

    return l
end

local function Button(parent, text, size, position)
    local b = Instance.new("TextButton")

    b.Size = size
    b.Position = position
    b.BackgroundColor3 = Color3.fromRGB(18,18,18)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 15
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = false
    b.Parent = parent

    AddCorner(b, 10)
    AddRainbowStroke(b, 2)

    return b
end

local function Notification(text)
    local n = Instance.new("TextLabel")

    n.Size = UDim2.fromOffset(270,55)
    n.Position = UDim2.new(1,-285,0.5,-28)
    n.BackgroundColor3 = Color3.fromRGB(15,15,15)
    n.Text = text
    n.TextColor3 = Color3.new(1,1,1)
    n.TextSize = 14
    n.Font = Enum.Font.GothamBold
    n.Parent = gui

    AddCorner(n,10)
    AddRainbowStroke(n,2)

    task.delay(2.5,function()
        if n then
            n:Destroy()
        end
    end)
end

local function CreateCircle(parent, color, position)
    local c = Instance.new("Frame")

    c.Size = UDim2.fromOffset(12,12)
    c.Position = position
    c.BackgroundColor3 = color
    c.Parent = parent

    AddCorner(c,20)

    return c
end

--========================================================
-- KEY SYSTEM
--========================================================

local keyFrame = Instance.new("Frame")

keyFrame.Size = UDim2.fromOffset(410,235)
keyFrame.Position = UDim2.new(0.5,-205,0.5,-117)
keyFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)
keyFrame.Parent = gui

AddCorner(keyFrame,14)
AddRainbowStroke(keyFrame,2)

CreateCircle(
    keyFrame,
    Color3.fromRGB(255,50,50),
    UDim2.fromOffset(15,15)
)

CreateCircle(
    keyFrame,
    Color3.fromRGB(50,120,255),
    UDim2.fromOffset(34,15)
)

CreateCircle(
    keyFrame,
    Color3.fromRGB(255,220,40),
    UDim2.fromOffset(53,15)
)

Label(
    keyFrame,
    "NexxuzHub | LardylanHub",
    UDim2.new(1,-80,0,32),
    UDim2.fromOffset(85,5),
    18
)

Label(
    keyFrame,
    "KEY SYSTEM",
    UDim2.new(1,0,0,25),
    UDim2.fromOffset(0,50),
    15
)

local keyBox = Instance.new("TextBox")

keyBox.Size = UDim2.fromOffset(265,42)
keyBox.Position = UDim2.fromOffset(20,90)
keyBox.BackgroundColor3 = Color3.fromRGB(10,10,10)
keyBox.PlaceholderText = "Introduce la Key..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.PlaceholderColor3 = Color3.fromRGB(140,140,140)
keyBox.TextSize = 15
keyBox.Font = Enum.Font.Gotham
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame

AddCorner(keyBox,9)
AddRainbowStroke(keyBox,2)

local login = Button(
    keyFrame,
    "LOGIN",
    UDim2.fromOffset(90,42),
    UDim2.fromOffset(300,90)
)

local copy = Button(
    keyFrame,
    "COPY LINK 🔗",
    UDim2.fromOffset(370,40),
    UDim2.fromOffset(20,150)
)

copy.MouseButton1Click:Connect(function()

    local link = "https://pastebin.com/raw/bzxTtLAy"

    if setclipboard then
        pcall(function()
            setclipboard(link)
        end)

        Notification("LINK COPIED 🔗✅")
    else
        Notification("Link: pastebin.com/raw/bzxTtLAy")
    end
end)

--========================================================
-- MÚSICA
--========================================================

local music = Instance.new("Sound")

music.Name = "EHYUU_Music"
music.SoundId = MUSIC_ID
music.Volume = 0.5
music.Looped = true
music.Parent = SoundService

--========================================================
-- MAIN GUI
--========================================================

local main = Instance.new("Frame")

main.Size = UDim2.fromOffset(540,390)
main.Position = UDim2.new(0.5,-270,0.5,-195)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Visible = false
main.Parent = gui

--========================================================
-- HEADER
--========================================================

local header = Instance.new("Frame")

header.Size = UDim2.new(1,0,0,58)
header.BackgroundColor3 = Color3.fromRGB(8,8,8)
header.Parent = main

CreateCircle(
    header,
    Color3.fromRGB(255,50,50),
    UDim2.fromOffset(18,23)
)

CreateCircle(
    header,
    Color3.fromRGB(50,120,255),
    UDim2.fromOffset(37,23)
)

CreateCircle(
    header,
    Color3.fromRGB(255,220,40),
    UDim2.fromOffset(56,23)
)

Label(
    header,
    "ROBUX GENERATER",
    UDim2.new(1,-100,1,0),
    UDim2.fromOffset(85,0),
    19
)

--========================================================
-- SALDO
--========================================================

local balance = Label(
    main,
    "Robux: 0",
    UDim2.new(1,-40,0,40),
    UDim2.fromOffset(20,75),
    18
)

--========================================================
-- CANTIDAD
--========================================================

local amount = Instance.new("TextBox")

amount.Size = UDim2.new(1,-40,0,48)
amount.Position = UDim2.fromOffset(20,120)
amount.BackgroundColor3 = Color3.fromRGB(28,28,28)
amount.PlaceholderText = "Eje: 9999 Robux"
amount.Text = ""
amount.TextColor3 = Color3.new(1,1,1)
amount.PlaceholderColor3 = Color3.fromRGB(140,140,140)
amount.TextSize = 16
amount.Font = Enum.Font.GothamBold
amount.Parent = main

AddCorner(amount,9)
AddRainbowStroke(amount,2)

local apply = Button(
    main,
    "Aplicar Robux",
    UDim2.fromOffset(220,48),
    UDim2.fromOffset(20,190)
)

local info = Button(
    main,
    "INFO",
    UDim2.fromOffset(220,48),
    UDim2.fromOffset(300,190)
)

--========================================================
-- INVENTARIO
--========================================================

local inventoryButton = Button(
    main,
    "INVENTARIO",
    UDim2.fromOffset(460,45),
    UDim2.fromOffset(40,255)
)

--========================================================
-- APLICAR ROBUX
--========================================================

apply.MouseButton1Click:Connect(function()

    local value = tonumber(amount.Text)

    if not value then
        Notification("Cantidad inválida ❌")
        return
    end

    if value < 0 then
        Notification("Cantidad inválida ❌")
        return
    end

    VISUAL_ROBUX = math.floor(value)

    balance.Text = "Robux: " .. VISUAL_ROBUX

    Notification("ROBUX GENERATER CORRECT ✅")
end)

--========================================================
-- INFO
--========================================================

local infoFrame = Instance.new("Frame")

infoFrame.Size = UDim2.fromOffset(440,380)
infoFrame.Position = UDim2.new(0.5,-220,0.5,-190)
infoFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
infoFrame.Visible = false
infoFrame.ZIndex = 20
infoFrame.Parent = gui

AddCorner(infoFrame,14)
AddRainbowStroke(infoFrame,2)

Label(
    infoFrame,
    "INFO",
    UDim2.new(1,0,0,40),
    UDim2.fromOffset(0,5),
    19
)

--========================================================
-- PERFIL 1
--========================================================

local profile1 = Instance.new("ImageLabel")

profile1.Size = UDim2.fromOffset(70,70)
profile1.Position = UDim2.fromOffset(25,55)
profile1.BackgroundColor3 = Color3.fromRGB(45,45,45)
profile1.ZIndex = 21
profile1.Parent = infoFrame

AddCorner(profile1,50)

Label(
    infoFrame,
    "NexxuzHub",
    UDim2.fromOffset(300,30),
    UDim2.fromOffset(110,55),
    17
).ZIndex = 21

Label(
    infoFrame,
    "Fide2283 • Building",
    UDim2.fromOffset(300,30),
    UDim2.fromOffset(110,82),
    13
).ZIndex = 21

--========================================================
-- PERFIL 2
--========================================================

local profile2 = Instance.new("ImageLabel")

profile2.Size = UDim2.fromOffset(70,70)
profile2.Position = UDim2.fromOffset(25,145)
profile2.BackgroundColor3 = Color3.fromRGB(45,45,45)
profile2.ZIndex = 21
profile2.Parent = infoFrame

AddCorner(profile2,50)

Label(
    infoFrame,
    "lardylan",
    UDim2.fromOffset(300,30),
    UDim2.fromOffset(110,145),
    17
).ZIndex = 21

Label(
    infoFrame,
    "XxREGALITOxX34 • ADMIN",
    UDim2.fromOffset(300,30),
    UDim2.fromOffset(110,172),
    13
).ZIndex = 21

--========================================================
-- CARGAR AVATARES
--========================================================

local function LoadAvatar(username, imageLabel)

    task.spawn(function()

        local success, userId = pcall(function()
            return Players:GetUserIdFromNameAsync(username)
        end)

        if not success or not userId then
            return
        end

        local ok, content = pcall(function()

            return Players:GetUserThumbnailAsync(
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size150x150
            )

        end)

        if ok and content then
            imageLabel.Image = content
        end

    end)

end

LoadAvatar("Fide2283",profile1)
LoadAvatar("XxREGALITOxX34",profile2)

--========================================================
-- MENSAJE INFO
--========================================================

local infoText = Instance.new("TextLabel")

infoText.Size = UDim2.fromOffset(390,100)
infoText.Position = UDim2.fromOffset(25,245)
infoText.BackgroundColor3 = Color3.fromRGB(10,10,10)
infoText.TextWrapped = true
infoText.Text =
    "Hola bienvenido al Robux generador ❤️\n\n" ..
    "Lo que estás viendo son Robux falsos para contenido. " ..
    "El saldo y los objetos mostrados son solamente visuales."
infoText.TextColor3 = Color3.new(1,1,1)
infoText.TextSize = 13
infoText.Font = Enum.Font.Gotham
infoText.ZIndex = 21
infoText.Parent = infoFrame

AddCorner(infoText,10)
AddRainbowStroke(infoText,1)

info.MouseButton1Click:Connect(function()
    infoFrame.Visible = not infoFrame.Visible
end)

--========================================================
-- INVENTARIO VISUAL
--========================================================

local inventoryFrame = Instance.new("Frame")

inventoryFrame.Size = UDim2.fromOffset(450,330)
inventoryFrame.Position = UDim2.new(0.5,-225,0.5,-165)
inventoryFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
inventoryFrame.Visible = false
inventoryFrame.ZIndex = 30
inventoryFrame.Parent = gui

AddCorner(inventoryFrame,14)
AddRainbowStroke(inventoryFrame,2)

Label(
    inventoryFrame,
    "INVENTARIO",
    UDim2.new(1,0,0,45),
    UDim2.fromOffset(0,5),
    19
).ZIndex = 31

local inventoryList = Instance.new("ScrollingFrame")

inventoryList.Size = UDim2.new(1,-30,1,-65)
inventoryList.Position = UDim2.fromOffset(15,55)
inventoryList.BackgroundTransparency = 1
inventoryList.ScrollBarThickness = 5
inventoryList.ZIndex = 31
inventoryList.Parent = inventoryFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,8)
layout.Parent = inventoryList

local function RefreshInventory()

    for _, child in ipairs(inventoryList:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    for _, item in ipairs(VisualInventory) do

        local itemFrame = Instance.new("Frame")

        itemFrame.Size = UDim2.new(1,-10,0,65)
        itemFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        itemFrame.ZIndex = 32
        itemFrame.Parent = inventoryList

        AddCorner(itemFrame,10)

        local nameLabel = Label(
            itemFrame,
            item.Name,
            UDim2.new(1,-120,0,30),
            UDim2.fromOffset(15,7),
            15
        )

        nameLabel.ZIndex = 33

        local status = Label(
            itemFrame,
            "COMPRADO ✅",
            UDim2.new(1,-120,0,25),
            UDim2.fromOffset(15,35),
            12
        )

        status.TextColor3 = Color3.fromRGB(80,255,100)
        status.ZIndex = 33

        local noEquip = Label(
            itemFrame,
            "NO EQUIPABLE",
            UDim2.fromOffset(105,35),
            UDim2.fromOffset(300,15),
            11
        )

        noEquip.ZIndex = 33
    end

    inventoryList.CanvasSize =
        UDim2.fromOffset(0,layout.AbsoluteContentSize.Y + 10)
end

inventoryButton.MouseButton1Click:Connect(function()

    inventoryFrame.Visible = not inventoryFrame.Visible

    if inventoryFrame.Visible then
        RefreshInventory()
    end
end)

--========================================================
-- COMPRA VISUAL
--========================================================

local function CanVisualBuy()

    -- Son condiciones internas de esta demostración.
    -- NO cambian las opciones reales del executor.

    if AntiScam then
        return false
    end

    if DisableRobux then
        return false
    end

    if VerifyTeleports then
        return false
    end

    return true
end

local function VisualBuy(itemName, price)

    if not CanVisualBuy() then

        Notification(
            "Desactiva las 3 opciones para comprar ❌"
        )

        return
    end

    if VISUAL_ROBUX < price then

        Notification(
            "Robux insuficientes ❌"
        )

        return
    end

    VISUAL_ROBUX =
        VISUAL_ROBUX - price

    balance.Text =
        "Robux: " .. VISUAL_ROBUX

    table.insert(
        VisualInventory,
        {
            Name = itemName,
            Price = price
        }
    )

    Notification(
        "COMPRA VISUAL CORRECTA ✅"
    )

    RefreshInventory()
end

--========================================================
-- EJEMPLO DE PRODUCTO
--========================================================

local shopButton = Button(
    main,
    "SILENCIADOR DE CUERVOS • 499 ROBUX",
    UDim2.fromOffset(460,45),
    UDim2.fromOffset(40,310)
)

shopButton.MouseButton1Click:Connect(function()

    VisualBuy(
        "Silenciador de cuervos",
        499
    )

end)

--========================================================
-- LOGIN
--========================================================

login.MouseButton1Click:Connect(function()

    if keyBox.Text == CORRECT_KEY then

        Notification(
            "KEY CORRECTAMENTE ✅"
        )

        -- Música solamente después de Key correcta
        pcall(function()
            music:Play()
        end)

        task.wait(0.5)

        keyFrame.Visible = false
        main.Visible = true

    else

        Notification(
            "KEY INCORRECT ❌"
        )

    end
end)

--========================================================
-- DRAG
--========================================================

local function MakeDraggable(frame, handle)

    local dragging = false
    local dragStart
    local startPosition

    handle.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = frame.Position

            input.Changed:Connect(function()

                if input.UserInputState ==
                    Enum.UserInputState.End then

                    dragging = false

                end

            end)

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if not dragging then
            return
        end

        if input.UserInputType ==
            Enum.UserInputType.MouseMovement

        or input.UserInputType ==
            Enum.UserInputType.Touch then

            local delta =
                input.Position - dragStart

            frame.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,

                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )

        end

    end)

end

MakeDraggable(keyFrame,keyFrame)
MakeDraggable(main,header)
MakeDraggable(infoFrame,infoFrame)
MakeDraggable(inventoryFrame,inventoryFrame)

--========================================================
-- FINAL
--========================================================

Notification("NexxuzHub cargado ✅")
