-- Загрузка первого скрипта
local firstScript = game:HttpGet("https://raw.githubusercontent.com/z0nxx/zastavca/refs/heads/main/zastavca.lua")
loadstring(firstScript)()

-- Ожидание завершения первого скрипта (предполагаем, что он завершится через некоторое время)
wait(10) -- Увеличьте это время, если первый скрипт работает дольше

-- Основной GUI скрипт
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Звуки
local startSound = Instance.new("Sound", SoundService) startSound.SoundId = "rbxassetid://95439852376197"
local clickSound = Instance.new("Sound", SoundService) clickSound.SoundId = "rbxassetid://80335956916443"

-- Сообщение в чат и запуск звука
game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text = "z0nxx hub", Color = Color3.fromRGB(255, 255, 255), Font = Enum.Font.SourceSansBold, TextSize = 18})
startSound:Play()

-- Загрузка внешнего скрипта
pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/image-script/refs/heads/main/image.lua"))() end)
wait(7)

-- Основной GUI
local screenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui) screenGui.ResetOnSpawn = false
local mainFrameSize = isMobile and UDim2.new(0, 400, 0, 300) or UDim2.new(0, 650, 0, 450)
local mainFrame = Instance.new("Frame", screenGui) 
mainFrame.Size = mainFrameSize 
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
mainFrame.BorderSizePixel = 0 
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local uiStroke = Instance.new("UIStroke", mainFrame) uiStroke.Thickness = 2 uiStroke.Color = Color3.fromRGB(50, 50, 50) uiStroke.Transparency = 0.8

-- DragBar
local dragBar = Instance.new("Frame", mainFrame) 
dragBar.Size = UDim2.new(1, 0, 0, isMobile and 40 or 60) 
dragBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
dragBar.BorderSizePixel = 0
Instance.new("UICorner", dragBar).CornerRadius = UDim.new(0, 12)

local dragging, dragStart, startPos
dragBar.InputBegan:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
        dragging = true 
        dragStart = input.Position 
        startPos = mainFrame.Position 
    end 
end)
dragBar.InputChanged:Connect(function(input) 
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
        local delta = input.Position - dragStart 
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) 
    end 
end)
dragBar.InputEnded:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
        dragging = false 
    end 
end)

-- Функция добавления звука клика
local function addClickSound(button) 
    button.MouseButton1Click:Connect(function() 
        clickSound:Play() 
    end) 
end

-- Вкладки
local buttons, contentFrames = {}, {}
for i = 1, 5 do
    local button = Instance.new("TextButton", dragBar)
    button.Size = isMobile and UDim2.new(0, 90, 0, 30) or UDim2.new(0, 150, 0, 40)
    button.Position = UDim2.new(0, 5 + (i-1)*(isMobile and 95 or 155), 0, 5)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Text = i == 1 and "About Creator" or i == 2 and "FE Scripts" or i == 3 and "Телепорты" or i == 4 and "Player Finder" or "❤"
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = isMobile and 14 or 18
    button.BorderSizePixel = 0
    addClickSound(button)
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    button.MouseEnter:Connect(function() button.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
    button.MouseLeave:Connect(function() button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
    
    local contentFrame = Instance.new("Frame", mainFrame)
    contentFrame.Size = UDim2.new(1, -20, 0, isMobile and 250 or 380)
    contentFrame.Position = UDim2.new(0, 10, 0, isMobile and 40 or 60)
    contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    contentFrame.BorderSizePixel = 0
    contentFrame.Visible = i == 1
    Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)
    
    table.insert(buttons, button)
    table.insert(contentFrames, contentFrame)
end

-- Вкладка "About Creator"
local creatorScroll = Instance.new("ScrollingFrame", contentFrames[1])
creatorScroll.Size = UDim2.new(1, 0, 1, 0)
creatorScroll.BackgroundTransparency = 1
creatorScroll.ScrollBarThickness = 8
creatorScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
Instance.new("UIListLayout", creatorScroll).Padding = UDim.new(0, 15)

for i, userData in pairs({
    {2316299341, "z0nxx", "Создатель скрипта", "• Опыт работы: 3 года\n• Дата создания скрипта: 23 марта 2025\n• Версия скрипта: 2.0", "• Discord: z0nxx\n• Roblox профиль: <font color='#ffffff'>https://www.roblox.com/users/2316299341/profile</font>", "Создатель этого удивительного хаба!"},
    {4254815427, "Lil_darkie", "@Popabebribeach - Помощник и тестер", "• Роль: Тестирование на мобильных устройствах\n• Вклад: Помощь в разработке и отладке", "Lil_darkie активно участвовал в тестировании и помог сделать скрипт удобным для мобильных игроков.", "Спасибо за помощь в проекте!"}
}) do
    local frame = Instance.new("Frame", creatorScroll)
    frame.Size = UDim2.new(1, -20, 0, isMobile and 250 or 340)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local image = Instance.new("ImageLabel", frame)
    image.Size = isMobile and UDim2.new(0, 80, 0, 80) or UDim2.new(0, 180, 0, 180)
    image.Position = UDim2.new(0, 20, 0, 20)
    image.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    local success, thumbnail = pcall(function() return Players:GetUserThumbnailAsync(userData[1], Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size180x180) end)
    image.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Instance.new("UICorner", image).CornerRadius = UDim.new(0, 10)
    local imgStroke = Instance.new("UIStroke", image) imgStroke.Thickness = 2 imgStroke.Color = Color3.fromRGB(200, 200, 200)
    
    local info = Instance.new("TextLabel", frame)
    info.Size = isMobile and UDim2.new(0, 260, 0, 210) or UDim2.new(0, 400, 0, 300)
    info.Position = UDim2.new(0, isMobile and 110 or 220, 0, 20)
    info.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    info.TextColor3 = Color3.fromRGB(220, 220, 220)
    info.Font = Enum.Font.SourceSans
    info.TextSize = isMobile and 14 or 18
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Text = string.format("<font size='24' face='SourceSansBold'><b>%s</b></font>\n<font color='#d3d3d3'>%s</font>\n\n<font size='16' color='#d3d3d3'><b>Информация:</b></font>\n%s\n\n<font size='16' color='#d3d3d3'><b>%s:</b></font>\n%s\n\n<font color='#d3d3d3'>%s</font>", 
        userData[2], userData[3], userData[4], i == 1 and "Контакты" or "О помощнике", userData[5], userData[6])
    info.RichText = true
    Instance.new("UICorner", info).CornerRadius = UDim.new(0, 10)
    local padding = Instance.new("UIPadding", info) padding.PaddingLeft = UDim.new(0, 15) padding.PaddingTop = UDim.new(0, 15)
end
creatorScroll.CanvasSize = UDim2.new(0, 0, 0, (isMobile and 250 or 340) * 2 + 30)

-- Вкладка "FE Scripts"
local sliderFrame = Instance.new("Frame", contentFrames[2])
sliderFrame.Size = isMobile and UDim2.new(0, 260, 0, 20) or UDim2.new(0, 450, 0, 25)
sliderFrame.Position = UDim2.new(0.5, -sliderFrame.Size.X.Offset / 2, 0, 10)
sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 10)

local slider = Instance.new("TextButton", sliderFrame)
slider.Size = UDim2.new(0, isMobile and 30 or 40, 0, isMobile and 20 or 25)
slider.Position = UDim2.new(0, isMobile and 115 or 205, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
slider.Text = ""
slider.BorderSizePixel = 0
Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 10)

local sliderDragging, sliderValue = false, 15
local function updateSliderValue() 
    local sliderRange = sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X 
    sliderValue = math.clamp((slider.Position.X.Offset / sliderRange) * 30, 0, 30) 
end
local function updateSliderPosition(input) 
    if sliderDragging then 
        local mouseX = input.Position.X 
        local frameX = sliderFrame.AbsolutePosition.X 
        slider.Position = UDim2.new(0, math.clamp(mouseX - frameX - (slider.AbsoluteSize.X / 2), 0, sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X), 0, 0) 
        updateSliderValue() 
    end 
end

slider.InputBegan:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        sliderDragging = true 
    end 
end)
slider.InputChanged:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
        updateSliderPosition(input) 
    end 
end)
slider.InputEnded:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        sliderDragging = false 
    end 
end)

local sliderLabel = Instance.new("TextLabel", contentFrames[2]) 
sliderLabel.Size = UDim2.new(0, isMobile and 80 or 100, 0, isMobile and 20 or 25) 
sliderLabel.Position = UDim2.new(0, 10, 0, 10) 
sliderLabel.Text = "Скорость анимаций:" 
sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220) 
sliderLabel.BackgroundTransparency = 1 
sliderLabel.Font = Enum.Font.SourceSansSemibold 
sliderLabel.TextSize = isMobile and 12 or 16

local valueLabel = Instance.new("TextLabel", contentFrames[2]) 
valueLabel.Size = UDim2.new(0, 50, 0, isMobile and 20 or 25)  valueLabel.Position = UDim2.new(0, isMobile and 300 or 580, 0, 10) 
valueLabel.Text = tostring(sliderValue) 
valueLabel.TextColor3 = Color3.fromRGB(200, 200, 200) 
valueLabel.BackgroundTransparency = 1 
valueLabel.Font = Enum.Font.SourceSansSemibold 
valueLabel.TextSize = isMobile and 12 or 16

spawn(function() 
    while wait(0.1) do 
        valueLabel.Text = string.format("%.1f", sliderValue) 
    end 
end)
spawn(function() 
    local player = LocalPlayer 
    while task.wait() do 
        local character = player.Character or player.CharacterAdded:Wait() 
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChildOfClass("AnimationController") 
        if humanoid then 
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do 
                track:AdjustSpeed(sliderValue) 
            end 
        end 
    end 
end)

for i, data in pairs({
    {"Fly (PC)", "https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua"},
    {"R4D", "https://raw.githubusercontent.com/M1ZZ001/BrookhavenR4D/main/Brookhaven%20R4D%20Script"},
    {"Bypass Chat", "https://raw.githubusercontent.com/z0nxx/bypass-chat-by-z0nxx/refs/heads/main/bypass%20chat/lua"},
    {"Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {"Mango Hub", "https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub"},
    {"Rvanka", "https://raw.githubusercontent.com/z0nxx/rvanka/refs/heads/main/rvankabyz0nxx.lua"},
    {"System Broken", "https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"},
    {"AVATAR EDITOR", "https://raw.githubusercontent.com/rawscripts.net/raw/Brookhaven-RP-Free-Script-16614"}
}) do
    local feButton = Instance.new("TextButton", contentFrames[2])
    feButton.Size = UDim2.new(0, isMobile and 170 or 280, 0, isMobile and 35 or 50)
    feButton.Position = UDim2.new(0, 10 + ((i-1)%2)*(isMobile and 180 or 300), 0, (isMobile and 40 or 60) + math.floor((i-1)/2)*(isMobile and 45 or 65))
    feButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    feButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    feButton.Text = data[1]
    feButton.Font = Enum.Font.SourceSansSemibold
    feButton.TextSize = isMobile and 12 or 18
    feButton.BorderSizePixel = 0
    addClickSound(feButton)
    feButton.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet(data[2]))() end) end)
    Instance.new("UICorner", feButton).CornerRadius = UDim.new(0, 8)
    local feStroke = Instance.new("UIStroke", feButton) feStroke.Thickness = 1 feStroke.Color = Color3.fromRGB(30, 30, 30)
    feButton.MouseEnter:Connect(function() feButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) feButton.TextColor3 = Color3.fromRGB(0, 0, 0) end)
    feButton.MouseLeave:Connect(function() feButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) feButton.TextColor3 = Color3.fromRGB(200, 200, 200) end)
end

-- Вкладка "Телепорты"
local scrollFrame = Instance.new("ScrollingFrame", contentFrames[3])
scrollFrame.Size = UDim2.new(1, -20, 1, -20)
scrollFrame.Position = UDim2.new(0, 10, 0, 10)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)

for i = 1, 25 do
    local scrollButton = Instance.new("TextButton", scrollFrame)
    scrollButton.Size = UDim2.new(1, -20, 0, isMobile and 30 or 40)
    scrollButton.Position = UDim2.new(0, 10, 0, (i-1)*(isMobile and 35 or 50))
    scrollButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    scrollButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    scrollButton.Text = i == 1 and "Спавн" or i == 2 and "База" or i == 3 and "AFK zone" or "Место " .. i
    scrollButton.Font = Enum.Font.SourceSansSemibold
    scrollButton.TextSize = isMobile and 12 or 18
    scrollButton.BorderSizePixel = 0
    addClickSound(scrollButton)
    if i <= 3 then 
        scrollButton.MouseButton1Click:Connect(function() 
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                    i == 1 and Vector3.new(-22.2000103, 2.4087739, 15.4999981) or 
                    i == 2 and Vector3.new(-81.4962692, 17.4849072, -124.388054) or 
                    Vector3.new(333.547943, 89.6000061, 107.741913)
                ) * (i == 3 and CFrame.Angles(0, math.pi, 0) or CFrame.new()) 
            end 
        end) 
    end
    Instance.new("UICorner", scrollButton).CornerRadius = UDim.new(0, 8)
    local scrollStroke = Instance.new("UIStroke", scrollButton) scrollStroke.Thickness = 1 scrollStroke.Color = Color3.fromRGB(30, 30, 30)
    scrollButton.MouseEnter:Connect(function() scrollButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) scrollButton.TextColor3 = Color3.fromRGB(0, 0, 0) end)
    scrollButton.MouseLeave:Connect(function() scrollButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) scrollButton.TextColor3 = Color3.fromRGB(200, 200, 200) end)
end
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 25 * (isMobile and 35 or 50))

-- Вкладка "Player Finder"
local playerListFrame = Instance.new("Frame", contentFrames[4]) 
playerListFrame.Size = isMobile and UDim2.new(0, 120, 1, -20) or UDim2.new(0, 200, 1, -20) 
playerListFrame.Position = UDim2.new(0, 10, 0, 10) 
playerListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0, 8)

local playerListTitle = Instance.new("TextLabel", playerListFrame) 
playerListTitle.Size = UDim2.new(1, 0, 0, isMobile and 30 or 40) 
playerListTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
playerListTitle.TextColor3 = Color3.fromRGB(220, 220, 220) 
playerListTitle.Text = "Игроки в игре" 
playerListTitle.Font = Enum.Font.SourceSansSemibold 
playerListTitle.TextSize = isMobile and 12 or 18 
Instance.new("UICorner", playerListTitle).CornerRadius = UDim.new(0, 8)

local playerListScroll = Instance.new("ScrollingFrame", playerListFrame) 
playerListScroll.Size = UDim2.new(1, 0, 1, isMobile and -40 or -50) 
playerListScroll.Position = UDim2.new(0, 0, 0, isMobile and 30 or 40) 
playerListScroll.BackgroundTransparency = 1 
playerListScroll.ScrollBarThickness = 6 
playerListScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200) 
Instance.new("UIListLayout", playerListScroll).Padding = UDim.new(0, 5)

local playerInfoFrame = Instance.new("Frame", contentFrames[4]) 
playerInfoFrame.Size = isMobile and UDim2.new(0, 250, 1, -20) or UDim2.new(0, 400, 1, -20) 
playerInfoFrame.Position = UDim2.new(0, isMobile and 140 or 220, 0, 10) 
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
Instance.new("UICorner", playerInfoFrame).CornerRadius = UDim.new(0, 8)

local avatarImage = Instance.new("ImageLabel", playerInfoFrame) 
avatarImage.Size = isMobile and UDim2.new(0, 80, 0, 80) or UDim2.new(0, 150, 0, 150) 
avatarImage.Position = UDim2.new(0.5, -avatarImage.Size.X.Offset / 2, 0, 10) 
avatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png" 
Instance.new("UICorner", avatarImage).CornerRadius = UDim.new(0, 10) 
local avatarStroke = Instance.new("UIStroke", avatarImage) 
avatarStroke.Thickness = 2 
avatarStroke.Color = Color3.fromRGB(200, 200, 200)

local playerInfo = Instance.new("TextLabel", playerInfoFrame) 
playerInfo.Size = isMobile and UDim2.new(0, 230, 0, 120) or UDim2.new(0, 380, 0, 180) 
playerInfo.Position = UDim2.new(0, 10, 0, isMobile and 100 or 190) 
playerInfo.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
playerInfo.TextColor3 = Color3.fromRGB(220, 220, 220) 
playerInfo.Font = Enum.Font.SourceSans 
playerInfo.TextSize = isMobile and 12 or 16 
playerInfo.TextWrapped = true 
playerInfo.TextXAlignment = Enum.TextXAlignment.Left 
playerInfo.TextYAlignment = Enum.TextYAlignment.Top 
playerInfo.Text = "Выберите игрока из списка для просмотра информации." 
Instance.new("UICorner", playerInfo).CornerRadius = UDim.new(0, 8) 
local infoPadding = Instance.new("UIPadding", playerInfo) 
infoPadding.PaddingLeft = UDim.new(0, 10) 
infoPadding.PaddingTop = UDim.new(0, 10)

local teleportButton = Instance.new("TextButton", playerInfoFrame) 
teleportButton.Size = isMobile and UDim2.new(0, 100, 0, 30) or UDim2.new(0, 200, 0, 40) 
teleportButton.Position = UDim2.new(0.5, -teleportButton.Size.X.Offset / 2, 1, isMobile and -40 or -60) 
teleportButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200) 
teleportButton.TextColor3 = Color3.fromRGB(0, 0, 0) 
teleportButton.Text = "Телепортироваться" 
teleportButton.Font = Enum.Font.SourceSansBold 
teleportButton.TextSize = isMobile and 12 or 18 
teleportButton.BorderSizePixel = 0 
teleportButton.Visible = false 
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

local function updatePlayerList()
    for _, child in ipairs(playerListScroll:GetChildren()) do 
        if child:IsA("TextButton") then 
            child:Destroy() 
        end 
    end
    for i, player in ipairs(Players:GetPlayers()) do
        local playerButton = Instance.new("TextButton", playerListScroll)
        playerButton.Size = UDim2.new(1, -10, 0, isMobile and 30 or 40)
        playerButton.Position = UDim2.new(0, 5, 0, (i-1)*(isMobile and 35 or 45))
        playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        playerButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        playerButton.Text = player.Name
        playerButton.Font = Enum.Font.SourceSansSemibold
        playerButton.TextSize = isMobile and 12 or 16
        playerButton.BorderSizePixel = 0
        addClickSound(playerButton)
        Instance.new("UICorner", playerButton).CornerRadius = UDim.new(0, 6)
        playerButton.MouseEnter:Connect(function() playerButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
        playerButton.MouseLeave:Connect(function() playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            local userId, creationDate, displayName, username, team, isInGame = player.UserId, player.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - player.AccountAge * 86400) or "Неизвестно", player.DisplayName, player.Name, player.Team and player.Team.Name or "Нет команды", player.Character and "Да" or "Нет"
            local success, thumbnail = pcall(function() return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size150x150) end)
            avatarImage.Image = success and thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png"
            playerInfo.Text = string.format("<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#d3d3d3'>@%s</font>\n\n<font color='#d3d3d3'>UserID:</font> %d\n<font color='#d3d3d3'>Дата создания:</font> %s\n<font color='#d3d3d3'>Команда:</font> %s\n<font color='#d3d3d3'>В игре:</font> %s", 
                isMobile and 14 or 18, displayName, username, userId, creationDate, team, isInGame)
            playerInfo.RichText = true
            teleportButton.Visible = true
        end)
    end
    playerListScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * (isMobile and 35 or 45))
end

buttons[4].MouseButton1Click:Connect(updatePlayerList)
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Вкладка с сердечком (5-я вкладка)
local thanksFrame = Instance.new("ScrollingFrame", contentFrames[5])
thanksFrame.Size = UDim2.new(1, -20, 1, -20)
thanksFrame.Position = UDim2.new(0, 10, 0, 10)
thanksFrame.BackgroundTransparency = 1
thanksFrame.ScrollBarThickness = 8
thanksFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)

local imageIds = {139269298868770, 75541226381419, 128018455630626, 128018455630626}
for i, imageId in ipairs(imageIds) do
    local imageLabel = Instance.new("ImageLabel", thanksFrame)
    imageLabel.Size = isMobile and UDim2.new(0, 200, 0, 200) or UDim2.new(0, 300, 0, 300) -- Увеличены размеры изображений
    imageLabel.Position = UDim2.new(0.5, -imageLabel.Size.X.Offset / 2, 0, (i-1) * (isMobile and 210 or 310))
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "rbxassetid://" .. imageId
    Instance.new("UICorner", imageLabel).CornerRadius = UDim.new(0, 10)
    local imgStroke = Instance.new("UIStroke", imageLabel)
    imgStroke.Thickness = 2
    imgStroke.Color = Color3.fromRGB(200, 200, 200)
end

local thanksLabel = Instance.new("TextLabel", thanksFrame)
thanksLabel.Size = UDim2.new(1, -20, 0, isMobile and 100 or 120) -- Увеличена высота для полного текста
thanksLabel.Position = UDim2.new(0, 10, 0, (#imageIds) * (isMobile and 210 or 310))
thanksLabel.BackgroundTransparency = 1
thanksLabel.Text = "СПАСИБО ВСЕМ ДРУЗЬЯМ ВЫ МЕНЯ ОЧЕНЬ ПОРАДОВАЛИ В ЭТОТ ЗАМЕЧАТЕЛЬНЫЙ ДЕНЬ!!❤❤❤ и особенно создатель клана Wexx))"
thanksLabel.TextColor3 = Color3.fromRGB(255, 105, 180) -- Розовый цвет для текста
thanksLabel.Font = Enum.Font.GothamBlack -- Красивый шрифт
thanksLabel.TextSize = isMobile and 16 or 24
thanksLabel.TextWrapped = true
thanksLabel.TextXAlignment = Enum.TextXAlignment.Center

thanksFrame.CanvasSize = UDim2.new(0, 0, 0, (#imageIds) * (isMobile and 210 or 310) + (isMobile and 110 or 130))

-- Привязка кнопок к вкладкам
for i, button in pairs(buttons) do 
    button.MouseButton1Click:Connect(function() 
        for j, frame in pairs(contentFrames) do 
            frame.Visible = j == i 
        end 
    end) 
end

-- Кнопка переключения
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 50 or 60)
toggleButton.Position = UDim2.new(0, 20, 0.5, -toggleButton.Size.Y.Offset / 2)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Text = ">"
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = isMobile and 20 or 24
toggleButton.BorderSizePixel = 0
addClickSound(toggleButton)
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new("UIStroke", toggleButton) toggleStroke.Thickness = 2 toggleStroke.Color = Color3.fromRGB(200, 200, 200)

local btnDragging, btnDragStart, btnStartPos
toggleButton.InputBegan:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
        btnDragging = true 
        btnDragStart = input.Position 
        btnStartPos = toggleButton.Position 
    end 
end)
toggleButton.InputChanged:Connect(function(input) 
    if btnDragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
        local delta = input.Position - btnDragStart 
        toggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y) 
    end 
end)
toggleButton.InputEnded:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
        btnDragging = false 
    end 
end)

local isOpen, isFirstLaunch = false, true
local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, 800)})

local function playFirstLaunchAnimation()
    mainFrame.Visible = true
    mainFrame.Size = isMobile and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 100, 0, 100)
    mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2)
    local launchTween = TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = mainFrameSize, Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)})
    launchTween:Play()
    launchTween.Completed:Wait()
    isFirstLaunch = false
    isOpen = true
    toggleButton.Text = "<"
end

toggleButton.MouseButton1Click:Connect(function()
    if isFirstLaunch then 
        playFirstLaunchAnimation()
    elseif isOpen then 
        closeTween:Play() 
        closeTween.Completed:Wait() 
        toggleButton.Text = ">" 
        isOpen = false
    else 
        mainFrame.Visible = true 
        openTween:Play() 
        openTween.Completed:Wait() 
        toggleButton.Text = "<" 
        isOpen = true 
    end
end)
toggleButton.MouseEnter:Connect(function() toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
toggleButton.MouseLeave:Connect(function() toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)

spawn(function() 
    wait(7) 
    if isFirstLaunch then 
        playFirstLaunchAnimation() 
    end 
end)
