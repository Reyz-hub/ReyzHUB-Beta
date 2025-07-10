-- Reyz Hub by Sayangmu 😘
loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local SelectedWeapon = "Melee"
local AutoFarm = false

local function tweenTo(pos)
    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local tweenInfo = TweenInfo.new((hrp.Position - pos.Position).Magnitude / 200, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = pos})
        tween:Play()
        tween.Completed:Wait()
    end
end

local Window = Rayfield:CreateWindow({
   Name = "Reyz Hub | Blox Fruits",
   LoadingTitle = "Reyz Hub Loading...",
   LoadingSubtitle = "By Sayangmu 😘",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateDropdown({
    Name = "Pilih Senjata",
    Options = {"Melee", "Sword", "Gun"},
    CurrentOption = "Melee",
    Callback = function(Value)
        SelectedWeapon = Value
    end,
})

Tab:CreateToggle({
   Name = "Auto Farm (Quest + Kill Aman)",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
      while AutoFarm do
         pcall(function()
            local char = Player.Character
            local enemies = workspace.Enemies:GetChildren()
            local target = nil

            -- Ambil musuh pertama yang aktif
            for _, mob in pairs(enemies) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    target = mob
                    break
                end
            end

            if target then
                -- Ambil quest (contoh quest 1: Bandit)
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", 1, "Bandit")

                -- Tween ke musuh
                tweenTo(target.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))

                -- Serang
                for _, tool in pairs(Player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and string.find(tool.Name, SelectedWeapon) then
                        tool.Parent = char
                        tool:Activate()
                    end
                end
            end

            task.wait(1)
         end)
         task.wait(0.1)
      end
   end,
})

Tab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
      Rayfield:Notify({
         Title = "Anti AFK",
         Content = "Berhasil Aktif!",
         Duration = 4,
         Actions = {
            Accept = { Name = "Oke", Callback = function() end }
         }
      })
   end,
})
