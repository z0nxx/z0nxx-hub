local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Load initial scripts with robust error handling
local function loadScript(url)
    local success, result = pcall(function()
        local response = game:HttpGet(url, true)
        if response then
            return loadstring(response)()
        else
            warn("Failed to fetch script from " .. url)
            return nil
        end
    end)
    if not success then
        warn("Error loading script from " .. url .. ": " .. tostring(result))
    end
    return success
end

-- Attempt to load external scripts with retry mechanism
local function tryLoadScripts()
    local success1 = loadScript("https://raw.githubusercontent.com/z0nxx/zastavca/refs/heads/main/zastavca.lua")
    task.wait(3) -- Wait to ensure first script executes
    local success2 = loadScript("https://raw.githubusercontent.com/z0nxx/image-script/refs/heads/main/image.lua")
    if not success1 or not success2 then
        warn("One or more external scripts failed to load. Continuing with GUI setup.")
    end
end

-- Sound setup with validation
local function createSound(soundId, parent)
    local sound = Instance.new("Sound")
    sound.Parent = parent
    local success, _ = pcall(function()
        sound.SoundId = "rbxassetid://" .. soundId
    end)
    if not success then
        warn("Invalid sound ID: " .. soundId .. ". Using default sound.")
        sound.SoundId = "rbxassetid://9120386446" -- Fallback sound ID
    end
    return sound
end

local startSound = createSound("102340414126480", SoundService)
local clickSound = createSound("80335956916443", SoundService)
startSound:Play()

-- System message
local success, _ = pcall(function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "z0nxx Hub - Enhanced Edition",
        Color = Color3.fromRGB(220, 220, 220),
        Font = Enum.Font.SourceSansBold,
        TextSize = isMobile and 16 or 18
    })
end)
if not success then
    warn("Failed to set system message. Chat may be disabled.")
end

-- ScreenGui setup with delayed initialization
local screenGui
local function initializeGui()
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
    screenGui.Name = "Z0nxxHub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    if not screenGui.Parent then
        warn("PlayerGui not found. Retrying in 5 seconds.")
        task.wait(5)
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
    end
end

local success, _ = pcall(initializeGui)
if not success then
    error("Failed to initialize ScreenGui. Ensure PlayerGui is accessible.")
end

-- Blur effect
local blurEffect = Instance.new("BlurEffect")
blurEffect.Parent = game:GetService("Lighting")
blurEffect.Size = 0
blurEffect.Enabled = false

-- Main frame with dark-gray theme
local mainFrameSize = isMobile and UDim2.new(0, 320, 0, 480) or UDim2.new(0, 640, 0, 480)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Visible = false
mainFrame.ClipsDescendants = true

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(70, 70, 70)
uiStroke.Transparency = 0.6
uiStroke.Parent = mainFrame

-- Top bar (increased size)
local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.Size = UDim2.new(1, 0, 0, isMobile and 48 or 64)
topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
topBar.BackgroundTransparency = 0.1
local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 12)
topBarCorner.Parent = topBar

-- Title (centered)
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = topBar
titleLabel.Size = UDim2.new(0, 180, 0, 36)
titleLabel.Position = UDim2.new(0.5, -90, 0.5, -18)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "z0nxx Hub"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = isMobile and 16 or 22
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextWrapped = true

-- Dragging functionality
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
topBar.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
topBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Add click sound to buttons
local function addClickSound(button)
    button.MouseButton1Click:Connect(function()
        clickSound:Play()
    end)
end

-- Notification frame
local notificationFrame = Instance.new("Frame")
notificationFrame.Parent = screenGui
notificationFrame.Size = UDim2.new(0, isMobile and 220 or 320, 0, isMobile and 44 or 56)
notificationFrame.Position = UDim2.new(0.5, -(isMobile and 110 or 160), 1, -72)
notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
notificationFrame.BackgroundTransparency = 0.2
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 10)
notificationCorner.Parent = notificationFrame
local notificationStroke = Instance.new("UIStroke")
notificationStroke.Thickness = 1
notificationStroke.Color = Color3.fromRGB(80, 80, 80)
notificationStroke.Parent = notificationFrame

local notificationLabel = Instance.new("TextLabel")
notificationLabel.Parent = notificationFrame
notificationLabel.Size = UDim2.new(1, -8, 1, -8)
notificationLabel.Position = UDim2.new(0, 4, 0, 4)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = "Скрипт активирован!"
notificationLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
notificationLabel.Font = Enum.Font.SourceSansSemibold
notificationLabel.TextSize = isMobile and 12 or 16
notificationLabel.TextWrapped = true
notificationLabel.TextXAlignment = Enum.TextXAlignment.Center
notificationLabel.TextYAlignment = Enum.TextYAlignment.Center

local notificationInTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(isMobile and 110 or 160), 1, -100)})
local notificationOutTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -(isMobile and 110 or 160), 1, -72)})

local function showNotification(message)
    notificationLabel.Text = message or "Скрипт активирован!"
    notificationFrame.Visible = true
    notificationInTween:Play()
    task.wait(2)
    notificationOutTween:Play()
    notificationOutTween.Completed:Connect(function()
        notificationFrame.Visible = false
    end)
end

-- Tab system
local tabs = {"О Создателе", "FE Скрипты", "Телепорты", "Поиск Игроков"}
local icons = {
    "rbxassetid://7072721682",
    "rbxassetid://7072719338",
    "rbxassetid://7072725347",
    "rbxassetid://7072718346"
}
local buttons, contentFrames = {}, {}

-- Tab buttons
local tabFrame = Instance.new("Frame")
tabFrame.Parent = mainFrame
tabFrame.Size = UDim2.new(1, 0, 0, 48)
tabFrame.Position = UDim2.new(0, 0, 0, isMobile and 48 or 64)
tabFrame.BackgroundTransparency = 1
local tabListLayout = Instance.new("UIListLayout")
tabListLayout.Parent = tabFrame
tabListLayout.FillDirection = Enum.FillDirection.Horizontal
tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabListLayout.Padding = UDim.new(0, isMobile and 6 or 8)

for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.Parent = tabFrame
    button.Size = UDim2.new(0, isMobile and 76 or 110, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Text = tabName
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = isMobile and 10 or 14
    button.BorderSizePixel = 0
    button.TextWrapped = true
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Thickness = 1
    buttonStroke.Color = Color3.fromRGB(80, 80, 80)
    buttonStroke.Parent = button
    
    local icon = Instance.new("ImageLabel")
    icon.Parent = button
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 8, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Image = icons[i]
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Parent = mainFrame
    contentFrame.Size = UDim2.new(1, -16, 1, isMobile and -96 or -112)
    contentFrame.Position = UDim2.new(0, 8, 0, isMobile and 88 or 104)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = i == 1
    contentFrame.ClipsDescendants = true
    
    table.insert(buttons, button)
    table.insert(contentFrames, contentFrame)
    
    addClickSound(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
    button.MouseButton1Click:Connect(function()
        for j, frame in ipairs(contentFrames) do
            frame.Visible = j == i
        end
        for j, btn in ipairs(buttons) do
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = j == i and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(45, 45, 45)}):Play()
        end
    end)
end

-- About Creator tab
local creatorScroll = Instance.new("ScrollingFrame")
creatorScroll.Parent = contentFrames[1]
creatorScroll.Size = UDim2.new(1, 0, 1, 0)
creatorScroll.BackgroundTransparency = 1
creatorScroll.ScrollBarThickness = 4
creatorScroll.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)
local creatorListLayout = Instance.new("UIListLayout")
creatorListLayout.Parent = creatorScroll
creatorListLayout.Padding = UDim.new(0, 8)
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
    local card = Instance.new("Frame")
    card.Parent = creatorScroll
    card.Size = UDim2.new(1, -16, 0, isMobile and 240 or 320)
    card.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    card.BackgroundTransparency = 0.2
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 10)
    cardCorner.Parent = card
    local cardStroke = Instance.new("UIStroke")
    cardStroke.Thickness = 1
    cardStroke.Color = Color3.fromRGB(80, 80, 80)
    cardStroke.Parent = card
    
    local avatar = Instance.new("ImageLabel")
    avatar.Parent = card
    avatar.Size = isMobile and UDim2.new(0, 70, 0, 70) or UDim2.new(0, 120, 0, 120)
    avatar.Position = UDim2.new(0, 12, 0, 12)
    avatar.BackgroundTransparency = 1
    local success, thumbnail = pcall(function()
        return Players:GetUserThumbnailAsync(data.UserId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size150x150)
    end)
    avatar.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(0, 10)
    avatarCorner.Parent = avatar
    local avatarStroke = Instance.new("UIStroke")
    avatarStroke.Thickness = 1
    avatarStroke.Color = Color3.fromRGB(90, 90, 90)
    avatarStroke.Parent = avatar
    
    local info = Instance.new("TextLabel")
    info.Parent = card
    info.Size = isMobile and UDim2.new(1, -90, 0, 200) or UDim2.new(1, -140, 0, 280)
    info.Position = isMobile and UDim2.new(0, 86, 0, 12) or UDim2.new(0, 136, 0, 12)
    info.BackgroundTransparency = 1
    info.Text = string.format(
        "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#cccccc'>%s</font>\n\n%s\n\n%s\n\n%s",
        isMobile and 12 or 16,
        data.Name,
        data.Title,
        data.Info,
        data.Contact,
        data.Description
    )
    info.RichText = true
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.Font = Enum.Font.SourceSans
    info.TextSize = isMobile and 10 or 14
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    local padding = Instance.new("UIPadding")
    padding.Parent = info
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
end
creatorScroll.CanvasSize = UDim2.new(0, 0, 0, (#creatorData * (isMobile and 248 or 328)) + 8)

-- FE Scripts tab
local feScrollFrame = Instance.new("ScrollingFrame")
feScrollFrame.Parent = contentFrames[2]
feScrollFrame.Size = UDim2.new(1, -16, 1, isMobile and -80 or -64)
feScrollFrame.Position = UDim2.new(0, 8, 0, isMobile and 64 or 56)
feScrollFrame.BackgroundTransparency = 1
feScrollFrame.ScrollBarThickness = 4
feScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)

local feGridLayout = Instance.new("UIGridLayout")
feGridLayout.Parent = feScrollFrame
feGridLayout.CellSize = isMobile and UDim2.new(0, 140, 0, 40) or UDim2.new(0, 180, 0, 48)
feGridLayout.CellPadding = isMobile and UDim2.new(0, 10, 0, 10) or UDim2.new(0, 12, 0, 12)
feGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
feGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Animation speed slider
local sliderFrame = Instance.new("Frame")
sliderFrame.Parent = contentFrames[2]
sliderFrame.Size = isMobile and UDim2.new(0, 260, 0, 28) or UDim2.new(0, 480, 0, 32)
sliderFrame.Position = UDim2.new(0.5, -(isMobile and 130 or 240), 0, 12)
sliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
sliderFrame.BackgroundTransparency = 0.3
local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local slider = Instance.new("TextButton")
slider.Parent = sliderFrame
slider.Size = UDim2.new(0, isMobile and 32 or 40, 0, isMobile and 28 or 32)
slider.Position = UDim2.new(0, isMobile and 114 or 220, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
slider.Text = ""
local sliderCornerButton = Instance.new("UICorner")
sliderCornerButton.CornerRadius = UDim.new(0, 10)
sliderCornerButton.Parent = slider

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Parent = contentFrames[2]
sliderLabel.Size = UDim2.new(0, 80, 0, 28)
sliderLabel.Position = UDim2.new(0, 8, 0, 12)
sliderLabel.Text = "Скорость:"
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Font = Enum.Font.SourceSansSemibold
sliderLabel.TextSize = isMobile and 10 or 14
sliderLabel.TextWrapped = true

local valueLabel = Instance.new("TextLabel")
valueLabel.Parent = contentFrames[2]
valueLabel.Size = UDim2.new(0, 48, 0, 28)
valueLabel.Position = UDim2.new(1, -56, 0, 12)
valueLabel.Text = "15.0"
valueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
valueLabel.BackgroundTransparency = 1
valueLabel.Font = Enum.Font.SourceSansSemibold
valueLabel.TextSize = isMobile and 10 or 14
valueLabel.TextWrapped = true

local sliderDragging, sliderValue = false, 15
local function updateSliderValue()
    local sliderRange = sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X
    sliderValue = math.clamp((slider.Position.X.Offset / sliderRange) * 30, 0, 30)
    valueLabel.Text = string.format("%.1f", sliderValue)
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
        slider.Position = UDim2.new(0, math.clamp(mouseX - frameX - (slider.AbsoluteSize.X / 2), 0, sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X), 0, 0)
        updateSliderValue()
    end
end)
slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = false
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        valueLabel.Text = string.format("%.1f", sliderValue)
    end
end)

task.spawn(function()
    while task.wait(1) do
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoid = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChildOfClass("AnimationController")
            if humanoid then
                local success, _ = pcall(function()
                    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                        track:AdjustSpeed(sliderValue)
                    end
                end)
                if not success then
                    warn("Error adjusting animation speed.")
                end
            end
        end
    end
end)

-- FE Scripts
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
    {"HOUSEunbanned", "https://raw.githubusercontent.com/z0nxx/UNBANEHOUSE/refs/heads/main/houseUnbane.lua"}
}

for _, data in ipairs(feScripts) do
    local feButton = Instance.new("TextButton")
    feButton.Parent = feScrollFrame
    feButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    feButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    feButton.Text = data[1]
    feButton.Font = Enum.Font.SourceSansSemibold
    feButton.TextSize = isMobile and 10 or 14
    feButton.TextWrapped = true
    feButton.TextScaled = false
    local feCorner = Instance.new("UICorner")
    feCorner.CornerRadius = UDim.new(0, 8)
    feCorner.Parent = feButton
    local feStroke = Instance.new("UIStroke")
    feStroke.Thickness = 1
    feStroke.Color = Color3.fromRGB(80, 80, 80)
    feStroke.Parent = feButton
    
    addClickSound(feButton)
    feButton.MouseButton1Click:Connect(function()
        loadScript(data[2])
        showNotification(data[1] .. " активирован!")
    end)
    feButton.MouseEnter:Connect(function()
        TweenService:Create(feButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65), Size = isMobile and UDim2.new(0, 144, 0, 44) or UDim2.new(0, 184, 0, 52)}):Play()
    end)
    feButton.MouseLeave:Connect(function()
        TweenService:Create(feButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45), Size = isMobile and UDim2.new(0, 140, 0, 40) or UDim2.new(0, 180, 0, 48)}):Play()
    end)
end

local columns = isMobile and 2 or 3
local rows = math.ceil(#feScripts / columns)
feScrollFrame.CanvasSize = UDim2.new(0, 0, 0, rows * (isMobile and 50 or 60) + (isMobile and 10 or 12))

-- Teleports tab
local teleportFrame = Instance.new("ScrollingFrame")
teleportFrame.Parent = contentFrames[3]
teleportFrame.Size = UDim2.new(1, -16, 1, -16)
teleportFrame.Position = UDim2.new(0, 8, 0, 8)
teleportFrame.BackgroundTransparency = 1
teleportFrame.ScrollBarThickness = 4
teleportFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)
local teleportLayout = Instance.new("UIListLayout")
teleportLayout.Parent = teleportFrame
teleportLayout.Padding = UDim.new(0, 8)
teleportLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local savedPositions = {}
local teleportLocations = {
    {Name = "Спавн", Position = Vector3.new(-22.2000103, 2.4087739, 15.4999981)},
    {Name = "База", Position = Vector3.new(-81.4962692, 17.4849072, -124.388054)},
    {Name = "AFK Зона", Position = Vector3.new(333.547943, 89.6000061, 107.741913), Angle = CFrame.Angles(0, math.pi, 0)}
}

for i = 1, 26 do
    local button = Instance.new("TextButton")
    button.Parent = teleportFrame
    button.Size = UDim2.new(1, -16, 0, isMobile and 36 or 44)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Text = i <= #teleportLocations and teleportLocations[i].Name or (i == 26 and "Сохранить Точку" or "Точка " .. (i - #teleportLocations))
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = isMobile and 10 or 14
    button.TextWrapped = true
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Thickness = 1
    buttonStroke.Color = Color3.fromRGB(80, 80, 80)
    buttonStroke.Parent = button
    
    addClickSound(button)
    button.MouseButton1Click:Connect(function()
        if i <= #teleportLocations then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local cf = CFrame.new(teleportLocations[i].Position)
                if teleportLocations[i].Angle then
                    cf = cf * teleportLocations[i].Angle
                end
                character.HumanoidRootPart.CFrame = cf
                showNotification("Телепорт в " .. teleportLocations[i].Name)
            end
        elseif i == 26 then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                table.insert(savedPositions, character.HumanoidRootPart.Position)
                button.Text = "Сохранено (" .. #savedPositions .. ")"
                showNotification("Точка сохранена!")
            end
        else
            local index = i - #teleportLocations
            if savedPositions[index] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(savedPositions[index])
                showNotification("Телепорт в точку " .. index)
            end
        end
    end)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
end
teleportFrame.CanvasSize = UDim2.new(0, 0, 0, 26 * (isMobile and 44 or 52))

-- Player Finder tab
local playerListFrame = Instance.new("Frame")
playerListFrame.Parent = contentFrames[4]
playerListFrame.Size = isMobile and UDim2.new(0, 120, 1, -16) or UDim2.new(0, 200, 1, -16)
playerListFrame.Position = UDim2.new(0, 8, 0, 8)
playerListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerListFrame.BackgroundTransparency = 0.2
local playerListCorner = Instance.new("UICorner")
playerListCorner.CornerRadius = UDim.new(0, 10)
playerListCorner.Parent = playerListFrame

local playerListTitle = Instance.new("TextLabel")
playerListTitle.Parent = playerListFrame
playerListTitle.Size = UDim2.new(1, 0, 0, isMobile and 32 or 40)
playerListTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
playerListTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
playerListTitle.Text = "Игроки"
playerListTitle.Font = Enum.Font.SourceSansBold
playerListTitle.TextSize = isMobile and 12 or 16
playerListTitle.TextWrapped = true
local playerListTitleCorner = Instance.new("UICorner")
playerListTitleCorner.CornerRadius = UDim.new(0, 10)
playerListTitleCorner.Parent = playerListTitle

local playerListScroll = Instance.new("ScrollingFrame")
playerListScroll.Parent = playerListFrame
playerListScroll.Size = UDim2.new(1, 0, 1, isMobile and -40 or -48)
playerListScroll.Position = UDim2.new(0, 0, 0, isMobile and 32 or 40)
playerListScroll.BackgroundTransparency = 1
playerListScroll.ScrollBarThickness = 4
playerListScroll.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90)
local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Parent = playerListScroll
playerListLayout.Padding = UDim.new(0, 4)

local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Parent = contentFrames[4]
playerInfoFrame.Size = isMobile and UDim2.new(0, 160, 1, -16) or UDim2.new(0, 400, 1, -16)
playerInfoFrame.Position = isMobile and UDim2.new(0, 136, 0, 8) or UDim2.new(0, 216, 0, 8)
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerInfoFrame.BackgroundTransparency = 0.2
local playerInfoCorner = Instance.new("UICorner")
playerInfoCorner.CornerRadius = UDim.new(0, 10)
playerInfoCorner.Parent = playerInfoFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Parent = playerInfoFrame
avatarImage.Size = isMobile and UDim2.new(0, 70, 0, 70) or UDim2.new(0, 120, 0, 120)
avatarImage.Position = UDim2.new(0.5, -(isMobile and 35 or 60), 0, 12)
avatarImage.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 10)
avatarCorner.Parent = avatarImage
local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 1
avatarStroke.Color = Color3.fromRGB(90, 90, 90)
avatarStroke.Parent = avatarImage

local playerInfo = Instance.new("TextLabel")
playerInfo.Parent = playerInfoFrame
playerInfo.Size = isMobile and UDim2.new(1, -16, 0, 100) or UDim2.new(1, -16, 0, 160)
playerInfo.Position = UDim2.new(0, 8, 0, isMobile and 90 or 140)
playerInfo.BackgroundTransparency = 1
playerInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
playerInfo.Font = Enum.Font.SourceSans
playerInfo.TextSize = isMobile and 10 or 14
playerInfo.TextWrapped = true
playerInfo.TextXAlignment = Enum.TextXAlignment.Left
playerInfo.TextYAlignment = Enum.TextYAlignment.Top
playerInfo.Text = "Выберите игрока."
playerInfo.RichText = true

local teleportButton = Instance.new("TextButton")
teleportButton.Parent = playerInfoFrame
teleportButton.Size = isMobile and UDim2.new(0, 90, 0, 32) or UDim2.new(0, 160, 0, 40)
teleportButton.Position = UDim2.new(0.5, -(isMobile and 45 or 80), 1, isMobile and -40 or -48)
teleportButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
teleportButton.TextColor3 = Color3.fromRGB(200, 200, 200)
teleportButton.Text = "Телепорт"
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = isMobile and 10 or 14
teleportButton.TextWrapped = true
teleportButton.Visible = false
local teleportButtonCorner = Instance.new("UICorner")
teleportButtonCorner.CornerRadius = UDim.new(0, 8)
teleportButtonCorner.Parent = teleportButton
addClickSound(teleportButton)
teleportButton.MouseEnter:Connect(function()
    TweenService:Create(teleportButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
end)
teleportButton.MouseLeave:Connect(function()
    TweenService:Create(teleportButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
end)

local selectedPlayer
teleportButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
        playerInfo.Text = playerInfo.Text .. "\n\n<font color='#00ff00'>Телепорт успешен!</font>"
        showNotification("Телепорт к " .. selectedPlayer.Name)
    else
        playerInfo.Text = playerInfo.Text .. "\n\n<font color='#ff5555'>Ошибка: Игрок не в игре!</font>"
    end
end)

-- Theme toggle
local themeToggle = Instance.new("TextButton")
themeToggle.Parent = contentFrames[1]
themeToggle.Size = UDim2.new(0, isMobile and 90 or 100, 0, 36)
themeToggle.Position = UDim2.new(0.5, -(isMobile and 45 or 50), 1, -44)
themeToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
themeToggle.Text = "Светлая Тема"
themeToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
themeToggle.Font = Enum.Font.SourceSansSemibold
themeToggle.TextSize = isMobile and 10 or 14
themeToggle.TextWrapped = true
local themeToggleCorner = Instance.new("UICorner")
themeToggleCorner.CornerRadius = UDim.new(0, 8)
themeToggleCorner.Parent = themeToggle
addClickSound(themeToggle)

local isDark = true
themeToggle.MouseButton1Click:Connect(function()
    isDark = not isDark
    local newMainColor = isDark and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(200, 200, 200)
    local newContentColor = isDark and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(180, 180, 180)
    local newTextColor = isDark and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(30, 30, 30)
    
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {BackgroundColor3 = newMainColor}):Play()
    TweenService:Create(topBar, TweenInfo.new(0.3), {BackgroundColor3 = isDark and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(220, 220, 220)}):Play()
    for _, frame in ipairs(contentFrames) do
        TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundColor3 = newContentColor}):Play()
    end
    for _, btn in ipairs(buttons) do
        TweenService:Create(btn, TweenInfo.new(0.3), {TextColor3 = newTextColor}):Play()
    end
    themeToggle.Text = isDark and "Светлая Тема" or "Тёмная Тема"
end)

-- Player list update
local function updatePlayerList()
    for _, child in ipairs(playerListScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for i, player in ipairs(Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton")
        playerButton.Parent = playerListScroll
        playerButton.Size = UDim2.new(1, -8, 0, isMobile and 32 or 40)
        playerButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        playerButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        playerButton.Text = player.Name
        playerButton.Font = Enum.Font.SourceSansSemibold
        playerButton.TextSize = isMobile and 10 or 14
        playerButton.TextWrapped = true
        local playerButtonCorner = Instance.new("UICorner")
        playerButtonCorner.CornerRadius = UDim.new(0, 6)
        playerButtonCorner.Parent = playerButton
        addClickSound(playerButton)
        playerButton.MouseEnter:Connect(function()
            TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
        end)
        playerButton.MouseLeave:Connect(function()
            TweenService:Create(playerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        end)
        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            local userId = player.UserId
            local creationDate = player.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - player.AccountAge * 86400) or "Неизвестно"
            local displayName = player.DisplayName
            local username = player.Name
            local team = player.Team and player.Team.Name or "Без команды"
            local isInGame = player.Character and "Да" or "Нет"
            local success, thumbnail = pcall(function()
                return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size150x150)
            end)
            avatarImage.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
            playerInfo.Text = string.format(
                "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#cccccc'>@%s</font>\n\nUserID: %d\nСоздан: %s\nКоманда: %s\nВ игре: %s",
                isMobile and 12 or 16,
                displayName,
                username,
                userId,
                creationDate,
                team,
                isInGame
            )
            teleportButton.Visible = true
        end)
    end
    playerListScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * (isMobile and 36 or 44))
end

buttons[4].MouseButton1Click:Connect(updatePlayerList)
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Toggle button with custom image
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, isMobile and 48 or 64, 0, isMobile and 48 or 64)
toggleButton.Position = UDim2.new(0, 16, 0.5, -(isMobile and 24 or 32))
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleButton.Text = ""
toggleButton.BackgroundTransparency = 1
local toggleButtonImage = Instance.new("ImageLabel")
toggleButtonImage.Parent = toggleButton
toggleButtonImage.Size = UDim2.new(1, -4, 1, -4)
toggleButtonImage.Position = UDim2.new(0, 2, 0, 2)
toggleButtonImage.BackgroundTransparency = 1
local success, _ = pcall(function()
    toggleButtonImage.Image = "rbxassetid://15771263443"
end)
if not success then
    warn("Invalid image ID: 15771263443. Using placeholder.")
    toggleButtonImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
end
toggleButtonImage.ScaleType = Enum.ScaleType.Fit
local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(1, 0)
toggleButtonCorner.Parent = toggleButton
local toggleButtonImageCorner = Instance.new("UICorner")
toggleButtonImageCorner.CornerRadius = UDim.new(1, 0)
toggleButtonImageCorner.Parent = toggleButtonImage
local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 1
toggleStroke.Color = Color3.fromRGB(90, 90, 90)
toggleStroke.Parent = toggleButton
addClickSound(toggleButton)

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

-- Chat commands
LocalPlayer.Chatted:Connect(function(msg)
    if msg == "!fly" then
        loadScript("https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua")
        showNotification("Fly активирован!")
    elseif msg == "!r6" then
        loadScript("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua")
        showNotification("R6 активирован!")
    end
end)

-- Animations
local isOpen, isFirstLaunch = false, true
local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 1.5, 0)})
local blurTweenIn = TweenService:Create(blurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 12})
local blurTweenOut = TweenService:Create(blurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0})

local function playFirstLaunchAnimation()
    mainFrame.Visible = true
    mainFrame.Size = isMobile and UDim2.new(0, 40, 0, 40) or UDim2.new(0, 80, 0, 80)
    mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2)
    local launchTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = mainFrameSize, Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
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
        closeTween.Completed:Connect(function()
            blurEffect.Enabled = false
            mainFrame.Visible = false
        end)
        isOpen = false
    else
        mainFrame.Visible = true
        openTween:Play()
        blurTweenIn:Play()
        isOpen = true
    end
end)
toggleButton.MouseEnter:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
end)
toggleButton.MouseLeave:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
end)

-- Auto-launch with delay
task.spawn(function()
    tryLoadScripts() -- Load external scripts
    task.wait(5)
    if isFirstLaunch then
        playFirstLaunchAnimation()
    end
end)
