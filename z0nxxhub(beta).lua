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

-- Создаем основной интерфейс (ScreenGui)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = false -- Сохраняем GUI после респавна

-- Основной контейнер GUI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
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
    button.Size = UDim2.new(0, 140, 0, 40)
    button.Position = UDim2.new(0, 10 + (i-1)*145, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Text = i == 1 and "About Creator" or i == 2 and "FE Scripts" or i == 3 and "Телепорты" or "Player Finder"
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = 18
    button.BorderSizePixel = 0
    button.Parent = dragBar
    addClickSound(button) -- Добавляем звук клика
    
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
    contentFrame.Size = UDim2.new(1, -20, 0, 350)
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
profileImage.Size = UDim2.new(0, 150, 0, 150)
profileImage.Position = UDim2.new(0, 20, 0, 20)
profileImage.BackgroundTransparency = 1
profileImage.Image = "rbxassetid://0"
profileImage.Parent = creatorFrame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 10)
imageCorner.Parent = profileImage

local creatorInfo = Instance.new("TextLabel")
creatorInfo.Size = UDim2.new(0, 380, 0, 290)
creatorInfo.Position = UDim2.new(0, 190, 0, 20)
creatorInfo.BackgroundTransparency = 1
creatorInfo.TextColor3 = Color3.fromRGB(220, 220, 220)
creatorInfo.Font = Enum.Font.SourceSans
creatorInfo.TextSize = 18
creatorInfo.TextWrapped = true
creatorInfo.TextXAlignment = Enum.TextXAlignment.Left
creatorInfo.Text = [[
Creator: z0nxx
Script Creation Date: 23 марта 2025
Description: Привет! Я z0nxx, создатель данного скрипта!
Profile Link: https://www.roblox.com/users/2316299341/profile
]]
creatorInfo.Parent = creatorFrame

-- Содержимое вкладки "FE Scripts"
local feScriptsFrame = contentFrames[2]

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0, 400, 0, 20)
sliderFrame.Position = UDim2.new(0, 90, 0, 20)
sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
sliderFrame.Parent = feScriptsFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local slider = Instance.new("TextButton")
slider.Size = UDim2.new(0, 40, 0, 20)
slider.Position = UDim2.new(0, 180, 0, 0)
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
sliderLabel.Size = UDim2.new(0, 80, 0, 20)
sliderLabel.Position = UDim2.new(0, 0, 0, 20)
sliderLabel.Text = "Speed:"
sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Font = Enum.Font.SourceSans
sliderLabel.TextSize = 18
sliderLabel.Parent = feScriptsFrame

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
local buttonWidth = 260
local buttonHeight = 50
local spacingX = 20
local spacingY = 20
local startX = 20
local startY = 60

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
    feButton.TextSize = 18
    feButton.BorderSizePixel = 0
    feButton.Parent = feScriptsFrame
    addClickSound(feButton) -- Добавляем звук клика
    
    local feCorner = Instance.new("UICorner")
    feCorner.CornerRadius = UDim.new(0, 8)
    feCorner.Parent = feButton
    
    feButton.MouseEnter:Connect(function()
        feButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    end)
    feButton.MouseLeave:Connect(function()
        feButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
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
local scrollButtonHeight = 40
local scrollSpacing = 10
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
        scrollButton.Text = "Button " .. i
    end
    
    scrollButton.Font = Enum.Font.SourceSansSemibold
    scrollButton.TextSize = 18
    scrollButton.BorderSizePixel = 0
    scrollButton.Parent = scrollFrame
    addClickSound(scrollButton) -- Добавляем звук клика
    
    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 8)
    scrollCorner.Parent = scrollButton
    
    scrollButton.MouseEnter:Connect(function()
        scrollButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    end)
    scrollButton.MouseLeave:Connect(function()
        scrollButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    end)
    
    table.insert(scrollButtons, scrollButton)
end

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalButtons * (scrollButtonHeight + scrollSpacing))

-- Содержимое вкладки "Player Finder"
local playerFinderFrame = contentFrames[4]

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0, 400, 0, 40)
searchBox.Position = UDim2.new(0, 90, 0, 20)
searchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
searchBox.TextColor3 = Color3.fromRGB(200, 200, 200)
searchBox.PlaceholderText = "Введите ник игрока..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.Font = Enum.Font.SourceSansSemibold
searchBox.TextSize = 18
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.Parent = playerFinderFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 8)
searchCorner.Parent = searchBox

local searchLabel = Instance.new("TextLabel")
searchLabel.Size = UDim2.new(0, 80, 0, 40)
searchLabel.Position = UDim2.new(0, 0, 0, 20)
searchLabel.Text = "Поиск:"
searchLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
searchLabel.BackgroundTransparency = 1
searchLabel.Font = Enum.Font.SourceSans
searchLabel.TextSize = 18
searchLabel.Parent = playerFinderFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 150, 0, 150)
avatarImage.Position = UDim2.new(0, 20, 0, 70)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
avatarImage.Parent = playerFinderFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 10)
avatarCorner.Parent = avatarImage

local playerInfo = Instance.new("TextLabel")
playerInfo.Size = UDim2.new(0, 380, 0, 200)
playerInfo.Position = UDim2.new(0, 190, 0, 70)
playerInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
playerInfo.TextColor3 = Color3.fromRGB(220, 220, 220)
playerInfo.Font = Enum.Font.SourceSans
playerInfo.TextSize = 16
playerInfo.TextWrapped = true
playerInfo.TextXAlignment = Enum.TextXAlignment.Left
playerInfo.TextYAlignment = Enum.TextYAlignment.Top
playerInfo.Text = "Информация появится здесь после поиска."
playerInfo.Parent = playerFinderFrame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = playerInfo

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 200, 0, 50)
teleportButton.Position = UDim2.new(0.5, -100, 0, 290)
teleportButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Text = "Телепортироваться"
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.TextSize = 20
teleportButton.BorderSizePixel = 0
teleportButton.Visible = false
teleportButton.Parent = playerFinderFrame
addClickSound(teleportButton) -- Добавляем звук клика

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 8)
teleportCorner.Parent = teleportButton

teleportButton.MouseEnter:Connect(function()
    teleportButton.BackgroundColor3 = Color3.fromRGB(170, 130, 255)
end)
teleportButton.MouseLeave:Connect(function()
    teleportButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
end)

local function findPlayer(partialName)
    local players = game:GetService("Players"):GetPlayers()
    for _, player in ipairs(players) do
        if string.find(string.lower(player.Name), string.lower(partialName)) then
            return player
        end
    end
    return nil
end

local targetPlayer = nil

local function updatePlayerInfo()
    local inputText = searchBox.Text
    if inputText ~= "" then
        local foundPlayer = findPlayer(inputText)
        if foundPlayer then
            targetPlayer = foundPlayer
            local userId = foundPlayer.UserId
            local creationDate = foundPlayer.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - foundPlayer.AccountAge * 86400) or "Неизвестно"
            local displayName = foundPlayer.DisplayName
            local username = foundPlayer.Name
            local team = foundPlayer.Team and foundPlayer.Team.Name or "Нет команды"
            local isInGame = foundPlayer.Character and "Да" or "Нет"

            local success, thumbnail = pcall(function()
                return game:GetService("Players"):GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            end)
            if success then
                avatarImage.Image = thumbnail
            else
                avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            end

            playerInfo.Text = string.format(
                "Имя: %s\nНикнейм: %s\nUserID: %d\nДата создания аккаунта: %s\nКоманда: %s\nВ игре: %s",
                displayName, username, userId, creationDate, team, isInGame
            )
            teleportButton.Visible = true
        else
            playerInfo.Text = "Игрок с таким ником не найден."
            avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            teleportButton.Visible = false
            targetPlayer = nil
        end
    else
        playerInfo.Text = "Введите ник игрока для поиска."
        avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        teleportButton.Visible = false
        targetPlayer = nil
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(updatePlayerInfo)

teleportButton.MouseButton1Click:Connect(function()
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local localPlayer = game.Players.LocalPlayer
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    else
        playerInfo.Text = "Ошибка: Игрок не в игре или недоступен для телепортации."
    end
end)

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
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 10, 0.5, -30)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
toggleButton.Text = ">"
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 24
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui
addClickSound(toggleButton) -- Добавляем звук клика

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleButton

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
    Position = UDim2.new(0.5, -300, 0.5, -200)
})
local closeTween = tweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
    Position = UDim2.new(0.5, -300, 0.5, 600)
})

local function playFirstLaunchAnimation()
    mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 100, 0, 100)
    mainFrame.Position = UDim2.new(0.5, -50, 0.5, -50)
    
    local launchTween = tweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200)
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
