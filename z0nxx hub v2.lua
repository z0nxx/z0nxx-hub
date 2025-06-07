local firstScript = game:HttpGet("https://raw.githubusercontent.com/z0nxx/zastavca/refs/heads/main/zastavca.lua")
loadstring(firstScript)()
wait(10)

local SoundService, Players, TweenService, UserInputService = game:GetService("SoundService"), game:GetService("Players"), game:GetService("TweenService"), game:GetService("UserInputService")
local LocalPlayer, isMobile = Players.LocalPlayer, UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local startSound, clickSound = Instance.new("Sound", SoundService), Instance.new("Sound", SoundService)
startSound.SoundId, clickSound.SoundId = "rbxassetid://95439852376197", "rbxassetid://80335956916443"

game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text = "z0nxx hub", Color = Color3.fromRGB(255, 255, 255), Font = Enum.Font.SourceSansBold, TextSize = 18})
startSound:Play()

pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/image-script/refs/heads/main/image.lua"))() end)
wait(7)

local screenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui) screenGui.ResetOnSpawn = false
local mainFrameSize = isMobile and UDim2.new(0, 400, 0, 300) or UDim2.new(0, 650, 0, 450)
local mainFrame = Instance.new("Frame", screenGui) 
mainFrame.Size, mainFrame.Position, mainFrame.BackgroundColor3, mainFrame.BorderSizePixel, mainFrame.Visible = mainFrameSize, UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2), Color3.fromRGB(30, 30, 30), 0, false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local uiStroke = Instance.new("UIStroke", mainFrame) uiStroke.Thickness, uiStroke.Color, uiStroke.Transparency = 2, Color3.fromRGB(50, 50, 50), 0.8

local dragBar = Instance.new("Frame", mainFrame) 
dragBar.Size, dragBar.BackgroundColor3, dragBar.BorderSizePixel = UDim2.new(1, 0, 0, isMobile and 40 or 60), Color3.fromRGB(40, 40, 40), 0
Instance.new("UICorner", dragBar).CornerRadius = UDim.new(0, 12)

local dragging, dragStart, startPos
dragBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging, dragStart, startPos = true, input.Position, mainFrame.Position end end)
dragBar.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
dragBar.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

local function addClickSound(button) button.MouseButton1Click:Connect(function() clickSound:Play() end) end

-- Create notification frame for FE Scripts
local notificationFrame = Instance.new("Frame", screenGui)
notificationFrame.Size = UDim2.new(0, isMobile and 200 or 300, 0, isMobile and 40 or 50)
notificationFrame.Position = UDim2.new(0.5, -(isMobile and 100 or 150), 1, -60)
notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
Instance.new("UICorner", notificationFrame).CornerRadius = UDim.new(0, 8)
local notificationStroke = Instance.new("UIStroke", notificationFrame)
notificationStroke.Thickness, notificationStroke.Color = 1, Color3.fromRGB(200, 200, 200)

local notificationLabel = Instance.new("TextLabel", notificationFrame)
notificationLabel.Size = UDim2.new(1, 0, 1, 0)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = "Скрипт активирован!"
notificationLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
notificationLabel.Font = Enum.Font.SourceSansBold
notificationLabel.TextSize = isMobile and 14 or 18
notificationLabel.TextTransparency = 0

local notificationInTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(isMobile and 100 or 150), 1, -100)})
local notificationOutTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -(isMobile and 100 or 150), 1, -60)})

local function showNotification()
    notificationFrame.Visible = true
    notificationInTween:Play()
    wait(2)
    notificationOutTween:Play()
    notificationOutTween.Completed:Connect(function()
        notificationFrame.Visible = false
    end)
end

local buttons, contentFrames = {}, {}
local icons = {
    "rbxassetid://7072721682", -- User icon for About Creator
    "rbxassetid://7072719338", -- Script icon for FE Scripts
    "rbxassetid://7072725347", -- Teleport icon for Телепорты
    "rbxassetid://7072718346"  -- Search icon for Player Finder
}

for i = 1, 4 do
    local button = Instance.new("TextButton", dragBar)
    button.Size, button.Position, button.BackgroundColor3, button.TextColor3, button.Text, button.Font, button.TextSize, button.BorderSizePixel = isMobile and UDim2.new(0, 90, 0, 30) or UDim2.new(0, 150, 0, 40), UDim2.new(0, 5 + (i-1)*(isMobile and 95 or 155), 0, 5), Color3.fromRGB(50, 50, 50), Color3.fromRGB(200, 200, 200), i == 1 and "About Creator" or i == 2 and "FE Scripts" or i == 3 and "Телепорты" or "Player Finder", Enum.Font.SourceSansSemibold, isMobile and 14 or 18, 0
    addClickSound(button)
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    button.MouseEnter:Connect(function() button.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
    button.MouseLeave:Connect(function() button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
    
    local icon = Instance.new("ImageLabel", button)
    icon.Size, icon.Position, icon.BackgroundTransparency, icon.Image = UDim2.new(0, 20, 0, 20), UDim2.new(0, 10, 0.5, -10), 1, icons[i]
    
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size, contentFrame.Position, contentFrame.BackgroundColor3, contentFrame.BorderSizePixel, contentFrame.Visible = UDim2.new(1, -20, 0, isMobile and 250 or 380), UDim2.new(0, 10, 0, isMobile and 40 or 60), Color3.fromRGB(35, 35, 35), 0, i == 1
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)
    
    table.insert(buttons, button)
    table.insert(contentFrames, contentFrame)
end

local creatorScroll = Instance.new("ScrollingFrame", contentFrames[1])
creatorScroll.Size, creatorScroll.BackgroundTransparency, creatorScroll.ScrollBarThickness, creatorScroll.ScrollBarImageColor3 = UDim2.new(1, 0, 1, 0), 1, 8, Color3.fromRGB(200, 200, 200)
Instance.new("UIListLayout", creatorScroll).Padding = UDim.new(0, 15)

for i, userData in pairs({{2316299341, "z0nxx", "Создатель скрипта", "• Опыт работы: 3 года\n• Дата создания скрипта: 23 марта 2025\n• Версия скрипта: 2.0", "• Discord: z0nxx\n• Roblox профиль: <font color='#ffffff'>https://www.roblox.com/users/2316299341/profile</font>", "Создатель этого удивительного хаба!"}, {4254815427, "Lil_darkie", "@Popabebripeach - Помощник и тестер", "• Роль: Тестирование на мобильных устройствах\n• Вклад: Помощь в разработке и отладке", "Lil_darkie активно участвовал в тестировании и помог сделать скрипт удобным для мобильных игроков.", "Спасибо за помощь в проекте!"}}) do
    local frame = Instance.new("Frame", creatorScroll)
    frame.Size, frame.BackgroundColor3, frame.BorderSizePixel = UDim2.new(1, -20, 0, isMobile and 250 or 340), Color3.fromRGB(40, 40, 40), 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local image = Instance.new("ImageLabel", frame)
    image.Size, image.Position, image.BackgroundColor3 = isMobile and UDim2.new(0, 80, 0, 80) or UDim2.new(0, 180, 0, 180), UDim2.new(0, 20, 0, 20), Color3.fromRGB(25, 25, 25)
    local success, thumbnail = pcall(function() return Players:GetUserThumbnailAsync(userData[1], Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size180x180) end)
    image.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Instance.new("UICorner", image).CornerRadius = UDim.new(0, 10)
    local imgStroke = Instance.new("UIStroke", image) imgStroke.Thickness, imgStroke.Color = 2, Color3.fromRGB(200, 200, 200)
    
    local info = Instance.new("TextLabel", frame)
    info.Size, info.Position, info.BackgroundColor3, info.TextColor3, info.Font, info.TextSize, info.TextWrapped, info.TextXAlignment = isMobile and UDim2.new(0, 260, 0, 210) or UDim2.new(0, 400, 0, 300), UDim2.new(0, isMobile and 110 or 220, 0, 20), Color3.fromRGB(40, 40, 40), Color3.fromRGB(220, 220, 220), Enum.Font.SourceSans, isMobile and 14 or 18, true, Enum.TextXAlignment.Left
    info.Text = string.format("<font size='24' face='SourceSansBold'><b>%s</b></font>\n<font color='#d3d3d3'>%s</font>\n\n<font size='16' color='#d3d3d3'><b>Информация:</b></font>\n%s\n\n<font size='16' color='#d3d3d3'><b>%s:</b></font>\n%s\n\n<font color='#d3d3d3'>%s</font>", userData[2], userData[3], userData[4], i == 1 and "Контакты" or "О помощнике", userData[5], userData[6])
    info.RichText = true
    Instance.new("UICorner", info).CornerRadius = UDim.new(0, 10)
    local padding = Instance.new("UIPadding", info) padding.PaddingLeft, padding.PaddingTop = UDim.new(0, 15), UDim.new(0, 15)
end
creatorScroll.CanvasSize = UDim2.new(0, 0, 0, (isMobile and 250 or 340) * 2 + 30)

-- Вторая вкладка (FE Scripts) с прокруткой и слайдером
local feScrollFrame = Instance.new("ScrollingFrame", contentFrames[2])
feScrollFrame.Size, feScrollFrame.Position, feScrollFrame.BackgroundTransparency, feScrollFrame.ScrollBarThickness, feScrollFrame.ScrollBarImageColor3 = UDim2.new(1, -20, 1, -60), UDim2.new(0, 10, 0, 50), 1, 8, Color3.fromRGB(200, 200, 200)

-- Use UIGridLayout instead of UIListLayout
local gridLayout = Instance.new("UIGridLayout", feScrollFrame)
gridLayout.CellSize = isMobile and UDim2.new(0, 160, 0, 40) or UDim2.new(0, 190, 0, 50)
gridLayout.CellPadding = isMobile and UDim2.new(0, 10, 0, 10) or UDim2.new(0, 15, 0, 15)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.FillDirection = Enum.FillDirection.Horizontal
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Слайдер скорости анимаций
local sliderFrame = Instance.new("Frame", contentFrames[2])
sliderFrame.Size, sliderFrame.Position, sliderFrame.BackgroundColor3 = isMobile and UDim2.new(0, 260, 0, 20) or UDim2.new(0, 450, 0, 25), UDim2.new(0.5, -(isMobile and 130 or 225), 0, 10), Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 10)

local slider = Instance.new("TextButton", sliderFrame)
slider.Size, slider.Position, slider.BackgroundColor3, slider.Text, slider.BorderSizePixel = UDim2.new(0, isMobile and 30 or 40, 0, isMobile and 20 or 25), UDim2.new(0, isMobile and 115 or 205, 0, 0), Color3.fromRGB(200, 200, 200), "", 0
Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 10)

local sliderDragging, sliderValue = false, 15
local function updateSliderValue() local sliderRange = sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X sliderValue = math.clamp((slider.Position.X.Offset / sliderRange) * 30, 0, 30) end
local function updateSliderPosition(input) if sliderDragging then local mouseX, frameX = input.Position.X, sliderFrame.AbsolutePosition.X slider.Position = UDim2.new(0, math.clamp(mouseX - frameX - (slider.AbsoluteSize.X / 2), 0, sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X), 0, 0) updateSliderValue() end end

slider.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliderDragging = true end end)
slider.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then updateSliderPosition(input) end end)
slider.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliderDragging = false end end)

local sliderLabel = Instance.new("TextLabel", contentFrames[2]) 
sliderLabel.Size, sliderLabel.Position, sliderLabel.Text, sliderLabel.TextColor3, sliderLabel.BackgroundTransparency, sliderLabel.Font, sliderLabel.TextSize = UDim2.new(0, isMobile and 80 or 100, 0, isMobile and 20 or 25), UDim2.new(0, 10, 0, 10), "Скорость анимаций:", Color3.fromRGB(220, 220, 220), 1, Enum.Font.SourceSansSemibold, isMobile and 12 or 16

local valueLabel = Instance.new("TextLabel", contentFrames[2]) 
valueLabel.Size, valueLabel.Position, valueLabel.Text, valueLabel.TextColor3, valueLabel.BackgroundTransparency, valueLabel.Font, valueLabel.TextSize = UDim2.new(0, 50, 0, isMobile and 20 or 25), UDim2.new(1, -60, 0, 10), tostring(sliderValue), Color3.fromRGB(200, 200, 200), 1, Enum.Font.SourceSansSemibold, isMobile and 12 or 16

spawn(function() while wait(0.1) do valueLabel.Text = string.format("%.1f", sliderValue) end end)
spawn(function() local player = LocalPlayer while task.wait() do local character = player.Character or player.CharacterAdded:Wait() local humanoid = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChildOfClass("AnimationController") if humanoid then for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do track:AdjustSpeed(sliderValue) end end end end)

-- Кнопки FE Scripts
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
    {"ToolEditor", "https://raw.githubusercontent.com/z0nxx/risovalka-script/refs/heads/main/risovalka.lua"}
}

for i, data in pairs(feScripts) do
    local feButton = Instance.new("TextButton", feScrollFrame)
    feButton.Size = UDim2.new(0, isMobile and 160 or 190, 0, isMobile and 40 or 50) -- Size set by UIGridLayout
    feButton.BackgroundColor3, feButton.TextColor3, feButton.Text, feButton.Font, feButton.TextSize, feButton.BorderSizePixel = Color3.fromRGB(50, 50, 50), Color3.fromRGB(200, 200, 200), data[1], Enum.Font.SourceSansSemibold, isMobile and 12 or 16, 0
    feButton.TextWrapped = true
    feButton.TextScaled = false
    addClickSound(feButton)
    feButton.MouseButton1Click:Connect(function() 
        pcall(function() loadstring(game:HttpGet(data[2], true))() end)
        showNotification()
    end)
    Instance.new("UICorner", feButton).CornerRadius = UDim.new(0, 8)
    local feStroke = Instance.new("UIStroke", feButton) feStroke.Thickness, feStroke.Color = 1, Color3.fromRGB(30, 30, 30)
    feButton.MouseEnter:Connect(function() 
        feButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) 
        feButton.TextColor3 = Color3.fromRGB(0, 0, 0) 
        TweenService:Create(feButton, TweenInfo.new(0.2), {Size = UDim2.new(0, isMobile and 165 or 195, 0, isMobile and 42 or 52)}):Play() 
    end)
    feButton.MouseLeave:Connect(function() 
        feButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
        feButton.TextColor3 = Color3.fromRGB(200, 200, 200) 
        TweenService:Create(feButton, TweenInfo.new(0.2), {Size = UDim2.new(0, isMobile and 160 or 190, 0, isMobile and 40 or 50)}):Play() 
    end)
end

-- Calculate CanvasSize for grid layout
local columns = isMobile and 2 or 3 -- 2 columns on mobile, 3 on desktop
local rows = math.ceil(#feScripts / columns)
local cellHeight = isMobile and 40 or 50
local cellPaddingY = isMobile and 10 or 15
feScrollFrame.CanvasSize = UDim2.new(0, 0, 0, rows * (cellHeight + cellPaddingY) + cellPaddingY)

local scrollFrame = Instance.new("ScrollingFrame", contentFrames[3])
scrollFrame.Size, scrollFrame.Position, scrollFrame.BackgroundTransparency, scrollFrame.ScrollBarThickness, scrollFrame.ScrollBarImageColor3 = UDim2.new(1, -20, 1, -20), UDim2.new(0, 10, 0, 10), 1, 8, Color3.fromRGB(200, 200, 200)

local savedPositions = {}
for i = 1, 26 do
    local scrollButton = Instance.new("TextButton", scrollFrame)
    scrollButton.Size, scrollButton.Position, scrollButton.BackgroundColor3, scrollButton.TextColor3, scrollButton.Text, scrollButton.Font, scrollButton.TextSize, scrollButton.BorderSizePixel = UDim2.new(1, -20, 0, isMobile and 30 or 40), UDim2.new(0, 10, 0, (i-1)*(isMobile and 35 or 50)), Color3.fromRGB(50, 50, 50), Color3.fromRGB(200, 200, 200), i == 1 and "Спавн" or i == 2 and "База" or i == 3 and "AFK zone" or i == 26 and "Сохранить точку" or "Место " .. (i-3), Enum.Font.SourceSansSemibold, isMobile and 12 or 18, 0
    addClickSound(scrollButton)
    if i <= 3 then 
        scrollButton.MouseButton1Click:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(i == 1 and Vector3.new(-22.2000103, 2.4087739, 15.4999981) or i == 2 and Vector3.new(-81.4962692, 17.4849072, -124.388054) or Vector3.new(333.547943, 89.6000061, 107.741913)) * (i == 3 and CFrame.Angles(0, math.pi, 0) or CFrame.new()) end end)
    elseif i == 26 then
        scrollButton.MouseButton1Click:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then table.insert(savedPositions, LocalPlayer.Character.HumanoidRootPart.Position) scrollButton.Text = "Сохранено " .. #savedPositions end end)
    elseif i > 3 and i < 26 then
        scrollButton.MouseButton1Click:Connect(function() if savedPositions[i-3] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(savedPositions[i-3]) end end)
    end
    Instance.new("UICorner", scrollButton).CornerRadius = UDim.new(0, 8)
    local scrollStroke = Instance.new("UIStroke", scrollButton) scrollStroke.Thickness, scrollStroke.Color = 1, Color3.fromRGB(30, 30, 30)
    scrollButton.MouseEnter:Connect(function() scrollButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) scrollButton.TextColor3 = Color3.fromRGB(0, 0, 0) end)
    scrollButton.MouseLeave:Connect(function() scrollButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) scrollButton.TextColor3 = Color3.fromRGB(200, 200, 200) end)
end
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 26 * (isMobile and 35 or 50))

local playerListFrame = Instance.new("Frame", contentFrames[4]) 
playerListFrame.Size, playerListFrame.Position, playerListFrame.BackgroundColor3 = isMobile and UDim2.new(0, 120, 1, -20) or UDim2.new(0, 200, 1, -20), UDim2.new(0, 10, 0, 10), Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 8)

local playerListTitle = Instance.new("TextLabel", playerListFrame) 
playerListTitle.Size, playerListTitle.BackgroundColor3, playerListTitle.TextColor3, playerListTitle.Text, playerListTitle.Font, playerListTitle.TextSize = UDim2.new(1, 0, 0, isMobile and 30 or 40), Color3.fromRGB(50, 50, 50), Color3.fromRGB(220, 220, 220), "Игроки в игре", Enum.Font.SourceSansSemibold, isMobile and 12 or 18
Instance.new("UICorner", playerListTitle).CornerRadius = UDim.new(0, 8)

local playerListScroll = Instance.new("ScrollingFrame", playerListFrame) 
playerListScroll.Size, playerListScroll.Position, playerListScroll.BackgroundTransparency, playerListScroll.ScrollBarThickness, playerListScroll.ScrollBarImageColor3 = UDim2.new(1, 0, 1, isMobile and -40 or -50), UDim2.new(0, 0, 0, isMobile and 30 or 40), 1, 6, Color3.fromRGB(200, 200, 200)
Instance.new("UIListLayout", playerListScroll).Padding = UDim.new(0, 5)

local playerInfoFrame = Instance.new("Frame", contentFrames[4]) 
playerInfoFrame.Size, playerInfoFrame.Position, playerInfoFrame.BackgroundColor3 = isMobile and UDim2.new(0, 250, 1, -20) or UDim2.new(0, 400, 1, -20), UDim2.new(0, isMobile and 140 or 220, 0, 10), Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", playerInfoFrame).CornerRadius = UDim.new(0, 8)

local avatarImage = Instance.new("ImageLabel", playerInfoFrame) 
avatarImage.Size, avatarImage.Position, avatarImage.BackgroundColor3, avatarImage.Image = isMobile and UDim2.new(0, 80, 0, 80) or UDim2.new(0, 150, 0, 150), UDim2.new(0.5, -(isMobile and 40 or 75), 0, 20), Color3.fromRGB(30, 30, 30), "rbxasset://textures/ui/GuiImagePlaceholder.png"
Instance.new("UICorner", avatarImage).CornerRadius = UDim.new(0, 10)
local avatarStroke = Instance.new("UIStroke", avatarImage) avatarStroke.Thickness, avatarStroke.Color = 2, Color3.fromRGB(200, 200, 200)

local playerInfo = Instance.new("TextLabel", playerInfoFrame) 
playerInfo.Size, playerInfo.Position, playerInfo.BackgroundColor3, playerInfo.TextColor3, playerInfo.Font, playerInfo.TextSize, playerInfo.TextWrapped, playerInfo.TextXAlignment, playerInfo.TextYAlignment, playerInfo.Text = isMobile and UDim2.new(0, 230, 0, 120) or UDim2.new(0, 380, 0, 180), UDim2.new(0, 10, 0, isMobile and 110 or 190), Color3.fromRGB(30, 30, 30), Color3.fromRGB(220, 220, 220), Enum.Font.SourceSans, isMobile and 12 or 16, true, Enum.TextXAlignment.Left, Enum.TextYAlignment.Top, "Выберите игрока из списка для просмотра информации."
Instance.new("UICorner", playerInfo).CornerRadius = UDim.new(0, 8)
local infoPadding = Instance.new("UIPadding", playerInfo) infoPadding.PaddingLeft, infoPadding.PaddingTop = UDim.new(0, 10), UDim.new(0, 10)

local teleportButton = Instance.new("TextButton", playerInfoFrame) 
teleportButton.Size, teleportButton.Position, teleportButton.BackgroundColor3, teleportButton.TextColor3, teleportButton.Text, teleportButton.Font, teleportButton.TextSize, teleportButton.BorderSizePixel, teleportButton.Visible = isMobile and UDim2.new(0, 100, 0, 30) or UDim2.new(0, 200, 0, 40), UDim2.new(0.5, -(isMobile and 50 or 100), 0, isMobile and 200 or 300), Color3.fromRGB(200, 200, 200), Color3.fromRGB(0, 0, 0), "Телепортироваться", Enum.Font.SourceSansBold, isMobile and 12 or 18, 0, false
addClickSound(teleportButton)
Instance.new("UICorner", teleportButton).CornerRadius = UDim.new(0, 8)
teleportButton.MouseEnter:Connect(function() teleportButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220) end)
teleportButton.MouseLeave:Connect(function() teleportButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) end)

local selectedPlayer
teleportButton.MouseButton1Click:Connect(function() 
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame 
        playerInfo.Text = playerInfo.Text .. "\n\n<font color='#ffffff'>Успешно телепортирован к игроку!</font>" 
    else 
        playerInfo.Text = playerInfo.Text .. "\n\n<font color='#ff5555'>Ошибка: Игрок не в игре!</font>" 
    end 
end)

local themeToggle = Instance.new("TextButton", contentFrames[1])
themeToggle.Size, themeToggle.Position, themeToggle.BackgroundColor3, themeToggle.Text, themeToggle.TextColor3, themeToggle.Font, themeToggle.TextSize, themeToggle.BorderSizePixel = UDim2.new(0, 90, 0, 30), UDim2.new(0.5, -45, 0, isMobile and 220 or 340), Color3.fromRGB(50, 50, 50), "Светлая тема", Color3.fromRGB(200, 200, 200), Enum.Font.SourceSansSemibold, 14, 0
addClickSound(themeToggle)
Instance.new("UICorner", themeToggle).CornerRadius = UDim.new(0, 8)
local isDark = true
themeToggle.MouseButton1Click:Connect(function() 
    isDark = not isDark
    mainFrame.BackgroundColor3 = isDark and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(200, 200, 200)
    dragBar.BackgroundColor3 = isDark and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(220, 220, 220)
    for _, frame in pairs(contentFrames) do frame.BackgroundColor3 = isDark and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(180, 180, 180) end
    themeToggle.Text = isDark and "Светлая тема" or "Тёмная тема"
end)

local function updatePlayerList()
    for _, child in ipairs(playerListScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    for i, player in ipairs(Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton", playerListScroll)
        playerButton.Size, playerButton.Position, playerButton.BackgroundColor3, playerButton.TextColor3, playerButton.Text, playerButton.Font, playerButton.TextSize, playerButton.BorderSizePixel = UDim2.new(1, -10, 0, isMobile and 30 or 40), UDim2.new(0, 5, 0, (i-1)*(isMobile and 35 or 45)), Color3.fromRGB(50, 50, 50), Color3.fromRGB(220, 220, 220), player.Name, Enum.Font.SourceSansSemibold, isMobile and 12 or 16, 0
        addClickSound(playerButton)
        Instance.new("UICorner", playerButton).CornerRadius = UDim.new(0, 6)
        playerButton.MouseEnter:Connect(function() playerButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
        playerButton.MouseLeave:Connect(function() playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            local userId, creationDate, displayName, username, team, isInGame = player.UserId, player.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - player.AccountAge * 86400) or "Неизвестно", player.DisplayName, player.Name, player.Team and player.Team.Name or "Нет команды", player.Character and "Да" or "Нет"
            local success, thumbnail = pcall(function() return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size150x150) end)
            avatarImage.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
            playerInfo.Text = string.format("<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#d3d3d3'>@%s</font>\n\n<font color='#d3d3d3'>UserID:</font> %d\n<font color='#d3d3d3'>Дата создания:</font> %s\n<font color='#d3d3d3'>Команда:</font> %s\n<font color='#d3d3d3'>В игре:</font> %s", isMobile and 14 or 18, displayName, username, userId, creationDate, team, isInGame)
            playerInfo.RichText = true
            teleportButton.Visible = true
        end)
    end
    playerListScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * (isMobile and 35 or 45))
end

buttons[4].MouseButton1Click:Connect(updatePlayerList)
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

for i, button in pairs(buttons) do button.MouseButton1Click:Connect(function() for j, frame in pairs(contentFrames) do frame.Visible = j == i end end) end

local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size, toggleButton.Position, toggleButton.BackgroundColor3, toggleButton.Text, toggleButton.TextColor3, toggleButton.Font, toggleButton.TextSize, toggleButton.BorderSizePixel = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 50 or 60), UDim2.new(0, 20, 0.5, -toggleButton.Size.Y.Offset / 2), Color3.fromRGB(50, 50, 50), ">", Color3.fromRGB(200, 200, 200), Enum.Font.SourceSansBold, isMobile and 20 or 24, 0
addClickSound(toggleButton)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new("UIStroke", toggleButton) toggleStroke.Thickness, toggleStroke.Color = 2, Color3.fromRGB(200, 200, 200)

local btnDragging, btnDragStart, btnStartPos
toggleButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then btnDragging, btnDragStart, btnStartPos = true, input.Position, toggleButton.Position end end)
toggleButton.InputChanged:Connect(function(input) if btnDragging and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - btnDragStart toggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y) end end)
toggleButton.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then btnDragging = false end end)

LocalPlayer.Chatted:Connect(function(msg)
    if msg == "!fly" then loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua", true))() end
    if msg == "!r6" then loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", true))() end
end)

local isOpen, isFirstLaunch = false, true
local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, 800)})

local function playFirstLaunchAnimation()
    mainFrame.Visible, mainFrame.Size, mainFrame.Position = true, isMobile and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 100, 0, 100), UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2)
    local launchTween = TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = mainFrameSize, Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
    launchTween:Play()
    launchTween.Completed:Wait()
    isFirstLaunch, isOpen, toggleButton.Text = false, true, "<"
end

toggleButton.MouseButton1Click:Connect(function()
    if isFirstLaunch then playFirstLaunchAnimation()
    elseif isOpen then closeTween:Play() closeTween.Completed:Wait() toggleButton.Text, isOpen = ">", false
    else mainFrame.Visible = true openTween:Play() openTween.Completed:Wait() toggleButton.Text, isOpen = "<", true end
end)
toggleButton.MouseEnter:Connect(function() toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
toggleButton.MouseLeave:Connect(function() toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)

spawn(function() wait(7) if isFirstLaunch then playFirstLaunchAnimation() end end)
