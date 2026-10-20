local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local RuButton = Instance.new("TextButton")
local EnButton = Instance.new("TextButton")
local MainCorner = Instance.new("UICorner")
local RuCorner = Instance.new("UICorner")
local EnCorner = Instance.new("UICorner")

ScreenGui.Name = "LanguageSelector"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -80)
MainFrame.Size = UDim2.new(0, 250, 0, 160)
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Select Language / Выберите язык"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

RuButton.Name = "RuButton"
RuButton.Parent = MainFrame
RuButton.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
RuButton.Position = UDim2.new(0.1, 0, 0.4, 0)
RuButton.Size = UDim2.new(0.8, 0, 0, 35)
RuButton.Font = Enum.Font.GothamSemibold
RuButton.Text = "Русский 🇷🇺"
RuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RuButton.TextSize = 14
RuCorner.CornerRadius = UDim.new(0, 6)
RuCorner.Parent = RuButton

EnButton.Name = "EnButton"
EnButton.Parent = MainFrame
EnButton.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
EnButton.Position = UDim2.new(0.1, 0, 0.7, 0)
EnButton.Size = UDim2.new(0.8, 0, 0, 35)
EnButton.Font = Enum.Font.GothamSemibold
EnButton.Text = "English 🇬🇧"
EnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnButton.TextSize = 14
EnCorner.CornerRadius = UDim.new(0, 6)
EnCorner.Parent = EnButton

local function loadScript(url)
    ScreenGui:Destroy()
    loadstring(game:HttpGet(url))()
end

RuButton.MouseButton1Click:Connect(function()
    loadScript('https://raw.githubusercontent.com/danyachikish-boop/Make-a-Sled-and-Ride-Down-the-Hill/refs/heads/main/ru.lua')
end)

EnButton.MouseButton1Click:Connect(function()
    loadScript('https://raw.githubusercontent.com/danyachikish-boop/Make-a-Sled-and-Ride-Down-the-Hill/refs/heads/main/en.lua')
end)
