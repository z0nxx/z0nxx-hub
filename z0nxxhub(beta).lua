-- Создаем звуковые объекты
local startSound = Instance.new("Sound")
startSound.SoundId = "rbxassetid://95439852376197"
startSound.Parent = game:GetService("SoundService")

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://80335956916443"
clickSound.Parent = game:GetService("SoundService")

-- Выводим сообщение "z0nxx hub" в чат при запуске скрипта
game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "z0nxx hub",
    Color = Color3.fromRGB(147, 112, 219),
    Font = Enum.Font.SourceSansBold,
    TextSize = 18
})

-- Проигрываем звук при запуске
startSound:Play()

-- Загружаем и запускаем скрипт с изображением
loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/image-script/refs/heads/main/image.lua"))()

-- Ждем 7 секунд
wait(7)

-- Проверка типа устройства
local userInputService = game:GetService("UserInputService")
local isMobile = userInputService.TouchEnabled and not userInputService.KeyboardEnabled

-- Создаем основной интерфейс (ScreenGui)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false -- Сохраняем GUI после респавна

-- Основной контейнер GUI с адаптацией размера
local mainFrameSize = isMobile and UDim2.new(0, 400, 0, 300) or UDim2.new(0, 650, 0, 450)
local mainFrame = Instance.new("Frame")
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Visible = false

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(20, 20, 25)
uiStroke.Transparency = 0.8
uiStroke.Parent = mainFrame

-- Верхняя панель для перетаскивания
local dragBar = Instance.new("Frame")
dragBar.Size = UDim2.new(1, 0, 0, 60)
dragBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
dragBar.BorderSizePixel = 0
dragBar.Parent = mainFrame

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(0, 12)
dragCorner.Parent = dragBar

-- Логика перетаскивания окна
local dragging = false
local dragStart = nil
local startPos = nil

local function updatePosition(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

dragBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updatePosition(input)
    end
end)

dragBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Функция для добавления звука клика
local function addClickSound(button)
    button.MouseButton1Click:Connect(function()
        clickSound:Play()
    end)
end

-- Создаем вкладки и их содержимое
local buttons = {}
local contentFrames = {}
for i = 1, 4 do
    local button = Instance.new("TextButton")
    button.Size = isMobile and UDim2.new(0, 90, 0, 30) or UDim2.new(0, 150, 0, 40)
    button.Position = UDim2.new(0, 10 + (i-1)*(isMobile and 95 or 155), 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Text = i == 1 and "About Creator" or i == 2 and "FE Scripts" or i == 3 and "Телепорты" or "Player Finder"
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = isMobile and 14 or 18
    button.BorderSizePixel = 0
    button.Parent = dragBar
    addClickSound(button)
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    end)
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 0, isMobile and 230 or 380)
    contentFrame.Position = UDim2.new(0, 10, 0, 60)
    contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame
    contentFrame.Visible = i == 1
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentFrame
    
    table.insert(buttons, button)
    table.insert(contentFrames, contentFrame)
end

-- Содержимое вкладки "About Creator"
local creatorFrame = contentFrames[1]
local profileImage = Instance.new("ImageLabel")
profileImage.Size = isMobile and UDim2.new(0, 100, 0, 100) or UDim2.new(0, 180, 0, 180)
profileImage.Position = UDim2.new(0, 20, 0, 20)
profileImage.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
local userId = 2316299341 -- UserId для crendel223
local success, thumbnail = pcall(function()
    return game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size180x180)
end)
if success then
    profileImage.Image = thumbnail
else
    profileImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
end
profileImage.Parent = creatorFrame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 10)
imageCorner.Parent = profileImage

local imageStroke = Instance.new("UIStroke")
imageStroke.Thickness = 2
imageStroke.Color = Color3.fromRGB(147, 112, 219)
imageStroke.Parent = profileImage

local creatorInfo = Instance.new("TextLabel")
creatorInfo.Size = isMobile and UDim2.new(0, 240, 0, 190) or UDim2.new(0, 400, 0, 340)
creatorInfo.Position = UDim2.new(0, isMobile and 130 or 220, 0, 20)
creatorInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
creatorInfo.TextColor3 = Color3.fromRGB(220, 220, 220)
creatorInfo.Font = Enum.Font.SourceSans
creatorInfo.TextSize = isMobile and 14 or 18
creatorInfo.TextWrapped = true
creatorInfo.TextXAlignment = Enum.TextXAlignment.Left
creatorInfo.Text = [[
<font size="24" face="SourceSansBold"><b>z0nxx</b></font>
<font color="#9370DB">Создатель скрипта</font>

<font size="16" color="#9370DB"><b>Информация:</b></font>
• Дата создания: 23 марта 2025
• Версия скрипта: 2.0
• Опыт работы: 3 года

<font size="16" color="#9370DB"><b>Контакты:</b></font>
• Discord: z0nxx
• Roblox профиль: 
  <font color="#4b9bff">https://www.roblox.com/users/2316299341/profile</font>

<font size="16" color="#9370DB"><b>О скрипте:</b></font>
Этот скрипт создан для удобства игры в Roblox. 
Он включает в себя множество полезных функций, 
таких как FE скрипты, телепорты и поиск игроков.

<font color="#9370DB">Спасибо за использование моего скрипта!</font>
]]
creatorInfo.RichText = true
creatorInfo.Parent = creatorFrame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 10)
infoCorner.Parent = creatorInfo

local infoPadding = Instance.new("UIPadding")
infoPadding.PaddingLeft = UDim.new(0, 15)
infoPadding.PaddingTop = UDim.new(0, 15)
infoPadding.Parent = creatorInfo

-- Содержимое вкладки "FE Scripts"
local feScriptsFrame = contentFrames[2]

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = isMobile and UDim2.new(0, 300, 0, 20) or UDim2.new(0, 450, 0, 25)
sliderFrame.Position = UDim2.new(0.5, -sliderFrame.Size.X.Offset / 2, 0, 20)
sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
sliderFrame.Parent = feScriptsFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(0, isMobile and 30 or 40, 0, isMobile and 20 or 25)
slider.Position = UDim2.new(0, isMobile and 135 or 205, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
slider.Text = ""
slider.BorderSizePixel = 0
slider.Parent = sliderFrame

local sliderCorner2 = Instance.new("UICorner")
sliderCorner2.CornerRadius = UDim.new(0, 10)
sliderCorner2.Parent = slider

local sliderDragging = false
local sliderValue = 15

local function updateSliderValue()
    local sliderRange = sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X
    local sliderPos = slider.Position.X.Offset
    sliderValue = math.clamp((sliderPos / sliderRange) * 30, 0, 30)
end

slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = true
    end
end)

slider.InputChanged:Connect(function(input)
    if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = input.Position.X
        local frameX = sliderFrame.AbsolutePosition.X
        local newX = math.clamp(mouseX - frameX - (slider.AbsoluteSize.X / 2), 0, sliderFrame.AbsoluteSize.X - slider.AbsoluteSize.X)
        slider.Position = UDim2.new(0, newX, 0, 0)
        updateSliderValue()
    end
end)

slider.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = false
    end
end)

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(0, isMobile and 80 or 100, 0, isMobile and 20 or 25)
sliderLabel.Position = UDim2.new(0, 20, 0, 20)
sliderLabel.Text = "Скорость анимаций:"
sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Font = Enum.Font.SourceSansSemibold
sliderLabel.TextSize = isMobile and 14 or 16
sliderLabel.Parent = feScriptsFrame

local valueLabel = Instance.new("TextLabel")
valueLabel.Size = UDim2.new(0, 50, 0, isMobile and 20 or 25)
valueLabel.Position = UDim2.new(0, isMobile and 330 or 580, 0, 20)
valueLabel.Text = tostring(sliderValue)
valueLabel.TextColor3 = Color3.fromRGB(147, 112, 219)
valueLabel.BackgroundTransparency = 1
valueLabel.Font = Enum.Font.SourceSansSemibold
valueLabel.TextSize = isMobile and 14 or 16
valueLabel.Parent = feScriptsFrame

spawn(function()
    while wait(0.1) do
        valueLabel.Text = string.format("%.1f", sliderValue)
    end
end)

spawn(function()
    local wait = task.wait
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    while wait() do
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChildOfClass("AnimationController")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:AdjustSpeed(sliderValue)
            end
        end
        character = player.Character or player.CharacterAdded:Wait()
    end
end)

-- Кнопки для FE Scripts
local feButtons = {}
local buttonWidth = isMobile and 180 or 280
local buttonHeight = isMobile and 40 or 50
local spacingX = isMobile and 10 or 20
local spacingY = isMobile and 10 or 15
local startX = 20
local startY = isMobile and 50 or 60

for i = 1, 8 do
    local feButton = Instance.new("TextButton")
    local column = (i - 1) % 2
    local row = math.floor((i - 1) / 2)
    
    feButton.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
    feButton.Position = UDim2.new(0, startX + column * (buttonWidth + spacingX), 
                                0, startY + row * (buttonHeight + spacingY))
    
    feButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    feButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    if i == 1 then
        feButton.Text = "Fly (PC)"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua"))()
        end)
    elseif i == 2 then
        feButton.Text = "R4D"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/M1ZZ001/BrookhavenR4D/main/Brookhaven%20R4D%20Script'))()
        end)
    elseif i == 3 then
        feButton.Text = "Bypass Chat"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/bypass-chat-by-z0nxx/refs/heads/main/bypass%20chat/lua"))()
        end)
    elseif i == 4 then
        feButton.Text = "Infinite Yield"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end)
    elseif i == 5 then
        feButton.Text = "Mango Hub"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub", true))()
        end)
    elseif i == 6 then
        feButton.Text = "Rvanka"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/rvanka/refs/heads/main/rvankabyz0nxx.lua"))()
        end)
    elseif i == 7 then
        feButton.Text = "System Broken"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()
        end)
    elseif i == 8 then
        feButton.Text = "AVATAR EDITOR"
        feButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/rawscripts.net/raw/Brookhaven-RP-Free-Script-16614"))()
        end)
    end
    
    feButton.Font = Enum.Font.SourceSansSemibold
    feButton.TextSize = isMobile and 14 or 18
    feButton.BorderSizePixel = 0
    feButton.Parent = feScriptsFrame
    addClickSound(feButton)
    
    local feCorner = Instance.new("UICorner")
    feCorner.CornerRadius = UDim.new(0, 8)
    feCorner.Parent = feButton
    
    local feStroke = Instance.new("UIStroke")
    feStroke.Thickness = 1
    feStroke.Color = Color3.fromRGB(25, 25, 30)
    feStroke.Parent = feButton
    
    feButton.MouseEnter:Connect(function()
        feButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        feButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    feButton.MouseLeave:Connect(function()
        feButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        feButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)
    
    table.insert(feButtons, feButton)
end

-- Содержимое вкладки "Телепорты" с прокруткой
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -20)
scrollFrame.Position = UDim2.new(0, 10, 0, 10)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)
scrollFrame.Parent = contentFrames[3]

local scrollButtons = {}
local scrollButtonHeight = isMobile and 30 or 40
local scrollSpacing = isMobile and 5 or 10
local totalButtons = 25
local player = game.Players.LocalPlayer

for i = 1, totalButtons do
    local scrollButton = Instance.new("TextButton")
    scrollButton.Size = UDim2.new(1, -20, 0, scrollButtonHeight)
    scrollButton.Position = UDim2.new(0, 10, 0, (i-1) * (scrollButtonHeight + scrollSpacing))
    scrollButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    scrollButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    if i == 1 then
        scrollButton.Text = "Спавн"
        scrollButton.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(-22.2000103, 2.4087739, -15.4999981, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            end
        end)
    elseif i == 2 then
        scrollButton.Text = "База"
        scrollButton.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(-81.4962692, 17.4849072, -124.388054, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            end
        end)
    elseif i == 3 then
        scrollButton.Text = "AFK zone"
        scrollButton.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(333.547943, 89.6000061, 107.741913, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            end
        end)
    else
        scrollButton.Text = "Место " .. i
    end
    
    scrollButton.Font = Enum.Font.SourceSansSemibold
    scrollButton.TextSize = isMobile and 14 or 18
    scrollButton.BorderSizePixel = 0
    scrollButton.Parent = scrollFrame
    addClickSound(scrollButton)
    
    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 8)
    scrollCorner.Parent = scrollButton
    
    local scrollStroke = Instance.new("UIStroke")
    scrollStroke.Thickness = 1
    scrollStroke.Color = Color3.fromRGB(25, 25, 30)
    scrollStroke.Parent = scrollButton
    
    scrollButton.MouseEnter:Connect(function()
        scrollButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        scrollButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    scrollButton.MouseLeave:Connect(function()
        scrollButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        scrollButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)
    
    table.insert(scrollButtons, scrollButton)
end

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalButtons * (scrollButtonHeight + scrollSpacing))

-- Содержимое вкладки "Player Finder"
local playerFinderFrame = contentFrames[4]

-- Левая панель - список игроков
local playerListFrame = Instance.new("Frame")
playerListFrame.Size = isMobile and UDim2.new(0, 120, 1, -20) or UDim2.new(0, 200, 1, -20)
playerListFrame.Position = UDim2.new(0, 10, 0, 10)
playerListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
playerListFrame.Parent = playerFinderFrame

local playerListCorner = Instance.new("UICorner")
playerListCorner.CornerRadius = UDim.new(0, 8)
playerListCorner.Parent = playerListFrame

local playerListTitle = Instance.new("TextLabel")
playerListTitle.Size = UDim2.new(1, 0, 0, isMobile and 30 or 40)
playerListTitle.Position = UDim2.new(0, 0, 0, 0)
playerListTitle.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
playerListTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
playerListTitle.Text = "Игроки в игре"
playerListTitle.Font = Enum.Font.SourceSansSemibold
playerListTitle.TextSize = isMobile and 14 or 18
playerListTitle.Parent = playerListFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = playerListTitle

local playerListScroll = Instance.new("ScrollingFrame")
playerListScroll.Size = UDim2.new(1, 0, 1, isMobile and -40 or -50)
playerListScroll.Position = UDim2.new(0, 0, 0, isMobile and 30 or 40)
playerListScroll.BackgroundTransparency = 1
playerListScroll.ScrollBarThickness = 6
playerListScroll.ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)
playerListScroll.Parent = playerListFrame

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 5)
playerListLayout.Parent = playerListScroll

-- Правая панель - информация об игроке
local playerInfoFrame = Instance.new("Frame")
playerInfoFrame.Size = isMobile and UDim2.new(0, 250, 1, -20) or UDim2.new(0, 400, 1, -20)
playerInfoFrame.Position = UDim2.new(0, isMobile and 140 or 220, 0, 10)
playerInfoFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
playerInfoFrame.Parent = playerFinderFrame

local playerInfoCorner = Instance.new("UICorner")
playerInfoCorner.CornerRadius = UDim.new(0, 8)
playerInfoCorner.Parent = playerInfoFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = isMobile and UDim2.new(0, 100, 0, 100) or UDim2.new(0, 150, 0, 150)
avatarImage.Position = UDim2.new(0.5, -avatarImage.Size.X.Offset / 2, 0, 20)
avatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
avatarImage.Parent = playerInfoFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 10)
avatarCorner.Parent = avatarImage

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 2
avatarStroke.Color = Color3.fromRGB(147, 112, 219)
avatarStroke.Parent = avatarImage

local playerInfo = Instance.new("TextLabel")
playerInfo.Size = isMobile and UDim2.new(0, 230, 0, 100) or UDim2.new(0, 380, 0, 180)
playerInfo.Position = UDim2.new(0, 10, 0, isMobile and 130 or 190)
playerInfo.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
playerInfo.TextColor3 = Color3.fromRGB(220, 220, 220)
playerInfo.Font = Enum.Font.SourceSans
playerInfo.TextSize = isMobile and 12 or 16
playerInfo.TextWrapped = true
playerInfo.TextXAlignment = Enum.TextXAlignment.Left
playerInfo.TextYAlignment = Enum.TextYAlignment.Top
playerInfo.Text = "Выберите игрока из списка для просмотра информации."
playerInfo.Parent = playerInfoFrame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = playerInfo

local infoPadding = Instance.new("UIPadding")
infoPadding.PaddingLeft = UDim.new(0, 10)
infoPadding.PaddingTop = UDim.new(0, 10)
infoPadding.Parent = playerInfo

local teleportButton = Instance.new("TextButton")
teleportButton.Size = isMobile and UDim2.new(0, 120, 0, 30) or UDim2.new(0, 200, 0, 40)
teleportButton.Position = UDim2.new(0.5, -teleportButton.Size.X.Offset / 2, 1, isMobile and -40 or -60)
teleportButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Text = "Телепортироваться"
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = isMobile and 14 or 18
teleportButton.BorderSizePixel = 0
teleportButton.Visible = false
teleportButton.Parent = playerInfoFrame
addClickSound(teleportButton)

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 8)
teleportCorner.Parent = teleportButton

teleportButton.MouseEnter:Connect(function()
    teleportButton.BackgroundColor3 = Color3.fromRGB(170, 130, 255)
end)
teleportButton.MouseLeave:Connect(function()
    teleportButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
end)

-- Функция для обновления списка игроков
local selectedPlayer = nil

teleportButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local localPlayer = game.Players.LocalPlayer
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
            playerInfo.Text = playerInfo.Text .. "\n\n<font color='#4b9bff'>Успешно телепортирован к игроку!</font>"
        end
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
    
    local players = game:GetService("Players"):GetPlayers()
    for i, player in ipairs(players) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, -10, 0, isMobile and 30 or 40)
        playerButton.Position = UDim2.new(0, 5, 0, (i-1)*(isMobile and 35 or 45))
        playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        playerButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        playerButton.Text = player.Name
        playerButton.Font = Enum.Font.SourceSansSemibold
        playerButton.TextSize = isMobile and 12 or 16
        playerButton.BorderSizePixel = 0
        playerButton.Parent = playerListScroll -- Исправлено с ParentIt на Parent
        addClickSound(playerButton)
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = playerButton
        
        playerButton.MouseEnter:Connect(function()
            playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        end)
        playerButton.MouseLeave:Connect(function()
            playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        end)
        
        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            local userId = player.UserId
            local creationDate = player.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - player.AccountAge * 86400) or "Неизвестно"
            local displayName = player.DisplayName
            local username = player.Name
            local team = player.Team and player.Team.Name or "Нет команды"
            local isInGame = player.Character and "Да" or "Нет"

            local success, thumbnail = pcall(function()
                return game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size100x100 or Enum.ThumbnailSize.Size150x150)
            end)
            if success then
                avatarImage.Image = thumbnail
            else
                avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            end

            playerInfo.Text = string.format(
                "<font size='%d' face='SourceSansBold'>%s</font>\n<font color='#9370DB'>@%s</font>\n\n"..
                "<font color='#9370DB'>UserID:</font> %d\n"..
                "<font color='#9370DB'>Дата создания:</font> %s\n"..
                "<font color='#9370DB'>Команда:</font> %s\n"..
                "<font color='#9370DB'>В игре:</font> %s",
                isMobile and 16 or 18, displayName, username, userId, creationDate, team, isInGame
            )
            playerInfo.RichText = true
            teleportButton.Visible = true
        end)
    end
    
    playerListScroll.CanvasSize = UDim2.new(0, 0, 0, #players * (isMobile and 35 or 45))
end

-- Обновляем список игроков при открытии вкладки и при изменении состава игроков
buttons[4].MouseButton1Click:Connect(updatePlayerList)
game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
game:GetService("Players").PlayerRemoving:Connect(updatePlayerList)

-- Логика переключения вкладок
for i, button in pairs(buttons) do
    button.MouseButton1Click:Connect(function()
        for j, frame in pairs(contentFrames) do
            frame.Visible = (j == i)
        end
    end)
end

-- Круглая кнопка для открытия/закрытия интерфейса
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, isMobile and 50 or 60, 0, isMobile and 50 or 60)
toggleButton.Position = UDim2.new(0, 20, 0.5, -toggleButton.Size.Y.Offset / 2)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
toggleButton.Text = ">"
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = isMobile and 20 or 24
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui
addClickSound(toggleButton)

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(147, 112, 219)
toggleStroke.Parent = toggleButton

-- Логика перетаскивания кнопки
local btnDragging = false
local btnDragStart = nil
local btnStartPos = nil

local function updateButtonPosition(input)
    local delta = input.Position - btnDragStart
    toggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, 
                                    btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = toggleButton.Position
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if btnDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateButtonPosition(input)
    end
end)

toggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        btnDragging = false
    end
end)

-- Анимация открытия/закрытия
local tweenService = game:GetService("TweenService")
local isOpen = false
local isFirstLaunch = true

local openTween = tweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)
})
local closeTween = tweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
    Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, 800)
})

local function playFirstLaunchAnimation()
    mainFrame.Visible = true
    mainFrame.Size = isMobile and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 100, 0, 100)
    mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2)
    
    local launchTween = tweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = mainFrameSize,
        Position = UDim2.new(0.5, -mainFrameSize.X.Offset / 2, 0.5, -mainFrameSize.Y.Offset / 2)
    })
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

toggleButton.MouseEnter:Connect(function()
    toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
end)
toggleButton.MouseLeave:Connect(function()
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
end)

-- Автоматический запуск анимации после загрузки
spawn(function()
    wait(7)
    if isFirstLaunch then
        playFirstLaunchAnimation()
    end
end)
