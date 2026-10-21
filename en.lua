local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Make a Sled and Ride Down the Hill",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Flor1x",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local Tab = Window:CreateTab("Main", 4483362458)

local autoFarmWins = false
local autoFarmForward = false

Tab:CreateToggle({
    Name = "Auto-Farm Wins",
    CurrentValue = false,
    Flag = "FarmWins",
    Callback = function(Value)
        autoFarmWins = Value
        task.spawn(function()
            while autoFarmWins do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(-1159.79, 25.38, -15070.76)
                end
                task.wait(2)
            end
        end)
    end,
})

Tab:CreateToggle({
    Name = "Auto-Farm Money",
    CurrentValue = false,
    Flag = "FarmForward",
    Callback = function(Value)
        autoFarmForward = Value
        task.spawn(function()
            while autoFarmForward do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 100000000000000)
                end
                task.wait(2)
            end
        end)
    end,
})

Tab:CreateButton({
    Name = "Ice Deals No Damage",
    Callback = function()
        local deletedCount = 0

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local name = obj.Name:lower()
                if name:find("kill") or name:find("damage") or name:find("spike") or name:find("lava") or name == "water" or name:find("ice") or name:find("hazard") then
                    obj:Destroy()
                    deletedCount = deletedCount + 1
                end
            elseif obj:IsA("TouchTransmitter") then
                local parent = obj.Parent
                if parent then
                    local pname = parent.Name:lower()
                    if pname:find("kill") or pname:find("damage") or pname:find("spike") or pname:find("lava") or pname:find("ice") then
                        parent:Destroy()
                        deletedCount = deletedCount + 1
                    else
                        obj:Destroy()
                        deletedCount = deletedCount + 1
                    end
                end
            end
        end

        Rayfield:Notify({
            Title = "Success :)",
            Content = "Damage objects removed: " .. tostring(deletedCount),
            Duration = 3,
            Image = 4483362458,
        })
    end,
})
