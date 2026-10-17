local Library = {}
Library.__index = Library

function Library:CreateWindow(config)
    local titleText = (type(config) == "table" and config.Name) or (type(config) == "string" and config) or "FERDAN"

    local Players = game:GetService("Players")
    local CoreGui = game:GetService("CoreGui")
    local parentGui = (gethui and gethui()) or CoreGui

    if parentGui:FindFirstChild("FerdanLibrary_UI") then
        parentGui.FerdanLibrary_UI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FerdanLibrary_UI"
    ScreenGui.Parent = parentGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(21, 22, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 300, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = titleText
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -35, 0, 8)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(230, 50, 60)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, -20, 0, 35)
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    local TabList = Instance.new("UIListLayout")
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8)
    TabList.Parent = TabContainer

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -20, 1, -95)
    ContentContainer.Position = UDim2.new(0, 10, 0, 90)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local firstTab = true
    local WindowObj = {}
    local pages = {}

    function WindowObj:CreateTab(tabName)
        local page = Instance.new("ScrollingFrame")
        page.Name = tabName .. "Page"
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 4
        page.Visible = false
        page.Parent = ContentContainer

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 8)
        layout.Parent = page

        if firstTab then
            page.Visible = true
            firstTab = false
        end

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 140, 1, 0)
        btn.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(200, 200, 210)
        btn.TextSize = 13
        btn.Font = Enum.Font.SourceSansBold
        btn.Parent = TabContainer

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            for _, p in pairs(pages) do p.Visible = false end
            page.Visible = true
        end)

        pages[tabName] = page

        local TabObj = {}

        function TabObj:CreateButton(name, callback)
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -10, 0, 38)
            b.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
            b.Text = "  " .. name
            b.TextColor3 = Color3.fromRGB(230, 230, 240)
            b.TextSize = 14
            b.Font = Enum.Font.SourceSans
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Parent = page

            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 6)
            c.Parent = b

            b.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        function TabObj:CreateToggle(name, callback)
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, -10, 0, 38)
            f.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
            f.Parent = page

            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 6)
            c.Parent = f

            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(1, -60, 1, 0)
            l.Position = UDim2.new(0, 12, 0, 0)
            l.BackgroundTransparency = 1
            l.Text = name
            l.TextColor3 = Color3.fromRGB(230, 230, 240)
            l.TextSize = 14
            l.Font = Enum.Font.SourceSans
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = f

            local tBtn = Instance.new("TextButton")
            tBtn.Size = UDim2.new(0, 40, 0, 22)
            tBtn.Position = UDim2.new(1, -48, 0.5, -11)
            tBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
            tBtn.Text = ""
            tBtn.Parent = f

            local tc = Instance.new("UICorner")
            tc.CornerRadius = UDim.new(1, 0)
            tc.Parent = tBtn

            local circle = Instance.new("Frame")
            circle.Size = UDim2.new(0, 16, 0, 16)
            circle.Position = UDim2.new(0, 3, 0.5, -8)
            circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
            circle.Parent = tBtn

            local cc = Instance.new("UICorner")
            cc.CornerRadius = UDim.new(1, 0)
            cc.Parent = circle

            local state = false
            tBtn.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    tBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    circle.Position = UDim2.new(1, -19, 0.5, -8)
                    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                else
                    tBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
                    circle.Position = UDim2.new(0, 3, 0.5, -8)
                    circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
                end
                if callback then callback(state) end
            end)
        end

        return TabObj
    end

    return WindowObj
end

return Library
     b.TextColor3 = Color3.fromRGB(230, 230, 240)
            b.TextSize = 14
            b.Font = Enum.Font.SourceSans
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Parent = page

            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 6)
            c.Parent = b

            b.MouseButton1Click:Connect(callback)
        end

        -- Crear Toggle
        function TabObj:CreateToggle(name, callback)
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, -10, 0, 38)
            f.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
            f.Parent = page

            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 6)
            c.Parent = f

            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(1, -60, 1, 0)
            l.Position = UDim2.new(0, 12, 0, 0)
            l.BackgroundTransparency = 1
            l.Text = name
            l.TextColor3 = Color3.fromRGB(230, 230, 240)
            l.TextSize = 14
            l.Font = Enum.Font.SourceSans
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = f

            local tBtn = Instance.new("TextButton")
            tBtn.Size = UDim2.new(0, 40, 0, 22)
            tBtn.Position = UDim2.new(1, -48, 0.5, -11)
            tBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
            tBtn.Text = ""
            tBtn.Parent = f

            local tc = Instance.new("UICorner")
            tc.CornerRadius = UDim.new(1, 0)
            tc.Parent = tBtn

            local circle = Instance.new("Frame")
            circle.Size = UDim2.new(0, 16, 0, 16)
            circle.Position = UDim2.new(0, 3, 0.5, -8)
            circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
            circle.Parent = tBtn

            local cc = Instance.new("UICorner")
            cc.CornerRadius = UDim.new(1, 0)
            cc.Parent = circle

            local state = false
            tBtn.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    tBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    circle.Position = UDim2.new(1, -19, 0.5, -8)
                    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                else
                    tBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
                    circle.Position = UDim2.new(0, 3, 0.5, -8)
                    circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
                end
                callback(state)
            end)
        end

        return TabObj
    end

    return WindowObj
end

return Library
