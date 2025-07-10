
-- Reyz Hub [Beta] 💥 by SayangGPT
-- UI Stay On, Brutal One Hit, Full Auto Farm (GUN/SWORD/MELEE Support)
-- For Delta Executor (Mobile Compatible)

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Variables
local weaponType = "Melee"
local weaponName = "Combat"
local autoFarm = false
local currentQuest = nil

-- UI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 230)
main.Position = UDim2.new(0.35, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local betaLabel = Instance.new("TextLabel", main)
betaLabel.Text = "Reyz Hub [Beta]"
betaLabel.Size = UDim2.new(1,0,0,15)
betaLabel.Position = UDim2.new(0,0,0,-15)
betaLabel.BackgroundTransparency = 1
betaLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
betaLabel.Font = Enum.Font.Gotham
betaLabel.TextSize = 12

local title = Instance.new("TextLabel", main)
title.Text = "Reyz Hub | Auto Farm"
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(45,45,45)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local input = Instance.new("TextBox", main)
input.PlaceholderText = "Nama Senjata (ex: Kabucha, Saber)"
input.Position = UDim2.new(0.05, 0, 0.2, 0)
input.Size = UDim2.new(0.9, 0, 0, 30)
input.BackgroundColor3 = Color3.fromRGB(40,40,40)
input.TextColor3 = Color3.fromRGB(255,255,255)
input.TextSize = 14

local typeDropdown = Instance.new("TextBox", main)
typeDropdown.PlaceholderText = "Tipe Senjata (GUN/SWORD/MELEE)"
typeDropdown.Position = UDim2.new(0.05, 0, 0.38, 0)
typeDropdown.Size = UDim2.new(0.9, 0, 0, 30)
typeDropdown.BackgroundColor3 = Color3.fromRGB(40,40,40)
typeDropdown.TextColor3 = Color3.fromRGB(255,255,255)
typeDropdown.TextSize = 14

local toggle = Instance.new("TextButton", main)
toggle.Text = "🔰 Start Auto Farm"
toggle.Position = UDim2.new(0.05, 0, 0.60, 0)
toggle.Size = UDim2.new(0.9, 0, 0, 40)
toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16

-- Brutal Auto Kill Function
local function brutalKill(mob)
    local char = player.Character
    local tool = char:FindFirstChild(weaponName) or player.Backpack:FindFirstChild(weaponName)
    if tool then
        tool.Parent = char
        repeat
            wait(0.1)
            char.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
            tool:Activate()
            mob.Humanoid.Health = 0
        until mob.Humanoid.Health <= 0 or not mob:FindFirstChild("Humanoid")
    end
end

-- Auto Farm Loop
spawn(function()
    while true do wait(1)
        if autoFarm then
            local mobs = workspace.Enemies:GetChildren()
            for _,v in pairs(mobs) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    brutalKill(v)
                end
            end
        end
    end
end)

-- Button Logic
toggle.MouseButton1Click:Connect(function()
    if not autoFarm then
        weaponName = input.Text ~= "" and input.Text or "Combat"
        local t = typeDropdown.Text:upper()
        if t == "GUN" or t == "SWORD" or t == "MELEE" then
            weaponType = t
        end
        toggle.Text = "⛔ Stop Auto Farm"
        autoFarm = true
    else
        toggle.Text = "🔰 Start Auto Farm"
        autoFarm = false
    end
end)

print("[Reyz Hub] Loaded!")
