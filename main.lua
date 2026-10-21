--// Services
local TweenService = game:GetService("TweenService")

--// ===== НАСТРОЙКИ =====
local DESTROY_AFTER_LOAD = true   -- удалить селектор после успешной загрузки скрипта
local DESTROY_DELAY      = 0.7    -- задержка перед удалением (сек)

local URL_RU = "https://raw.githubusercontent.com/danyachikish-boop/Make-a-Sled-and-Ride-Down-the-Hill/refs/heads/main/ru.lua"
local URL_EN = "https://raw.githubusercontent.com/danyachikish-boop/Make-a-Sled-and-Ride-Down-the-Hill/refs/heads/main/en.lua"
--// ======================

--// Родитель GUI (совместимость с экзекьюторами)
local function getGuiParent()
    if gethui then
        local ok, ui = pcall(gethui)
        if ok and ui then return ui end
    end
    return game:GetService("CoreGui")
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LanguageSelector"
ScreenGui.Parent = getGuiParent()
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.Size = UDim2.fromOffset(350, 275)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 22, 35)
MainFrame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = MainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(130, 85, 255)
stroke.Thickness = 1.5
stroke.Parent = MainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 32, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 20, 30))
})
gradient.Rotation = 35
gradient.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(22, 20)
Title.Size = UDim2.new(1, -65, 0, 32)
Title.Font = Enum.Font.GothamBold
Title.Text = "LANGUAGE SELECTOR"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 19
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(23, 54)
Subtitle.Size = UDim2.new(1, -46, 0, 22)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Выбери язык интерфейса"
Subtitle.TextColor3 = Color3.fromRGB(170, 170, 190)
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Position = UDim2.new(1, -43, 0, 17)
CloseButton.Size = UDim2.fromOffset(26, 26)
CloseButton.BackgroundColor3 = Color3.fromRGB(65, 38, 57)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextSize = 22
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 125, 145)

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = CloseButton

local Status = Instance.new("TextLabel")
Status.Parent = MainFrame
Status.BackgroundTransparency = 1
Status.Position = UDim2.fromOffset(23, 235)
Status.Size = UDim2.new(1, -46, 0, 20)
Status.Font = Enum.Font.GothamMedium
Status.Text = "●  ОЖИДАНИЕ ВЫБОРА"
Status.TextColor3 = Color3.fromRGB(160, 160, 185)
Status.TextSize = 11
Status.TextXAlignment = Enum.TextXAlignment.Left

local function createButton(name, text, y, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = MainFrame
    button.Position = UDim2.fromOffset(22, y)
    button.Size = UDim2.new(1, -44, 0, 49)
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextSize = 15
    button.TextColor3 = Color3.fromRGB(250, 250, 255)

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 11)
    buttonCorner.Parent = button

    button.MouseEnter:Connect(function()
        if button:GetAttribute("Disabled") then return end
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.12)
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = color
        }):Play()
    end)

    return button
end

local RuButton = createButton(
    "RuButton", "🇷🇺     Русский", 94,
    Color3.fromRGB(91, 57, 180)
)

local EnButton = createButton(
    "EnButton", "🇬🇧     English", 153,
    Color3.fromRGB(43, 49, 70)
)

--// ===== ЛОГИКА ЗАГРУЗКИ =====
local isLoading = false

local function setButtonsEnabled(enabled)
    for _, btn in ipairs({RuButton, EnButton}) do
        btn:SetAttribute("Disabled", not enabled)
        btn.Active = enabled
    end
end

local function loadLanguage(url, label, statusLoading, statusDone)
    if isLoading then return end
    isLoading = true
    setButtonsEnabled(false)

    Subtitle.Text = label
    Status.TextColor3 = Color3.fromRGB(180, 145, 255)
    Status.Text = statusLoading

    -- анимация точек, пока идёт загрузка
    local dotsThread = task.spawn(function()
        local n = 0
        while isLoading do
            n = (n % 3) + 1
            Status.Text = statusLoading .. string.rep(".", n)
            task.wait(0.35)
        end
    end)

    task.spawn(function()
        local ok, err = pcall(function()
            local source = game:HttpGet(url)
            local chunk = loadstring(source)
            if not chunk then
                error("loadstring вернул nil (пустой/битый исходник)")
            end
            chunk()
        end)

        isLoading = false
        task.wait(0.05) -- дать потоку точек завершиться

        if ok then
            Status.TextColor3 = Color3.fromRGB(120, 230, 160)
            Status.Text = statusDone
            if DESTROY_AFTER_LOAD then
                task.wait(DESTROY_DELAY)
                ScreenGui:Destroy()
            end
        else
            Status.TextColor3 = Color3.fromRGB(255, 120, 130)
            Status.Text = "✖  Ошибка загрузки"
            warn("[LanguageSelector] " .. tostring(err))
            setButtonsEnabled(true)
        end
    end)
end

RuButton.MouseButton1Click:Connect(function()
    loadLanguage(URL_RU, "Русская версия", "●  Загрузка RU", "✔  Русский загружен")
end)

EnButton.MouseButton1Click:Connect(function()
    loadLanguage(URL_EN, "English version", "●  Loading EN", "✔  English loaded")
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
--// =========================

--// Появление окна
MainFrame.Size = UDim2.fromOffset(320, 245)
TweenService:Create(
    MainFrame,
    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.fromOffset(350, 275)}
):Play()
