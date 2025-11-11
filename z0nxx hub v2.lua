-- z0nxx Hub - Enhanced Edition с Shift Lock

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- === АДАПТИВНЫЕ РАЗМЕРЫ ===
local cam = workspace.CurrentCamera
local screenSize = cam.ViewportSize
local baseWidth = isMobile and math.min(screenSize.X * 0.94, 420) or 800
local baseHeight = isMobile and math.min(screenSize.Y * 0.86, 680) or 500
local mainSize = UDim2.new(0, baseWidth, 0, baseHeight)
local headerHeight = isMobile and 48 or 60
local sidebarWidth = isMobile and 72 or 80
local padding = isMobile and 8 or 12
local buttonHeight = isMobile and 44 or 50
local gridCellSize = isMobile and UDim2.new(0.44, 0, 0, 44) or UDim2.new(0, 180, 0, 50)

-- === УТИЛИТЫ ===
local function loadScript(url)
    local success, res = pcall(function()
        local src = game:HttpGet(url, true)
        if src and src ~= "" then
            local func, err = loadstring(src)
            if func then return func() end
        end
    end)
    return success and res ~= nil
end

local function showNotification(msg)
    local frame = screenGui:FindFirstChild("NotificationFrame")
    if not frame then return end
    local label = frame:FindFirstChild("NotificationLabel")
    if label then
        label.Text = msg or "Скрипт активирован!"
        frame.Visible = true
        local targetY = isMobile and -60 or -80
        local inT = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, 0, 1, targetY)})
        local outT = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, 0, 1, targetY - 20)})
        inT:Play()
        task.delay(2.5, function()
            outT:Play()
            outT.Completed:Wait()
            frame.Visible = false
        end)
    end
end

-- === GUI ===
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui", 5))
screenGui.Name = "Z0nxxHub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
blur.Size = 0
blur.Enabled = false

-- Основное окно
local main = Instance.new("Frame", screenGui)
main.Size = mainSize
main.Position = UDim2.new(0.5, -mainSize.X.Offset/2, 0.5, -mainSize.Y.Offset/2)
main.BackgroundColor3 = Color3.fromRGB(25, 15, 35)
main.BackgroundTransparency = 0.2
main.Visible = false
main.ClipsDescendants = true
main.ZIndex = 1
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
local mStroke = Instance.new("UIStroke", main)
mStroke.Thickness = 1.5
mStroke.Color = Color3.fromRGB(70, 30, 90)
mStroke.Transparency = 0.3

-- Заголовок
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, headerHeight)
header.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
header.BackgroundTransparency = 0.2
header.ZIndex = 2

-- Аватар
local avatar = Instance.new("ImageButton", header)
avatar.Size = UDim2.new(0, isMobile and 36 or 50, 0, isMobile and 36 or 50)
avatar.Position = UDim2.new(0, isMobile and 10 or 12, 0.5, -(isMobile and 18 or 25))
avatar.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
avatar.Image = "rbxassetid://94562916053131"
avatar.ScaleType = Enum.ScaleType.Fit
avatar.ZIndex = 3
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
local aStroke = Instance.new("UIStroke", avatar)
aStroke.Thickness = 1
aStroke.Color = Color3.fromRGB(70, 30, 90)

-- Название
local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -(isMobile and 54 or 74), 1, 0)
title.Position = UDim2.new(0, isMobile and 50 or 64, 0, 0)
title.BackgroundTransparency = 1
title.Text = "z0nxx Hub"
title.TextColor3 = Color3.fromRGB(190, 140, 245)
title.Font = Enum.Font.SourceSansBold
title.TextSize = isMobile and 16 or 20
title.TextXAlignment = Enum.TextXAlignment.Center
title.ZIndex = 3

local grad = Instance.new("UIGradient", title)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 140, 245)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 160, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 140, 245))
}
grad.Rotation = 45
task.spawn(function()
    while true do
        TweenService:Create(grad, TweenInfo.new(3, Enum.EasingStyle.Sine), {Rotation = 405}):Play()
        task.wait(3)
        TweenService:Create(grad, TweenInfo.new(3, Enum.EasingStyle.Sine), {Rotation = 45}):Play()
        task.wait(3)
    end
end)

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, isMobile and 28 or 34, 0, isMobile and 28 or 34)
closeBtn.Position = UDim2.new(1, -(isMobile and 32 or 40), 0.5, -(isMobile and 14 or 17))
closeBtn.BackgroundColor3 = Color3.fromRGB(70, 30, 90)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(190, 140, 245)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = isMobile and 12 or 16
closeBtn.ZIndex = 3
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- Сайдбар
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, sidebarWidth, 1, -headerHeight)
sidebar.Position = UDim2.new(0, 0, 0, headerHeight)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
sidebar.BackgroundTransparency = 0.2
sidebar.ZIndex = 2
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

-- Контент
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -sidebarWidth, 1, -headerHeight)
content.Position = UDim2.new(0, sidebarWidth, 0, headerHeight)
content.BackgroundTransparency = 1
content.ClipsDescendants = true
content.ZIndex = 2

-- Вкладки
local tabs = {"О Создателе", "FE Скрипты", "Телепорты", "Поиск Игроков", "ther hubs"}
local tabButtons, tabFrames = {}, {}
local layout = Instance.new("UIListLayout", sidebar)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, isMobile and 5 or 7)
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Секретная вкладка
local secret = Instance.new("Frame", content)
secret.Size = UDim2.new(1, -padding*2, 1, -padding*2)
secret.Position = UDim2.new(0, padding, 0, padding)
secret.BackgroundTransparency = 0.2
secret.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
secret.Visible = false
secret.ClipsDescendants = true
secret.ZIndex = 3
Instance.new("UICorner", secret).CornerRadius = UDim.new(0, 10)
local sStroke = Instance.new("UIStroke", secret)
sStroke.Thickness = 1
sStroke.Color = Color3.fromRGB(70, 30, 90)
local sLabel = Instance.new("TextLabel", secret)
sLabel.Size = UDim2.new(1, -padding*2, 1, -padding*2)
sLabel.Position = UDim2.new(0, padding, 0, padding)
sLabel.BackgroundTransparency = 1
sLabel.Text = [[Поздравляем!
Ты нашёл пасхалку!
Это секретная вкладка z0nxx Hub!
Присоединяйся к Telegram:
https://t.me/z0nxxHUB
• Получай обновления
• Участвуй в розыгрышах
• Стань частью комьюнити!]]
sLabel.RichText = true
sLabel.TextColor3 = Color3.fromRGB(190, 140, 245)
sLabel.Font = Enum.Font.SourceSans
sLabel.TextSize = isMobile and 10 or 14
sLabel.TextWrapped = true
sLabel.TextXAlignment = Enum.TextXAlignment.Center
sLabel.TextYAlignment = Enum.TextYAlignment.Center
sLabel.ZIndex = 3
TweenService:Create(sLabel, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.2}):Play()

-- === СОЗДАНИЕ ВКЛАДОК ===
for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(0, isMobile and 62 or 70, 0, buttonHeight)
    btn.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    btn.TextColor3 = Color3.fromRGB(190, 140, 245)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = isMobile and 9 or 12
    btn.TextWrapped = true
    btn.ZIndex = 3
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 1
    bStroke.Color = Color3.fromRGB(70, 30, 90)
    local frame = Instance.new("Frame", content)
    frame.Size = UDim2.new(1, -padding*2, 1, -padding*2)
    frame.Position = UDim2.new(0, padding, 0, padding)
    frame.BackgroundTransparency = 1
    frame.Visible = i == 1
    frame.ClipsDescendants = true
    frame.ZIndex = 2
    table.insert(tabButtons, btn)
    table.insert(tabFrames, frame)
    btn.MouseButton1Click:Connect(function()
        for j, f in ipairs(tabFrames) do f.Visible = (j == i) end
        secret.Visible = false
        for j, b in ipairs(tabButtons) do
            TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = (j == i) and Color3.fromRGB(55, 35, 75) or Color3.fromRGB(35, 25, 45)}):Play()
        end
        if i == 2 then
            for _, b in ipairs(tabFrames[2]:FindFirstChild("FEScrollFrame"):GetChildren()) do
                if b:IsA("TextButton") then
                    b.Position = b.Position + UDim2.new(0, 0, 1, 100)
                    b.TextTransparency = 1
                    b.BackgroundTransparency = 1
                    TweenService:Create(b, TweenInfo.new(0.5, Enum.EasingStyle.Quart, 0, false, (i-1)*0.1), {Position = b.Position - UDim2.new(0, 0, 1, 100)}):Play()
                    TweenService:Create(b, TweenInfo.new(0.5, Enum.EasingStyle.Quart, 0, false, (i-1)*0.1), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
                end
            end
        elseif i == 3 then
            for _, b in ipairs(tabFrames[3]:GetChildren()) do
                if b:IsA("TextButton") then
                    b.Position = b.Position + UDim2.new(0, 0, 1, 100)
                    b.TextTransparency = 1
                    b.BackgroundTransparency = 1
                    TweenService:Create(b, TweenInfo.new(0.5, Enum.EasingStyle.Quart, 0, false, (i-1)*0.1), {Position = b.Position - UDim2.new(0, 0, 1, 100)}):Play()
                    TweenService:Create(b, TweenInfo.new(0.5, Enum.EasingStyle.Quart, 0, false, (i-1)*0.1), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
                end
            end
        elseif i == 4 then
            updatePlayerList()
        end
    end)
    btn.MouseEnter:Connect(function()
        if not tabFrames[i].Visible then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 35, 55)}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if not tabFrames[i].Visible then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 45)}):Play()
        end
    end)
end

-- === ВКЛАДКА 1: О СОЗДАТЕЛЕ ===
local creatorScroll = Instance.new("ScrollingFrame", tabFrames[1])
creatorScroll.Size = UDim2.new(1, 0, 1, 0)
creatorScroll.BackgroundTransparency = 1
creatorScroll.ScrollBarThickness = isMobile and 4 or 5
creatorScroll.ScrollBarImageColor3 = Color3.fromRGB(70, 30, 90)
creatorScroll.ZIndex = 2
creatorScroll.ClipsDescendants = true
local cLayout = Instance.new("UIListLayout", creatorScroll)
cLayout.Padding = UDim.new(0, isMobile and 8 or 10)
cLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local creatorData = {
    {UserId=2316299341, Name="z0nxx", Title="Создатель", Info="• Опыт: 3 года\n• Создан: 23.03.2025\n• Версия: 2.0", Contact="• Discord: z0nxx\n• Roblox: z0nxx", Description="Главный разработчик!"},
    {UserId=4254815427, Name="Lil_darkie", Title="Тестировщик", Info="• Роль: Тестирование", Contact="Помог с мобильной версией.", Description="Спасибо за помощь!"}
}

for _, d in ipairs(creatorData) do
    local card = Instance.new("Frame", creatorScroll)
    card.Size = UDim2.new(1, -padding*2, 0, isMobile and 180 or 280)
    card.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    card.BackgroundTransparency = 0.2
    card.ZIndex = 2
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
    local cStroke = Instance.new("UIStroke", card)
    cStroke.Thickness = 1
    cStroke.Color = Color3.fromRGB(70, 30, 90)
    local av = Instance.new("ImageLabel", card)
    av.Size = isMobile and UDim2.new(0, 58, 0, 58) or UDim2.new(0, 100, 0, 100)
    av.Position = UDim2.new(0, isMobile and 12 or 14, 0, isMobile and 12 or 14)
    av.BackgroundTransparency = 1
    local ok, thumb = pcall(Players.GetUserThumbnailAsync, Players, d.UserId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size48x48 or Enum.ThumbnailSize.Size150x150)
    av.Image = ok and thumb or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    av.ZIndex = 2
    Instance.new("UICorner", av).CornerRadius = UDim.new(0, 8)
    local avStroke = Instance.new("UIStroke", av)
    avStroke.Thickness = 1
    avStroke.Color = Color3.fromRGB(70, 30, 90)
    local info = Instance.new("TextLabel", card)
    info.Size = isMobile and UDim2.new(1, -74, 0, 150) or UDim2.new(1, -120, 0, 260)
    info.Position = isMobile and UDim2.new(0, 74, 0, 12) or UDim2.new(0, 120, 0, 14)
    info.BackgroundTransparency = 1
    info.Text = string.format("%s\n%s\n\n%s\n\n%s\n\n%s", d.Name, d.Title, d.Info, d.Contact, d.Description)
    info.RichText = true
    info.TextColor3 = Color3.fromRGB(190, 140, 245)
    info.Font = Enum.Font.SourceSans
    info.TextSize = isMobile and 9 or 12
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.ZIndex = 2
    local pad = Instance.new("UIPadding", info)
    pad.PaddingLeft = UDim.new(0, 4)
    pad.PaddingTop = UDim.new(0, 4)
end
creatorScroll.CanvasSize = UDim2.new(0, 0, 0, (#creatorData * (isMobile and 188 or 290)) + padding)

-- === ВКЛАДКА 2: FE СКРИПТЫ ===
local feScroll = Instance.new("ScrollingFrame", tabFrames[2])
feScroll.Name = "FEScrollFrame"
feScroll.Size = UDim2.new(1, -padding*2, 1, -padding*2)
feScroll.Position = UDim2.new(0, padding, 0, padding)
feScroll.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
feScroll.BackgroundTransparency = 0.3
feScroll.ScrollBarThickness = isMobile and 4 or 5
feScroll.ScrollBarImageColor3 = Color3.fromRGB(70, 30, 90)
feScroll.ZIndex = 2
feScroll.ClipsDescendants = true
Instance.new("UICorner", feScroll).CornerRadius = UDim.new(0, 10)
local feStroke = Instance.new("UIStroke", feScroll)
feStroke.Thickness = 1.5
feStroke.Color = Color3.fromRGB(70, 30, 90)

local grid = Instance.new("UIGridLayout", feScroll)
grid.CellSize = gridCellSize
grid.CellPadding = isMobile and UDim2.new(0.02, 0, 0, 10) or UDim2.new(0, 15, 0, 15)
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
grid.StartCorner = Enum.StartCorner.TopLeft

-- Добавлена кнопка Shift Lock
local feScripts = {
    {"Fly (PC)","https://raw.githubusercontent.com/z0nxx/fly-by-z0nxx/refs/heads/main/fly.lua"},
    {"R4D","https://raw.githubusercontent.com/M1ZZ001/BrookhavenR4D/main/Brookhaven%20R4D%20Script"},
    {"Bypass Chat","https://raw.githubusercontent.com/z0nxx/bypass-chat-by-z0nxx/refs/heads/main/bypass%20chat/lua"},
    {"Infinite Yield","https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {"Mango Hub","https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub"},
    {"Rvanka","https://raw.githubusercontent.com/z0nxx/rvanka/refs/heads/main/rvankabyz0nxx.lua"},
    {"System Broken","https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"},
    {"AVATAR EDITOR","https://rawscripts.net/raw/Brookhaven-RP-Free-Script-16614"},
    {"R6","https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua"},
    {"Chat Draw","https://raw.githubusercontent.com/z0nxx/chat-draw/refs/heads/main/chat%20draw"},
    {"Vape","https://raw.githubusercontent.com/z0nxx/vape/refs/heads/main/vape.lua"},
    {"Fling v3","https://raw.githubusercontent.com/z0nxx/z0nxx-fling-v-3/refs/heads/main/flingv3.lua"},
    {"ToolEditor","https://raw.githubusercontent.com/z0nxx/risovalka-script/refs/heads/main/risovalka.lua"},
    {"Charball","https://raw.githubusercontent.com/Melishy/melishy-scripts/main/charball/script.lua"},
    {"RTX","https://raw.githubusercontent.com/z0nxx/rtx/refs/heads/main/rtxbyz0nxx.lua"},
    {"Jerk Off","https://raw.githubusercontent.com/z0nxx/jerk-off-by-z0nxx/refs/heads/main/jerk%20off.lua"},
    {"Invisible","https://raw.githubusercontent.com/z0nxx/invise/refs/heads/main/invisible.lua"},
    {"HOUSEunbanned","https://raw.githubusercontent.com/z0nxx/UNBANEHOUSE/refs/heads/main/houseUnbane.lua"},
    {"Fake IP Grabber","https://pastebin.com/raw/aziWwaw2"},
    {"Universal Emotes","https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua"},
    {"Dance Hub","https://raw.githubusercontent.com/z0nxx/dance-script/refs/heads/main/dance.lua"},
    {"Shift Lock", "https://raw.githubusercontent.com/z0nxx/shift-lock/refs/heads/main/shiftlock.lua"} -- НОВАЯ КНОПКА
}

for i, d in ipairs(feScripts) do
    local btn = Instance.new("TextButton", feScroll)
    btn.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    btn.TextColor3 = Color3.fromRGB(190, 140, 245)
    btn.Text = d[1]
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = isMobile and 10 or 15
    btn.TextWrapped = true
    btn.ZIndex = 2
    btn.Name = d[1]
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 1.5
    bStroke.Color = Color3.fromRGB(70, 30, 90)
    btn.MouseButton1Click:Connect(function()
        if d[1] == "Shift Lock" then
            local success = pcall(function()
                loadstring(game:HttpGet(d[2]))()
            end)
            showNotification(success and "Shift Lock включён!" or "Ошибка: Shift Lock")
        else
            local success = loadScript(d[2])
            showNotification(success and (d[1].." запущен!") or ("Ошибка: "..d[1]))
        end
    end)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 35, 55)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 45)}):Play()
    end)
end

-- === ВКЛАДКА 3: ТЕЛЕПОРТЫ ===
local tpScroll = Instance.new("ScrollingFrame", tabFrames[3])
tpScroll.Size = UDim2.new(1, -padding*2, 1, -padding*2)
tpScroll.Position = UDim2.new(0, padding, 0, padding)
tpScroll.BackgroundTransparency = 1
tpScroll.ScrollBarThickness = isMobile and 4 or 5
tpScroll.ScrollBarImageColor3 = Color3.fromRGB(70, 30, 90)
tpScroll.ZIndex = 2
tpScroll.ClipsDescendants = true
local tpLayout = Instance.new("UIListLayout", tpScroll)
tpLayout.Padding = UDim.new(0, isMobile and 6 or 8)
tpLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local savedPos = {}
local locations = {
    {Name="Спавн",Position=Vector3.new(-22.2,2.41,15.5)},
    {Name="База",Position=Vector3.new(-81.5,17.48,-124.39)},
    {Name="AFK Зона",Position=Vector3.new(333.55,89.6,107.74),Angle=CFrame.Angles(0,math.pi,0)}
}

for i=1,5 do
    local btn = Instance.new("TextButton", tpScroll)
    btn.Size = UDim2.new(1, -16, 0, isMobile and 32 or 36)
    btn.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    btn.TextColor3 = Color3.fromRGB(190, 140, 245)
    btn.Text = i<=#locations and locations[i].Name or (i==4 and "Сохранить Точку" or "Телепорт к Сохранённой")
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = isMobile and 9 or 12
    btn.ZIndex = 2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 1
    bStroke.Color = Color3.fromRGB(70, 30, 90)
    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if not (char and char:FindFirstChild("HumanoidRootPart")) then showNotification("Ошибка: Персонаж не загружен!"); return end
        local hrp = char.HumanoidRootPart
        if i<=#locations then
            local cf = CFrame.new(locations[i].Position)
            if locations[i].Angle then cf = cf * locations[i].Angle end
            hrp.CFrame = cf
            showNotification("Телепорт в "..locations[i].Name)
        elseif i==4 then
            table.insert(savedPos, hrp.Position)
            btn.Text = "Сохранить Точку ("..#savedPos..")"
            showNotification("Точка сохранена!")
        elseif i==5 and #savedPos>0 then
            hrp.CFrame = CFrame.new(savedPos[#savedPos])
            showNotification("Телепорт к сохранённой точке")
        else
            showNotification("Нет сохранённых точек!")
        end
    end)
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 35, 55)}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 45)}):Play() end)
end
tpScroll.CanvasSize = UDim2.new(0, 0, 0, 5*(isMobile and 38 or 44))

-- === ВКЛАДКА 4: ПОИСК ИГРОКОВ ===
local playerList = Instance.new("Frame", tabFrames[4])
playerList.Size = isMobile and UDim2.new(1, -padding*2, 0.4, 0) or UDim2.new(0, 160, 1, -20)
playerList.Position = isMobile and UDim2.new(0, padding, 0, padding) or UDim2.new(0, padding, 0, padding)
playerList.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
playerList.BackgroundTransparency = 0.2
playerList.ZIndex = 2
Instance.new("UICorner", playerList).CornerRadius = UDim.new(0, 8)
local plTitle = Instance.new("TextLabel", playerList)
plTitle.Size = UDim2.new(1, 0, 0, isMobile and 28 or 32)
plTitle.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
plTitle.Text = "Игроки"
plTitle.TextColor3 = Color3.fromRGB(190, 140, 245)
plTitle.Font = Enum.Font.SourceSansBold
plTitle.TextSize = isMobile and 10 or 14
plTitle.ZIndex = 2
Instance.new("UICorner", plTitle).CornerRadius = UDim.new(0, 8)
local plScroll = Instance.new("ScrollingFrame", playerList)
plScroll.Size = UDim2.new(1, 0, 1, isMobile and -32 or -40)
plScroll.Position = UDim2.new(0, 0, 0, isMobile and 28 or 32)
plScroll.BackgroundTransparency = 1
plScroll.ScrollBarThickness = isMobile and 4 or 5
plScroll.ScrollBarImageColor3 = Color3.fromRGB(70, 30, 90)
plScroll.ZIndex = 2
plScroll.ClipsDescendants = true
local plLayout = Instance.new("UIListLayout", plScroll)
plLayout.Padding = UDim.new(0, isMobile and 3 or 4)

local infoFrame = Instance.new("Frame", tabFrames[4])
infoFrame.Size = isMobile and UDim2.new(1, -padding*2, 0.55, 0) or UDim2.new(0, 320, 1, -20)
infoFrame.Position = isMobile and UDim2.new(0, padding, 0.45, 0) or UDim2.new(0, 176, 0, padding)
infoFrame.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
infoFrame.BackgroundTransparency = 0.2
infoFrame.ZIndex = 2
Instance.new("UICorner", infoFrame).CornerRadius = UDim.new(0, 8)
local avatarImg = Instance.new("ImageLabel", infoFrame)
avatarImg.Size = isMobile and UDim2.new(0, 48, 0, 48) or UDim2.new(0, 100, 0, 100)
avatarImg.Position = UDim2.new(0.5, -(isMobile and 24 or 50), 0, isMobile and 10 or 12)
avatarImg.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
avatarImg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
avatarImg.ZIndex = 2
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(0, 8)
local avStroke = Instance.new("UIStroke", avatarImg)
avStroke.Thickness = 1
avStroke.Color = Color3.fromRGB(70, 30, 90)
local infoLabel = Instance.new("TextLabel", infoFrame)
infoLabel.Size = isMobile and UDim2.new(1, -12, 0, 80) or UDim2.new(1, -16, 0, 140)
infoLabel.Position = isMobile and UDim2.new(0, 6, 0, 60) or UDim2.new(0, 8, 0, 120)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Выберите игрока."
infoLabel.TextColor3 = Color3.fromRGB(190, 140, 245)
infoLabel.Font = Enum.Font.SourceSans
infoLabel.TextSize = isMobile and 8 or 12
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.RichText = true

local tpBtn = Instance.new("TextButton", infoFrame)
tpBtn.Size = isMobile and UDim2.new(0, 70, 0, 28) or UDim2.new(0, 120, 0, 32)
tpBtn.Position = isMobile and UDim2.new(0.5, -35, 1, -32) or UDim2.new(0.5, -60, 1, -40)
tpBtn.BackgroundColor3 = Color3.fromRGB(70, 30, 90)
tpBtn.Text = "Телепорт"
tpBtn.TextColor3 = Color3.fromRGB(190, 140, 245)
tpBtn.Font = Enum.Font.SourceSansBold
tpBtn.TextSize = isMobile and 9 or 12
tpBtn.Visible = false
tpBtn.ZIndex = 2
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)

local selectedPlayer = nil
local function waitChar(p, t) t = t or 3 local s = tick() while tick()-s < t do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then return p.Character end task.wait(0.1) end end

tpBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then
        infoLabel.Text = "Ошибка: Персонаж не загружен!"
        showNotification("Ошибка: Персонаж не загружен!")
        return
    end
    if not selectedPlayer then
        infoLabel.Text = "Ошибка: Игрок не выбран!"
        showNotification("Ошибка: Игрок не выбран!")
        return
    end
    local target = waitChar(selectedPlayer)
    if target and target:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
        infoLabel.Text = string.format(
            "%s\n@%s\n\nUserID: %d\nСоздан: %s\nКоманда: %s\nВ игре: Да\n\nТелепорт успешен!",
            selectedPlayer.DisplayName, selectedPlayer.Name, selectedPlayer.UserId,
            selectedPlayer.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - selectedPlayer.AccountAge*86400) or "Неизвестно",
            selectedPlayer.Team and selectedPlayer.Team.Name or "Без команды"
        )
        showNotification("Телепорт к "..selectedPlayer.Name)
    else
        infoLabel.Text = "Ошибка: Персонаж игрока не загружен!"
        showNotification("Ошибка: Персонаж игрока не загружен!")
    end
end)

local function updatePlayerList()
    selectedPlayer = nil
    tpBtn.Visible = false
    infoLabel.Text = "Выберите игрока."
    avatarImg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    for _, c in ipairs(plScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        local btn = Instance.new("TextButton", plScroll)
        btn.Size = UDim2.new(1, -8, 0, isMobile and 28 or 32)
        btn.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
        btn.Text = p.Name
        btn.TextColor3 = Color3.fromRGB(190, 140, 245)
        btn.Font = Enum.Font.SourceSansSemibold
        btn.TextSize = isMobile and 9 or 12
        btn.ZIndex = 2
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        btn.MouseButton1Click:Connect(function()
            selectedPlayer = p
            local ok, thumb = pcall(Players.GetUserThumbnailAsync, Players, p.UserId, Enum.ThumbnailType.HeadShot, isMobile and Enum.ThumbnailSize.Size48x48 or Enum.ThumbnailSize.Size150x150)
            avatarImg.Image = ok and thumb or "rbxasset://textures/ui/GuiImagePlaceholder.png"
            infoLabel.Text = string.format(
                "%s\n@%s\n\nUserID: %d\nСоздан: %s\nКоманда: %s\nВ игре: %s",
                p.DisplayName, p.Name, p.UserId,
                p.AccountAge > 0 and os.date("%d.%m.%Y", os.time() - p.AccountAge*86400) or "Неизвестно",
                p.Team and p.Team.Name or "Без команды",
                p.Character and p.Character:FindFirstChild("HumanoidRootPart") and "Да" or "Нет"
            )
            tpBtn.Visible = true
        end)
        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 35, 55)}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 45)}):Play() end)
    end
    plScroll.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * (isMobile and 31 or 36))
end

if tabButtons[4] then tabButtons[4].MouseButton1Click:Connect(updatePlayerList) end
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- === ВКЛАДКА 5: OTHER HUBS ===
local otherHubsScroll = Instance.new("ScrollingFrame", tabFrames[5])
otherHubsScroll.Size = UDim2.new(1, -padding*2, 1, -padding*2)
otherHubsScroll.Position = UDim2.new(0, padding, 0, padding)
otherHubsScroll.BackgroundTransparency = 1
otherHubsScroll.ScrollBarThickness = isMobile and 4 or 5
otherHubsScroll.ScrollBarImageColor3 = Color3.fromRGB(70, 30, 90)
otherHubsScroll.ZIndex = 2
otherHubsScroll.ClipsDescendants = true
local ohLayout = Instance.new("UIListLayout", otherHubsScroll)
ohLayout.Padding = UDim.new(0, isMobile and 10 or 12)
ohLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local otherHubs = {
    {"jg hub", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/joygril/Brookhaven-RP-JG-Hub/refs/heads/main/Jeon-The-Best.txt"))() end},
    {"VR7", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP"))() end},
    {"Dex Explorer", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end}
}

for _, d in ipairs(otherHubs) do
    local btn = Instance.new("TextButton", otherHubsScroll)
    btn.Size = UDim2.new(1, -16, 0, isMobile and 44 or 50)
    btn.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    btn.TextColor3 = Color3.fromRGB(190, 140, 245)
    btn.Text = d[1]
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = isMobile and 12 or 16
    btn.ZIndex = 2
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 1.5
    bStroke.Color = Color3.fromRGB(70, 30, 90)
    btn.MouseButton1Click:Connect(function()
        local success = pcall(d[2])
        showNotification(success and (d[1].." запущен!") or ("Ошибка: "..d[1]))
    end)
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 35, 55)}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 45)}):Play() end)
end
otherHubsScroll.CanvasSize = UDim2.new(0, 0, 0, #otherHubs * (isMobile and 54 or 62))

-- === ТОГГЛ-КНОПКА ===
local toggle = Instance.new("TextButton", screenGui)
toggle.Size = UDim2.new(0, isMobile and 58 or 70, 0, isMobile and 58 or 70)
toggle.Position = UDim2.new(0, isMobile and 14 or 16, 0.5, -(isMobile and 29 or 35))
toggle.BackgroundTransparency = 1
toggle.ZIndex = 10
toggle.Active = true
local tgGrad = Instance.new("UIGradient", toggle)
tgGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 30, 90)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(90, 40, 110)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 30, 90))
}
tgGrad.Rotation = 45
task.spawn(function()
    while true do
        TweenService:Create(tgGrad, TweenInfo.new(3, Enum.EasingStyle.Sine), {Rotation = 405}):Play()
        task.wait(3)
        TweenService:Create(tgGrad, TweenInfo.new(3, Enum.EasingStyle.Sine), {Rotation = 45}):Play()
        task.wait(3)
    end
end)
local tgImg = Instance.new("ImageLabel", toggle)
tgImg.Size = UDim2.new(1, -2, 1, -2)
tgImg.Position = UDim2.new(0, 1, 0, 1)
tgImg.BackgroundTransparency = 1
tgImg.Image = "rbxassetid://71196235690019"
tgImg.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
Instance.new("UICorner", tgImg).CornerRadius = UDim.new(1, 0)
local tgStroke = Instance.new("UIStroke", toggle)
tgStroke.Thickness = 1.5
tgStroke.Color = Color3.fromRGB(90, 40, 110)

local drag, dStart, dPos
toggle.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true dStart = i.Position dPos = toggle.Position end end)
toggle.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local delta = i.Position - dStart toggle.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + delta.X, dPos.Y.Scale, dPos.Y.Offset + delta.Y) end end)
toggle.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)

-- === УВЕДОМЛЕНИЕ ===
local notif = Instance.new("Frame", screenGui)
notif.Size = UDim2.new(0, isMobile and 170 or 260, 0, isMobile and 36 or 40)
notif.Position = UDim2.new(0.5, 0, 1, isMobile and -60 or -80)
notif.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
notif.BackgroundTransparency = 0.2
notif.Visible = false
notif.ZIndex = 5
notif.Name = "NotificationFrame"
Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
local nStroke = Instance.new("UIStroke", notif)
nStroke.Thickness = 1
nStroke.Color = Color3.fromRGB(70, 30, 90)
local nLabel = Instance.new("TextLabel", notif)
nLabel.Size = UDim2.new(1, -4, 1, -4)
nLabel.Position = UDim2.new(0, 2, 0, 2)
nLabel.BackgroundTransparency = 1
nLabel.Text = "Скрипт активирован!"
nLabel.TextColor3 = Color3.fromRGB(190, 140, 245)
nLabel.Font = Enum.Font.SourceSansSemibold
nLabel.TextSize = isMobile and 9 or 14
nLabel.TextXAlignment = Enum.TextXAlignment.Center
nLabel.TextYAlignment = Enum.TextYAlignment.Center
nLabel.ZIndex = 5
nLabel.Name = "NotificationLabel"

-- === АНИМАЦИИ ===
local openTween = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -mainSize.X.Offset/2, 0.5, -mainSize.Y.Offset/2)})
local closeTween = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -mainSize.X.Offset/2, 1.5, 0)})
local blurIn = TweenService:Create(blur, TweenInfo.new(0.3), {Size = 12})
local blurOut = TweenService:Create(blur, TweenInfo.new(0.3), {Size = 0})
local isOpen, first = false, true

local function launchAnim()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text="z0nxx Hub - Enhanced Edition", Color=Color3.fromRGB(190, 140, 245), Font=Enum.Font.SourceSansBold, TextSize=isMobile and 16 or 18})
    main.Visible = true
    blur.Enabled = true
    blurIn:Play()
    main.Size = isMobile and UDim2.new(0, 30, 0, 30) or UDim2.new(0, 60, 0, 60)
    main.Position = UDim2.new(0.5, -main.Size.X.Offset/2, 0.5, -main.Size.Y.Offset/2)
    local t = TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = mainSize, Position = UDim2.new(0.5, -mainSize.X.Offset/2, 0.5, -mainSize.Y.Offset/2)})
    t:Play()
    t.Completed:Wait()
    first = false
    isOpen = true
end

toggle.MouseButton1Click:Connect(function()
    if first then launchAnim()
    elseif isOpen then
        closeTween:Play()
        blurOut:Play()
        closeTween.Completed:Wait()
        blur.Enabled = false
        main.Visible = false
        isOpen = false
    else
        main.Visible = true
        blur.Enabled = true
        blurIn:Play()
        for _, f in ipairs(tabFrames) do f.Visible = (f == tabFrames[1]) end
        secret.Visible = false
        openTween:Play()
        isOpen = true
    end
end)

avatar.MouseButton1Click:Connect(function()
    main.Visible = true
    blur.Enabled = true
    blurIn:Play()
    for _, f in ipairs(tabFrames) do f.Visible = false end
    secret.Visible = true
    for _, b in ipairs(tabButtons) do TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 25, 45)}):Play() end
    openTween:Play()
    showNotification("Пасхалка найдена!")
end)

closeBtn.MouseButton1Click:Connect(function()
    closeTween:Play()
    blurOut:Play()
    closeTween.Completed:Wait()
    blur.Enabled = false
    main.Visible = false
end)

-- Перетаскивание
local dragging, dIn, dStart, dPos
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dStart = i.Position
        dPos = main.Position
    end
end)
header.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dStart
        main.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + delta.X, dPos.Y.Scale, dPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

-- === АВТОЗАПУСК ===
task.spawn(function()
    task.wait(1)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/z0nxx/adminka-/refs/heads/main/adminka.lua"))()
        showNotification("adminka запущена!")
    end)
end)
task.spawn(function()
    task.wait(2)
    launchAnim()
end)
