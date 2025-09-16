-- Начальная загрузка adminka.lua
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/adminka-/refs/heads/main/adminka.lua"))()
end)
if not success then warn("Failed to load initial script (adminka.lua): " .. tostring(err)) end

local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function loadScript(url)
    local success, result = pcall(function()
        local response = game:HttpGet(url, true)
        return response and response ~= "" and loadstring(response)() or nil
    end)
    if not success then
        warn("Error loading script from " .. url .. ": " .. tostring(result))
        return false
    end
    return true
end

local function tryLoadScripts()
    task.spawn(function()
        loadScript("https://raw.githubusercontent.com/z0nxx/rtgfght/refs/heads/main/rtgfght.lua")
        task.wait(1)
        loadScript("https://raw.githubusercontent.com/z0nxx/image-script/refs/heads/main/image.lua")
    end)
end

local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui", 5))
screenGui.Name = "Z0nxxHub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local blurEffect = Instance.new("BlurEffect", game:GetService("Lighting"))
blurEffect.Size = 0
blurEffect.Enabled = false

-- Оптимизированные размеры для мобильных и ПК
local mainFrameSize = isMobile and UDim2.new(0.9, 0, 0.8, 0) or UDim2.new(0, 800, 0, 500)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 1
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
uiStroke.Transparency = 0.5

local headerFrame = Instance.new("Frame", mainFrame)
headerFrame.Size = UDim2.new(1, 0, 0, isMobile and 40 or 60)
headerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
headerFrame.BackgroundTransparency = 0.1
headerFrame.ZIndex = 2

local avatarCircle = Instance.new("ImageButton", headerFrame)
avatarCircle.Size = UDim2.new(0, isMobile and 32 or 50, 0, isMobile and 32 or 50)
avatarCircle.Position = UDim2.new(0, 8, 0, isMobile and 4 or 5)
avatarCircle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
avatarCircle.Image = "rbxassetid://94562916053131"
avatarCircle.Image = avatarCircle.Image == "" and "rbxasset://textures/ui/GuiImagePlaceholder.png" or avatarCircle.Image
avatarCircle.ScaleType = Enum.ScaleType.Fit
avatarCircle.ZIndex = 3
Instance.new("UICorner", avatarCircle).CornerRadius = UDim.new(1, 0)
local avatarStroke = Instance.new("UIStroke", avatarCircle)
avatarStroke.Thickness = 1
avatarStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

local headerLabel = Instance.new("TextLabel", headerFrame)
headerLabel.Size = UDim2.new(1, -(isMobile and 48 or 70), 1, 0)
headerLabel.Position = UDim2.new(0, isMobile and 40 or 60, 0, 0)
headerLabel.BackgroundTransparency = 1
headerLabel.Text = "z0nxx Hub"
headerLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
headerLabel.Font = Enum.Font.SourceSansBold
headerLabel.TextSize = isMobile and 10 or 16
headerLabel.TextXAlignment = Enum.TextXAlignment.Center
headerLabel.TextWrapped = true
headerLabel.ZIndex = 3
TweenService:Create(headerLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()

local closeButton = Instance.new("TextButton", headerFrame)
closeButton.Size = UDim2.new(0, isMobile and 20 or 30, 0, isMobile and 20 or 30)
closeButton.Position = UDim2.new(1, -(isMobile and 24 or 35), 0.5, -(isMobile and 10 or 15))
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(180, 180, 180)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = isMobile and 8 or 14
closeButton.ZIndex = 3
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 5)

local function createSound(soundId, parent)
    local sound = Instance.new("Sound", parent or SoundService)
    sound.SoundId = "rbxassetid://" .. tostring(soundId)
    sound.Volume = 0.5
    return sound
end

local function showNotification(message)
    local notificationFrame = screenGui:FindFirstChild("NotificationFrame")
    if not notificationFrame then return end
    local notificationLabel = notificationFrame:FindFirstChild("NotificationLabel")
    if not notificationLabel then return end
    notificationLabel.Text = message or "Скрипт активирован!"
    notificationFrame.Visible = true
    local notificationInTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 1, isMobile and -60 or -80)})
    local notificationOutTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1, isMobile and -40 or -60)})
    notificationInTween:Play()
    task.wait(1.5)
    notificationOutTween:Play()
    notificationOutTween.Completed:Wait()
    notificationFrame.Visible = false
end

closeButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 1.5, 0)})
    local blurTweenOut = TweenService:Create(blurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0})
    closeTween:Play()
    blurTweenOut:Play()
    closeTween.Completed:Wait()
    blurEffect.Enabled = false
    mainFrame.Visible = false
end)
closeButton.MouseEnter:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(80, 20, 20), 0.5)}):Play()
end)
closeButton.MouseLeave:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)}):Play()
end)

local dragging, dragInput, dragStart, startPos
headerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
headerFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, isMobile and 60 or 80, 1, -headerFrame.Size.Y.Offset)
sidebar.Position = UDim2.new(0, 0, 0, headerFrame.Size.Y.Offset)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sidebar.BackgroundTransparency = 0.1
sidebar.ZIndex = 2
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -(isMobile and 60 or 80), 1, -headerFrame.Size.Y.Offset)
contentFrame.Position = UDim2.new(0, isMobile and 60 or 80, 0, headerFrame.Size.Y.Offset)
contentFrame.BackgroundTransparency = 1
contentFrame.ClipsDescendants = true
contentFrame.ZIndex = 2

local tabs = {"О Создателе", "FE Скрипты", "Телепорты", "Поиск Игроков"}
local buttons, contentFrames = {}, {}

local tabListLayout = Instance.new("UIListLayout", sidebar)
tabListLayout.FillDirection = Enum.FillDirection.Vertical
tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabListLayout.Padding = UDim.new(0, isMobile and 3 or 6)
tabListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local secretFrame = Instance.new("Frame", contentFrame)
secretFrame.Size = UDim2.new(1, -8, 1, -8)
secretFrame.Position = UDim2.new(0, 4, 0, 4)
secretFrame.BackgroundTransparency = 0.1
secretFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
secretFrame.Visible = false
secretFrame.ClipsDescendants = true
secretFrame.ZIndex = 3
Instance.new("UICorner", secretFrame).CornerRadius = UDim.new(0, 8)
local secretStroke = Instance.new("UIStroke", secretFrame)
secretStroke.Thickness = 1
secretStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

local secretLabel = Instance.new("TextLabel", secretFrame)
secretLabel.Size = UDim2.new(1, -8, 1, -8)
secretLabel.Position = UDim2.new(0, 4, 0, 4)
secretLabel.BackgroundTransparency = 1
secretLabel.Text = string.format(
    "<font size='%d' face='SourceSansBold'>Поздравляем!</font>\n\n" ..
    "Ты нашёл пасхалку! 🥚\n" ..
    "Это секретная вкладка z0nxx Hub!\n\n" ..
    "Присоединяйся к нашему Telegram-каналу:\n" ..
    "<font color='#00b7eb'><a href='https://t.me/z0nxxHUB'>https://t.me/z0nxxHUB</a></font>\n\n" ..
    "А также:\n• Получай секретные обновления\n• Участвуй в розыгрышах\n• Стань частью комьюнити!",
    isMobile and 10 or 16
)
secretLabel.RichText = true
secretLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
secretLabel.Font = Enum.Font.SourceSans
secretLabel.TextSize = isMobile and 8 or 14
secretLabel.TextWrapped = true
secretLabel.TextXAlignment = Enum.TextXAlignment.Center
secretLabel.TextYAlignment = Enum.TextYAlignment.Center
secretLabel.ZIndex = 3
TweenService:Create(secretLabel, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.2}):Play()

avatarCircle.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    for _, frame in ipairs(contentFrames) do
        frame.Visible = false
    end
    secretFrame.Visible = true
    for _, btn in ipairs(buttons) do
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end
    blurEffect.Enabled = true
    local blurTweenIn = TweenService:Create(blurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 12})
    blurTweenIn:Play()
    local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
    openTween:Play()
    showNotification("Пасхалка найдена!")
    local clickSound = createSound("9120386446")
    if clickSound then clickSound:Play() end
end)

for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 40 or 50)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(180, 180, 180)
    button.Text = tabName
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = isMobile and 7 or 12
    button.TextWrapped = true
    button.ZIndex = 3
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Thickness = 1
    buttonStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

    local contentFrameTab = Instance.new("Frame", contentFrame)
    contentFrameTab.Size = UDim2.new(1, -8, 1, -8)
    contentFrameTab.Position = UDim2.new(0, 4, 0, 4)
    contentFrameTab.BackgroundTransparency = 1
    contentFrameTab.Visible = i == 1
    contentFrameTab.ClipsDescendants = true
    contentFrameTab.ZIndex = 2

    table.insert(buttons, button)
    table.insert(contentFrames, contentFrameTab)

    button.MouseButton1Click:Connect(function()
        for j, frame in ipairs(contentFrames) do frame.Visible = (j == i) end
        secretFrame.Visible = false
        for j, btn in ipairs(buttons) do
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = (j == i) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30)}):Play()
        end
        if i == 4 then
            updatePlayerList()
        end
    end)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    button.MouseLeave:Connect(function()
        local j = table.find(buttons, button)
        if j then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = (j == i and contentFrames[i].Visible) and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30)}):Play()
        end
    end)
end

for i = 1, 3 do
    local emptyButton = Instance.new("TextButton", sidebar)
    emptyButton.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 40 or 50)
    emptyButton.BackgroundTransparency = 1
    emptyButton.Text = ""
    emptyButton.ZIndex = 3
    table.insert(buttons, emptyButton)
end

local creatorScroll = Instance.new("ScrollingFrame", contentFrames[1])
creatorScroll.Size = UDim2.new(1, 0, 1, 0)
creatorScroll.BackgroundTransparency = 1
creatorScroll.ScrollBarThickness = isMobile and 3 or 4
creatorScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
creatorScroll.ZIndex = 2
creatorScroll.ClipsDescendants = true
local creatorListLayout = Instance.new("UIListLayout", creatorScroll)
creatorListLayout.Padding = UDim.new(0, isMobile and 4 or 6)
creatorListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local creatorData = {
    {
        UserId = 2316299341,
        Name = "z0nxx",
        Title = "Создатель скрипта",
        Info = "• Опыт работы: 3 года\n• Дата создания: 23.03.2025\n• Версия: 2.0",
        Contact = "• Discord: z0nxx\n• Roblox: https://www.roblox.com/users/2316299341/profile",
        Description = "Создатель этого удивительного хаба!"
    },
    {
        UserId = 4254815427,
        Name = "Lil_darkie",
        Title = "@Popabebripeach - Тестировщик",
        Info = "• Роль: Тестирование на мобильных\n• Вклад: Отладка и оптимизация",
        Contact = "Lil_darkie помог сделать скрипт удобным для мобильных игроков.",
        Description = "Спасибо за помощь в проекте!"
    }
}

for _, data in ipairs(creatorData) do
    local card = Instance.new("Frame", creatorScroll)
    card.Size = UDim2.new(1, -8, 0, isMobile and 160 or 280)
    card.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    card.BackgroundTransparency = 0.1
    card.ZIndex = 2
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
    local cardStroke = Instance.new("UIStroke", card)
    cardStroke.Thickness = 1
    cardStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

    local avatar = Instance.new("ImageLabel", card)
    avatar.Size = isMobile and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 100, 0, 100)
    avatar.Position = UDim2.new(0, 8, 0, 8)
    avatar.BackgroundTransparency = 1
    local success, thumbnail = pcall(function()
        return Players:GetUserThumbnailAsync(data.UserId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size48x48 or Enum.ThumbnailSize.Size150x150)
    end)
    avatar.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    avatar.ZIndex = 2
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(0, 8)
    local avatarStroke = Instance.new("UIStroke", avatar)
    avatarStroke.Thickness = 1
    avatarStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

    local info = Instance.new("TextLabel", card)
    info.Size = isMobile and UDim2.new(1, -60, 0, 140) or UDim2.new(1, -110, 0, 260)
    info.Position = isMobile and UDim2.new(0, 60, 0, 8) or UDim2.new(0, 110, 0, 10)
    info.BackgroundTransparency = 1
    info.Text = string.format(
        "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#cccccc'>%s</font>\n\n%s\n\n%s\n\n%s",
        isMobile and 8 or 14,
        data.Name,
        data.Title,
        data.Info,
        data.Contact,
        data.Description
    )
    info.RichText = true
    info.TextColor3 = Color3.fromRGB(180, 180, 180)
    info.Font = Enum.Font.SourceSans
    info.TextSize = isMobile and 7 or 12
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.ZIndex = 2
    Instance.new("UIPadding", info).PaddingLeft = UDim.new(0, 4)
    Instance.new("UIPadding", info).PaddingTop = UDim.new(0, 4)
end
creatorScroll.CanvasSize = UDim2.new(0, 0, 0, (#creatorData * (isMobile and 164 or 286)) + 6)

local feScrollFrame = Instance.new("ScrollingFrame", contentFrames[2])
feScrollFrame.Size = UDim2.new(1, 0, 1, isMobile and -30 or -40)
feScrollFrame.Position = UDim2.new(0, 0, 0, isMobile and 30 or 40)
feScrollFrame.BackgroundTransparency = 1
feScrollFrame.ScrollBarThickness = isMobile and 3 or 4
feScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
feScrollFrame.ZIndex = 2
feScrollFrame.ClipsDescendants = true
local feGridLayout = Instance.new("UIGridLayout", feScrollFrame)
feGridLayout.CellSize = isMobile and UDim2.new(0, 100, 0, 30) or UDim2.new(0, 160, 0, 40)
feGridLayout.CellPadding = isMobile and UDim2.new(0, 6, 0, 6) or UDim2.new(0, 10, 0, 10)
feGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
feGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local sliderFrame = Instance.new("Frame", contentFrames[2])
sliderFrame.Size = isMobile and UDim2.new(0.8, 0, 0, 20) or UDim2.new(0, 360, 0, 28)
sliderFrame.Position = UDim2.new(0.5, 0, 0, 4)
sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sliderFrame.BackgroundTransparency = 0.2
sliderFrame.ZIndex = 2
Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 8)

local slider = Instance.new("TextButton", sliderFrame)
slider.Size = UDim2.new(0, isMobile and 20 or 32, 0, isMobile and 20 or 28)
slider.Position = UDim2.new(0, isMobile and 80 or 164, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
slider.Text = ""
slider.ZIndex = 2
Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 8)

local sliderLabel = Instance.new("TextLabel", contentFrames[2])
sliderLabel.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 20 or 24)
sliderLabel.Position = UDim2.new(0, 4, 0, 4)
sliderLabel.Text = "Скорость:"
sliderLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Font = Enum.Font.SourceSansSemibold
sliderLabel.TextSize = isMobile and 7 or 12
sliderLabel.TextWrapped = true
sliderLabel.ZIndex = 2

local valueLabel = Instance.new("TextLabel", contentFrames[2])
valueLabel.Size = UDim2.new(0, isMobile and 30 or 40, 0, isMobile and 20 or 24)
valueLabel.Position = UDim2.new(1, -(isMobile and 34 or 46), 0, 4)
valueLabel.Text = "15.0"
valueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
valueLabel.BackgroundTransparency = 1
valueLabel.Font = Enum.Font.SourceSansSemibold
valueLabel.TextSize = isMobile and 7 or 12
valueLabel.TextWrapped = true
valueLabel.ZIndex = 2

local sliderDragging, sliderValue = false, 15
local function updateSliderValue()
    if sliderFrame and slider and sliderFrame.AbsoluteSize.X > 0 and slider.AbsoluteSize.X > 0 then
        local sliderRange = sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X
        sliderValue = math.clamp((slider.Position.X.Offset / sliderRange) * 30, 0, 30)
        valueLabel.Text = string.format("%.1f", sliderValue)
    end
end

slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = true
    end
end)
slider.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mouseX = input.Position.X
        local frameX = sliderFrame.AbsolutePosition.X
        local newX = math.clamp(mouseX - frameX - (slider.AbsoluteSize.X / 2), 0, sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X)
        slider.Position = UDim2.new(0, newX, 0, 0)
        updateSliderValue()
    end
end)
slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = false
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        valueLabel.Text = string.format("%.1f", sliderValue)
    end
end)

local function applyAnimationSpeed(character)
    if not character then return end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid") or character:FindFirstChildWhichIsA("AnimationController")
    if not humanoid then return end
    local success, err = pcall(function()
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if track and track:IsA("AnimationTrack") then
                track:AdjustSpeed(sliderValue)
            end
        end
    end)
    if not success then warn("Error applying animation speed: " .. tostring(err)) end
end

task.spawn(function()
    while task.wait(0.5) do
        local character = LocalPlayer.Character
        applyAnimationSpeed(character)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(0.1)
    applyAnimationSpeed(character)
end)

local feScripts = {
    {"Fly (PC)", "https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua"},
    {"R4D", "https://raw.githubusercontent.com/M1ZZ001/BrookhavenR4D/main/Brookhaven%20R4D%20Script"},
    {"Bypass Chat", "https://raw.githubusercontent.com/z0nxx/bypass-chat-by-z0nxx/refs/heads/main/bypass%20chat/lua"},
    {"Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {"Mango Hub", "https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub"},
    {"Rvanka", "https://raw.githubusercontent.com/z0nxx/rvanka/refs/heads/main/rvankabyz0nxx.lua"},
    {"System Broken", "https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"},
    {"AVATAR EDITOR", "https://rawscripts.net/raw/Brookhaven-RP-Free-Script-16614"},
    {"R6", "https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"},
    {"Chat Draw", "https://raw.githubusercontent.com/z0nxx/chat-draw/refs/heads/main/chat%20draw"},
    {"Vape", "https://raw.githubusercontent.com/z0nxx/vape/refs/heads/main/vape.lua"},
    {"Fling v3", "https://raw.githubusercontent.com/z0nxx/z0nxx-fling-v-3/refs/heads/main/flingv3.lua"},
    {"ToolEditor", "https://raw.githubusercontent.com/z0nxx/risovalka-script/refs/heads/main/risovalka.lua"},
    {"Charball", "https://raw.githubusercontent.com/Melishy/melishy-scripts/main/charball/script.lua"},
    {"RTX", "https://raw.githubusercontent.com/z0nxx/rtx/refs/heads/main/rtxbyz0nxx.lua"},
    {"Jerk Off", "https://raw.githubusercontent.com/z0nxx/jerk-off-by-z0nxx/refs/heads/main/jerk%20off.lua"},
    {"Invisible", "https://raw.githubusercontent.com/z0nxx/invise/refs/heads/main/invisible.lua"},
    {"HOUSEunbanned", "https://raw.githubusercontent.com/z0nxx/UNBANEHOUSE/refs/heads/main/houseUnbane.lua"},
    {"Fake IP Grabber", "https://pastebin.com/raw/aziWwaw2"},
    {"Universal Emotes", "https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua"},
    {"Dance Hub", "https://raw.githubusercontent.com/z0nxx/dance-script/refs/heads/main/dance.lua"}
}

for _, data in ipairs(feScripts) do
    local feButton = Instance.new("TextButton", feScrollFrame)
    feButton.Size = isMobile and UDim2.new(0, 100, 0, 30) or UDim2.new(0, 160, 0, 40)
    feButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    feButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    feButton.Text = data[1]
    feButton.Font = Enum.Font.SourceSansSemibold
    feButton.TextSize = isMobile and 7 or 12
    feButton.TextWrapped = true
    feButton.ZIndex = 2
    Instance.new("UICorner", feButton).CornerRadius = UDim.new(0, 6)
    local feStroke = Instance.new("UIStroke", feButton)
    feStroke.Thickness = 1
    feStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

    feButton.MouseButton1Click:Connect(function()
        if loadScript(data[2]) then
            showNotification(data[1] .. " активирован!")
        else
            showNotification("Ошибка активации " .. data[1])
        end
    end)
    feButton.MouseEnter:Connect(function()
        TweenService:Create(feButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40), Size = isMobile and UDim2.new(0, 104, 0, 32) or UDim2.new(0, 164, 0, 44)}):Play()
    end)
    feButton.MouseLeave:Connect(function()
        TweenService:Create(feButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30), Size = isMobile and UDim2.new(0, 100, 0, 30) or UDim2.new(0, 160, 0, 40)}):Play()
    end)
end

local columns = isMobile and 2 or 3
local rows = math.ceil(#feScripts / columns)
feScrollFrame.CanvasSize = UDim2.new(0, 0, 0, (isMobile and 30 or 40) + (rows * (isMobile and 36 or 50) + (isMobile and 6 or 10)))

local teleportFrame = Instance.new("ScrollingFrame", contentFrames[3])
teleportFrame.Size = UDim2.new(1, 0, 1, 0)
teleportFrame.BackgroundTransparency = 1
teleportFrame.ScrollBarThickness = isMobile and 3 or 4
teleportFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
teleportFrame.ZIndex = 2
teleportFrame.ClipsDescendants = true
local teleportLayout = Instance.new("UIListLayout", teleportFrame)
teleportLayout.Padding = UDim.new(0, isMobile and 4 or 6)
teleportLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local savedPositions = {}
local teleportLocations = {
    {Name = "Спавн", Position = Vector3.new(-22.2000103, 2.4087739, 15.4999981)},
    {Name = "База", Position = Vector3.new(-81.4962692, 17.4849072, -124.388054)},
    {Name = "AFK Зона", Position = Vector3.new(333.547943, 89.6000061, 107.741913), Angle = CFrame.Angles(0, math.pi, 0)}
}

for i = 1, 4 do
    local button = Instance.new("TextButton", teleportFrame)
    button.Size = UDim2.new(1, -8, 0, isMobile and 28 or 36)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(180, 180, 180)
    button.Text = i <= #teleportLocations and teleportLocations[i].Name or (i == 4 and "Сохранить Точку" or "Телепорт к Сохранённой Точке")
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = isMobile and 7 or 12
    button.TextWrapped = true
    button.ZIndex = 2
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Thickness = 1
    buttonStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

    button.MouseButton1Click:Connect(function()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if i <= #teleportLocations then
                local cf = CFrame.new(teleportLocations[i].Position)
                if teleportLocations[i].Angle then cf = cf * teleportLocations[i].Angle end
                character.HumanoidRootPart.CFrame = cf
                showNotification("Телепорт в " .. teleportLocations[i].Name)
            elseif i == 4 then
                table.insert(savedPositions, character.HumanoidRootPart.Position)
                button.Text = "Сохранить Точку (" .. #savedPositions .. ")"
                showNotification("Точка сохранена!")
            elseif i == 5 and #savedPositions > 0 then
                character.HumanoidRootPart.CFrame = CFrame.new(savedPositions[#savedPositions])
                showNotification("Телепорт к последней сохранённой точке")
            else
                showNotification("Нет сохранённых точек!")
            end
        else
            showNotification("Ошибка: Ваш персонаж не загружен!")
        end
    end)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)
end
teleportFrame.CanvasSize = UDim2.new(0, 0, 0, 4 * (isMobile and 32 or 42))

local playerListFrame = Instance.new("Frame", contentFrames[4])
playerListFrame.Size = isMobile and UDim2.new(0.4, 0, 1, -8) or UDim2.new(0, 160, 1, -12)
playerListFrame.Position = UDim2.new(0, 4, 0, 4)
playerListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerListFrame.BackgroundTransparency = 0.1
playerListFrame.ZIndex = 2
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 8)

local playerListTitle = Instance.new("TextLabel", playerListFrame)
playerListTitle.Size = UDim2.new(1, 0, 0, isMobile and 24 or 32)
playerListTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerListTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
playerListTitle.Text = "Игроки"
playerListTitle.Font = Enum.Font.SourceSansBold
playerListTitle.TextSize = isMobile and 8 or 14
playerListTitle.TextWrapped = true
playerListTitle.ZIndex = 2
Instance.new("UICorner", playerListTitle).CornerRadius = UDim.new(0, 8)

local playerListScroll = Instance.new("ScrollingFrame", playerListFrame)
playerListScroll.Size = UDim2.new(1, 0, 1, isMobile and -28 or -40)
playerListScroll.Position = UDim2.new(0, 0, 0, isMobile and 24 or 32)
playerListScroll.BackgroundTransparency = 1
playerListScroll.ScrollBarThickness = isMobile and 3 or 4
playerListScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
playerListScroll.ZIndex = 2
playerListScroll.ClipsDescendants = true
local playerListLayout = Instance.new("UIListLayout", playerListScroll)
playerListLayout.Padding = UDim.new(0, isMobile and 2 or 3)

local playerInfoFrame = Instance.new("Frame", contentFrames[4])
playerInfoFrame.Size = isMobile and UDim2.new(0.55, 0, 1, -8) or UDim2.new(0, 320, 1, -12)
playerInfoFrame.Position = isMobile and UDim2.new(0.45, 4, 0, 4) or UDim2.new(0, 170, 0, 6)
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
playerInfoFrame.BackgroundTransparency = 0.1
playerInfoFrame.ZIndex = 2
Instance.new("UICorner", playerInfoFrame).CornerRadius = UDim.new(0, 8)

local avatarImage = Instance.new("ImageLabel", playerInfoFrame)
avatarImage.Size = isMobile and UDim2.new(0, 40, 0, 40) or UDim2.new(0, 100, 0, 100)
avatarImage.Position = UDim2.new(0.5, -(isMobile and 20 or 50), 0, isMobile and 8 or 10)
avatarImage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
avatarImage.ZIndex = 2
Instance.new("UICorner", avatarImage).CornerRadius = UDim.new(0, 8)
local avatarStroke = Instance.new("UIStroke", avatarImage)
avatarStroke.Thickness = 1
avatarStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

local playerInfo = Instance.new("TextLabel", playerInfoFrame)
playerInfo.Size = isMobile and UDim2.new(1, -8, 0, 80) or UDim2.new(1, -12, 0, 140)
playerInfo.Position = isMobile and UDim2.new(0, 4, 0, 50) or UDim2.new(0, 6, 0, 120)
playerInfo.BackgroundTransparency = 1
playerInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
playerInfo.Font = Enum.Font.SourceSans
playerInfo.TextSize = isMobile and 7 or 12
playerInfo.TextWrapped = true
playerInfo.TextXAlignment = Enum.TextXAlignment.Left
playerInfo.TextYAlignment = Enum.TextYAlignment.Top
playerInfo.Text = "Выберите игрока."
playerInfo.RichText = true
playerInfo.ZIndex = 2

local teleportButton = Instance.new("TextButton", playerInfoFrame)
teleportButton.Size = isMobile and UDim2.new(0, 60, 0, 24) or UDim2.new(0, 120, 0, 32)
teleportButton.Position = isMobile and UDim2.new(0.5, -30, 1, -28) or UDim2.new(0.5, -60, 1, -40)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)
teleportButton.TextColor3 = Color3.fromRGB(180, 180, 180)
teleportButton.Text = "Телепорт"
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = isMobile and 7 or 12
teleportButton.TextWrapped = true
teleportButton.Visible = false
teleportButton.ZIndex = 2
Instance.new("UICorner", teleportButton).CornerRadius = UDim.new(0, 6)

local function waitForCharacter(player, timeout)
    timeout = timeout or 3
    local startTime = tick()
    while tick() - startTime < timeout do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            return player.Character
        end
        task.wait(0.1)
    end
    return nil
end

local selectedPlayer = nil
local selectedPlayerName = nil

teleportButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        playerInfo.Text = "Выберите игрока.\n\n<font color='#ff5555'>Ошибка: Ваш персонаж не загружен!</font>"
        showNotification("Ошибка: Ваш персонаж не загружен!")
        return
    end
    if not selectedPlayer or not Players:FindFirstChild(selectedPlayer.Name) then
        playerInfo.Text = "Выберите игрока.\n\n<font color='#ff5555'>Ошибка: Игрок не выбран или не в игре!</font>"
        showNotification("Ошибка: Игрок не выбран или не в игре!")
        warn("Teleport failed: selectedPlayer is nil or player left (" .. (selectedPlayerName or "nil") .. ")")
        selectedPlayer = nil
        selectedPlayerName = nil
        teleportButton.Visible = false
        return
    end
    local targetCharacter = waitForCharacter(selectedPlayer)
    if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = targetCharacter.HumanoidRootPart.CFrame
        playerInfo.Text = string.format(
            "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#cccccc'>@%s</font>\n\nUserID: %d\nСоздан: %s\nКоманда: %s\nВ игре: Да\n\n<font color='#00ff00'>Телепорт успешен!</font>",
            isMobile and 8 or 14,
            selectedPlayer.DisplayName,
            selectedPlayer.Name,
            selectedPlayer.UserId,
            selectedPlayer.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - selectedPlayer.AccountAge * 86400) or "Неизвестно",
            selectedPlayer.Team and selectedPlayer.Team.Name or "Без команды"
        )
        showNotification("Телепорт к " .. selectedPlayer.Name)
    else
        playerInfo.Text = string.format(
            "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#cccccc'>@%s</font>\n\nUserID: %d\nСоздан: %s\nКоманда: %s\nВ игре: Нет\n\n<font color='#ff5555'>Ошибка: Персонаж игрока не загружен!</font>",
            isMobile and 8 or 14,
            selectedPlayer.DisplayName,
            selectedPlayer.Name,
            selectedPlayer.UserId,
            selectedPlayer.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - selectedPlayer.AccountAge * 86400) or "Неизвестно",
            selectedPlayer.Team and selectedPlayer.Team.Name or "Без команды"
        )
        showNotification("Ошибка: Персонаж игрока не загружен!")
        warn("Teleport failed: No valid character or HumanoidRootPart for " .. selectedPlayer.Name)
    end
end)
teleportButton.MouseEnter:Connect(function()
    TweenService:Create(teleportButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(80, 20, 20), 0.5)}):Play()
end)
teleportButton.MouseLeave:Connect(function()
    TweenService:Create(teleportButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)}):Play()
end)

local themeToggle = Instance.new("TextButton", contentFrames[1])
themeToggle.Size = UDim2.new(0, isMobile and 60 or 90, 0, isMobile and 24 or 30)
themeToggle.Position = UDim2.new(0.5, -(isMobile and 30 or 45), 1, -(isMobile and 28 or 36))
themeToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
themeToggle.Text = "Светлая Тема"
themeToggle.TextColor3 = Color3.fromRGB(180, 180, 180)
themeToggle.Font = Enum.Font.SourceSansSemibold
themeToggle.TextSize = isMobile and 7 or 12
themeToggle.TextWrapped = true
themeToggle.ZIndex = 2
Instance.new("UICorner", themeToggle).CornerRadius = UDim.new(0, 6)

local isDark = true
themeToggle.MouseButton1Click:Connect(function()
    isDark = not isDark
    local newMainColor = isDark and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(200, 200, 200)
    local newContentColor = isDark and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(180, 180, 180)
    local newTextColor = isDark and Color3.fromRGB(180, 180, 180) or Color3.fromRGB(30, 30, 30)

    TweenService:Create(mainFrame, TweenInfo.new(0.3), {BackgroundColor3 = newMainColor}):Play()
    TweenService:Create(sidebar, TweenInfo.new(0.3), {BackgroundColor3 = isDark and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(220, 220, 220)}):Play()
    TweenService:Create(headerFrame, TweenInfo.new(0.3), {BackgroundColor3 = isDark and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(220, 220, 220)}):Play()
    for _, frame in ipairs(contentFrames) do
        TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundColor3 = newContentColor}):Play()
    end
    for _, btn in ipairs(buttons) do
        TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = newTextColor}):Play()
    end
    themeToggle.Text = isDark and "Светлая Тема" or "Тёмная Тема"
    headerLabel.TextColor3 = newTextColor
end)

local function updatePlayerList()
    local previousSelectedPlayerName = selectedPlayerName
    selectedPlayer = nil
    selectedPlayerName = nil
    teleportButton.Visible = false
    playerInfo.Text = "Выберите игрока."
    avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

    for _, child in ipairs(playerListScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    for i, player in ipairs(Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton", playerListScroll)
        playerButton.Size = UDim2.new(1, -4, 0, isMobile and 24 or 32)
        playerButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        playerButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        playerButton.Text = player.Name
        playerButton.Font = Enum.Font.SourceSansSemibold
        playerButton.TextSize = isMobile and 7 or 12
        playerButton.TextWrapped = true
        playerButton.ZIndex = 2
        Instance.new("UICorner", playerButton).CornerRadius = UDim.new(0, 5)

        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            selectedPlayerName = player.Name
            warn("Selected player: " .. player.Name)
            local userId = player.UserId
            local creationDate = player.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - player.AccountAge * 86400) or "Неизвестно"
            local displayName = player.DisplayName
            local username = player.Name
            local team = player.Team and player.Team.Name or "Без команды"
            local isInGame = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and "Да" or "Нет"
            local success, thumbnail = pcall(function()
                return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size48x48 or Enum.ThumbnailSize.Size150x150)
            end)
            avatarImage.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
            playerInfo.Text = string.format(
                "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#cccccc'>@%s</font>\n\nUserID: %d\nСоздан: %s\nКоманда: %s\nВ игре: %s",
                isMobile and 8 or 14,
                displayName,
                username,
                userId,
                creationDate,
                team,
                isInGame
            )
            teleportButton.Visible = true
        end)
        playerButton.MouseEnter:Connect(function()
            TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        end)
        playerButton.MouseLeave:Connect(function()
            TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        end)

        if previousSelectedPlayerName and player.Name == previousSelectedPlayerName then
            playerButton:InputBegan({UserInputType = Enum.UserInputType.MouseButton1})
        end
    end
    playerListScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * (isMobile and 26 or 35))
end

if buttons[4] then buttons[4].MouseButton1Click:Connect(updatePlayerList) end
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, isMobile and 32 or 50, 0, isMobile and 32 or 50)
toggleButton.Position = UDim2.new(0, 8, 0.5, -(isMobile and 16 or 25))
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.Text = ""
toggleButton.BackgroundTransparency = 1
toggleButton.ZIndex = 10
toggleButton.Active = true
local toggleButtonImage = Instance.new("ImageLabel", toggleButton)
toggleButtonImage.Size = UDim2.new(1, -2, 1, -2)
toggleButtonImage.Position = UDim2.new(0, 1, 0, 1)
toggleButtonImage.BackgroundTransparency = 1
toggleButtonImage.Image = "rbxassetid://15771263443"
toggleButtonImage.Image = toggleButtonImage.Image == "" and "rbxasset://textures/ui/GuiImagePlaceholder.png" or toggleButtonImage.Image
toggleButtonImage.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
Instance.new("UICorner", toggleButtonImage).CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new("UIStroke", toggleButton)
toggleStroke.Thickness = 1
toggleStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

local btnDragging, btnDragStart, btnStartPos
toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = toggleButton.Position
    end
end)
toggleButton.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        toggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)
toggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = false
    end
end)

local notificationFrame = Instance.new("Frame", screenGui)
notificationFrame.Size = UDim2.new(0, isMobile and 140 or 260, 0, isMobile and 30 or 40)
notificationFrame.Position = UDim2.new(0.5, 0, 1, isMobile and -40 or -60)
notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
notificationFrame.BackgroundTransparency = 0.1
notificationFrame.Visible = false
notificationFrame.ZIndex = 5
Instance.new("UICorner", notificationFrame).CornerRadius = UDim.new(0, 8)
local notificationStroke = Instance.new("UIStroke", notificationFrame)
notificationStroke.Thickness = 1
notificationStroke.Color = Color3.fromRGB(0, 0, 0):Lerp(Color3.fromRGB(60, 10, 10), 0.5)

local notificationLabel = Instance.new("TextLabel", notificationFrame)
notificationLabel.Size = UDim2.new(1, -4, 1, -4)
notificationLabel.Position = UDim2.new(0, 2, 0, 2)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = "Скрипт активирован!"
notificationLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
notificationLabel.Font = Enum.Font.SourceSansSemibold
notificationLabel.TextSize = isMobile and 8 or 14
notificationLabel.TextWrapped = true
notificationLabel.TextXAlignment = Enum.TextXAlignment.Center
notificationLabel.TextYAlignment = Enum.TextYAlignment.Center
notificationLabel.ZIndex = 5
notificationLabel.Name = "NotificationLabel"

local isOpen, isFirstLaunch = false, true
local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 1.5, 0)})
local blurTweenIn = TweenService:Create(blurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 12})
local blurTweenOut = TweenService:Create(blurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0})

local function playFirstLaunchAnimation()
    local startSound = createSound("9120386446")
    if startSound then startSound:Play() end
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "z0nxx Hub - Enhanced Edition",
        Color = Color3.fromRGB(220, 220, 220),
        Font = Enum.Font.SourceSansBold,
        TextSize = isMobile and 14 or 18
    })
    mainFrame.Visible = true
    mainFrame.Size = isMobile and UDim2.new(0, 24, 0, 24) or UDim2.new(0, 60, 0, 60)
    mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2)
    local launchTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = mainFrameSize, Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
    blurEffect.Enabled = true
    blurTweenIn:Play()
    launchTween:Play()
    launchTween.Completed:Wait()
    isFirstLaunch = false
    isOpen = true
end

toggleButton.MouseButton1Click:Connect(function()
    if isFirstLaunch then
        playFirstLaunchAnimation()
    elseif isOpen then
        closeTween:Play()
        blurTweenOut:Play()
        closeTween.Completed:Wait()
        blurEffect.Enabled = false
        mainFrame.Visible = false
        isOpen = false
    else
        mainFrame.Visible = true
        for _, frame in ipairs(contentFrames) do frame.Visible = (frame == contentFrames[1]) end
        secretFrame.Visible = false
        openTween:Play()
        blurTweenIn:Play()
        isOpen = true
    end
end)
toggleButton.MouseEnter:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
end)
toggleButton.MouseLeave:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
end)

local function addClickSound(button)
    local clickSound = createSound("9120386446")
    if clickSound then
        button.MouseButton1Click:Connect(function() clickSound:Play() end)
    end
end

addClickSound(closeButton)
addClickSound(themeToggle)
addClickSound(teleportButton)
addClickSound(avatarCircle)
for _, btn in ipairs(buttons) do addClickSound(btn) end
for _, btn in ipairs(feScripts) do
    local feButton = feScrollFrame:FindFirstChild(btn[1])
    if feButton then addClickSound(feButton) end
end
for i = 1, 4 do
    local teleportBtn = teleportFrame:GetChildren()[i]
    if teleportBtn and teleportBtn:IsA("TextButton") then addClickSound(teleportBtn) end
end

if LocalPlayer then
    LocalPlayer.Chatted:Connect(function(msg)
        if msg == "!fly" then
            if loadScript("https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua") then
                showNotification("Fly активирован!")
            else
                showNotification("Ошибка активации Fly")
            end
        elseif msg == "!r6" then
            if loadScript("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua") then
                showNotification("R6 активирован!")
            else
                showNotification("Ошибка активации R6")
            end
        end
    end)
end

task.spawn(function()
    task.wait(2)
    playFirstLaunchAnimation()
    tryLoadScripts()
    send("z0nxx Hub loaded successfully")
end)
