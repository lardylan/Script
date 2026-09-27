--// NEXXUZHUB | LARDYLAN V1 - PATCHED

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local old = PlayerGui:FindFirstChild("NexxuzPatched")
if old then
    old:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "NexxuzPatched"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

--// CORNER
local function Corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

--// RAINBOW
local function Rainbow(obj)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Parent = obj

    task.spawn(function()
        local hue = 0

        while stroke.Parent do
            hue = (hue + 0.01) % 1
            stroke.Color = Color3.fromHSV(hue, 1, 1)
            task.wait(0.03)
        end
    end)
end

--// DRAG
local function Drag(frame)
    local dragging = false
    local dragStart
    local startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and
        (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

            local delta = input.Position - dragStart

            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

--// MAIN FRAME
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 370, 0, 260)
Frame.Position = UDim2.new(0.5, -185, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

Corner(Frame, 18)
Rainbow(Frame)
Drag(Frame)

--// TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "NexxuzHub|lardylan V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

--// PATCHED
local Patched = Instance.new("TextLabel")
Patched.Size = UDim2.new(1, -20, 0, 60)
Patched.Position = UDim2.new(0, 10, 0, 65)
Patched.BackgroundTransparency = 1
Patched.Text = "SCRIPT PATCHED"
Patched.TextColor3 = Color3.new(1, 1, 1)
Patched.TextSize = 25
Patched.Font = Enum.Font.GothamBlack
Patched.Parent = Frame

--// MENSAJE
local Message = Instance.new("TextLabel")
Message.Size = UDim2.new(1, -30, 0, 45)
Message.Position = UDim2.new(0, 15, 0, 115)
Message.BackgroundTransparency = 1
Message.Text = "CONSIGUE EL SCRIPT V2"
Message.TextColor3 = Color3.fromRGB(220, 220, 220)
Message.TextSize = 16
Message.Font = Enum.Font.GothamBold
Message.Parent = Frame

--// FLECHA
local Arrow = Instance.new("TextLabel")
Arrow.Size = UDim2.new(0, 50, 0, 40)
Arrow.Position = UDim2.new(0.5, 35, 0, 145)
Arrow.BackgroundTransparency = 1
Arrow.Text = "↓"
Arrow.TextColor3 = Color3.new(1, 1, 1)
Arrow.TextSize = 30
Arrow.Font = Enum.Font.GothamBlack
Arrow.Parent = Frame

--// GET V2
local GetV2 = Instance.new("TextButton")
GetV2.Size = UDim2.new(0, 190, 0, 45)
GetV2.Position = UDim2.new(0.5, -95, 0, 195)
GetV2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
GetV2.BorderSizePixel = 0
GetV2.Text = "GET V2"
GetV2.TextColor3 = Color3.new(1, 1, 1)
GetV2.TextSize = 16
GetV2.Font = Enum.Font.GothamBold
GetV2.Parent = Frame

Corner(GetV2, 12)
Rainbow(GetV2)

--// AVISO
local Notice = Instance.new("TextLabel")
Notice.Size = UDim2.new(0, 270, 0, 45)
Notice.Position = UDim2.new(0.5, -135, 0, 15)
Notice.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Notice.BorderSizePixel = 0
Notice.Text = ""
Notice.TextColor3 = Color3.new(1, 1, 1)
Notice.TextSize = 14
Notice.Font = Enum.Font.GothamBold
Notice.Visible = false
Notice.Parent = Gui

Corner(Notice, 12)
Rainbow(Notice)

--// GET V2
GetV2.MouseButton1Click:Connect(function()

    local link = "https://pastebin.com/raw/Q6auxduN"

    if setclipboard then
        setclipboard(link)
    end

    Notice.Text = "V2 COPIADO ✅"
    Notice.Visible = true

    Notice.Position = UDim2.new(0.5, -135, 0, -55)

    TweenService:Create(
        Notice,
        TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            Position = UDim2.new(0.5, -135, 0, 15)
        }
    ):Play()

    task.wait(2)

    TweenService:Create(
        Notice,
        TweenInfo.new(0.35),
        {
            Position = UDim2.new(0.5, -135, 0, -55)
        }
    ):Play()

    task.wait(0.4)
    Notice.Visible = false
end)
