-- Reyz Hub by Reyz 
loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Player = game.Players.LocalPlayer
local SelectedWeapon = "Melee"
local AutoFarm = false

local Window = Rayfield:CreateWindow({
   Name = "Reyz Hub | Blox Fruits",
   LoadingTitle = "Reyz Hub Loading...",
   LoadingSubtitle = "By Reyz 😈",
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
   Name = "Auto Farm (Quest + Kill)",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
      while AutoFarm do
         pcall(function()
            local Character = game.Players.LocalPlayer.Character
            local Enemy = workspace.Enemies:FindFirstChildWhichIsA("Model")

            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", 1, "Bandit") -- contoh quest

            if Enemy and Enemy:FindFirstChild("HumanoidRootPart") then
               Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
               wait(0.5)
            end

            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
               if tool:IsA("Tool") and string.find(tool.Name, SelectedWeapon) then
                  tool.Parent = Character
                  tool:Activate()
               end
            end

            wait(1)
         end)
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
         Image = nil,
         Actions = { Accept = { Name = "Oke", Callback = function() end } }
      })
   end,
})
