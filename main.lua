local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

if CoreGui:FindFirstChild("SledGui") then
    CoreGui.SledGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SledGui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local autoFarmWins = false
local autoFarmForward = false

local LangFrame = Instance.new("Frame")
LangFrame.Name = "LangFrame"
LangFrame.Size = UDim2.new(0, 280, 0, 140)
LangFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
LangFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
LangFrame.BorderSizePixel = 0
LangFrame.Active = true
LangFrame.Draggable = true
LangFrame.Parent = ScreenGui

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 8)
LangCorner.Parent = LangFrame

local LangTitle = Instance.new("TextLabel")
LangTitle.Size = UDim2.new(1, 0, 0, 40)
LangTitle.Position = UDim2.new(0, 0, 0, 10)
LangTitle.BackgroundTransparency = 1
LangTitle.Text = "Выбери язык / Select Language"
LangTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LangTitle.TextSize = 15
LangTitle.Font = Enum.Font.SourceSansBold
LangTitle.Parent = LangFrame

local RuBtn = Instance.new("TextButton")
RuBtn.Size = UDim2.new(0, 100, 0, 36)
RuBtn.Position = UDim2.new(0.5, -110, 0, 75)
RuBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
RuBtn.Text = "Русский"
RuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RuBtn.TextSize = 14
RuBtn.Font = Enum.Font.SourceSansBold
RuBtn.Parent = LangFrame

local RuCorner = Instance.new("UICorner")
RuCorner.CornerRadius = UDim.new(0, 6)
RuCorner.Parent = RuBtn

local EnBtn = Instance.new("TextButton")
EnBtn.Size = UDim2.new(0, 100, 0, 36)
EnBtn.Position = UDim2.new(0.5, 10, 0, 75)
EnBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
EnBtn.Text = "English"
EnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnBtn.TextSize = 14
EnBtn.Font = Enum.Font.SourceSansBold
EnBtn.Parent = LangFrame

local EnCorner = Instance.new("UICorner")
EnCorner.CornerRadius = UDim.new(0, 6)
EnCorner.Parent = EnBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Покатушки на санях"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 45, 45)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -20, 1, -45)
Container.Position = UDim2.new(0, 10, 0, 40)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = Container

local function CreateToggle(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 36)
    Button.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    Button.Text = "  " .. text .. " [ВЫКЛ]"
    Button.TextColor3 = Color3.fromRGB(180, 180, 180)
    Button.TextSize = 13
    Button.Font = Enum.Font.SourceSans
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.Parent = Container

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Button

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        if state then
            Button.BackgroundColor3 = Color3.fromRGB(40, 100, 60)
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Text = "  " .. text .. " [ВКЛ]"
        else
            Button.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
            Button.TextColor3 = Color3.fromRGB(180, 180, 180)
            Button.Text = "  " .. text .. " [ВЫКЛ]"
        end
        callback(state)
    end)
end

local function CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 36)
    Button.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.Font = Enum.Font.SourceSans
    Button.Parent = Container

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        task.wait(0.1)
        Button.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
        callback()
    end)
end

-- Функция замены опасных блоков на безопасные копии
local function ReplaceHazardousParts()
    for _, obj in pairs(Workspace:GetDescendants()) do
        local isHazard = false
        
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if name:find("kill") or name:find("damage") or name:find("spike") or name:find("lava") or name == "water" or name:find("ice") or name:find("hazard") then
                isHazard = true
            end
        end

        if isHazard then
            -- Создаем безопасную копию блока
            local safePart = Instance.new("Part")
            safePart.Size = obj.Size
            safePart.CFrame = obj.CFrame
            safePart.Color = obj.Color
            safePart.Material = obj.Material
            safePart.Transparency = obj.Transparency
            safePart.Anchored = true
            safePart.CanCollide = obj.CanCollide
            safePart.Name = "SafePart"
            safePart.Parent = obj.Parent

            -- Удаляем оригинальный опасный блок
            obj:Destroy()
        elseif obj:IsA("TouchTransmitter") then
            -- Удаляем триггеры касания, наносящие урон
            obj:Destroy()
        end
    end
end

local function OpenMenu(isRu)
    LangFrame:Destroy()
    MainFrame.Visible = true

    Title.Text = isRu and "Покатушки на санях" or "Sledding Hub"

    CreateToggle(isRu and "Фарм побед" or "Farm Wins", function(Value)
        autoFarmWins = Value
        task.spawn(function()
            while autoFarmWins do
                local char = Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(-1159.79, 25.38, -15070.76)
                end
                task.wait(2)
            end
        end)
    end)

    CreateToggle(isRu and "Быстрый фарм монеток" or "Fast Money Farm", function(Value)
        autoFarmForward = Value
        task.spawn(function()
            while autoFarmForward do
                local char = Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 100000000000000)
                end
                task.wait(2)
            end
        end)
    end)

    CreateButton(isRu and "Сделать лёд безопасным" or "Make Ice Safe", function()
        ReplaceHazardousParts()
    end)
end

RuBtn.MouseButton1Click:Connect(function()
    OpenMenu(true)
end)

EnBtn.MouseButton1Click:Connect(function()
    OpenMenu(false)
end)
