local Settings = {
    JoinTeam = "Pirates", -- اختار Pirates أو Marines
    Translator = true
}

repeat wait() until game:IsLoaded()

local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- مكتبة الواجهة
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/V4HvxEkj"))()
local Window = Library:CreateWindow("Rix GUI", "by @Rix", Color3.fromRGB(140, 0, 255), Enum.KeyCode.RightControl)

-- Main Tab
local MainTab = Window:AddTab("Main")
local selectedMob = ""
MainTab:AddDropdown("Select Mob", {}, function(v)
    selectedMob = v
end)

MainTab:AddToggle("Auto Farm", false, function(v)
    _G.autoFarm = v
    while _G.autoFarm and wait() do
        pcall(function()
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == selectedMob and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                    plr.Character:MoveTo(mob.HumanoidRootPart.Position + Vector3.new(0,3,0))
                    VIM:SendKeyEvent(true, "Z", false, game)
                    wait(0.1)
                    VIM:SendKeyEvent(false, "Z", false, game)
                    break
                end
            end
        end)
    end
end)

MainTab:AddToggle("Auto Skill X", false, function(v)
    _G.skillX = v
    spawn(function()
        while _G.skillX do
            VIM:SendKeyEvent(true, "X", false, game)
            wait(0.1)
            VIM:SendKeyEvent(false, "X", false, game)
            wait(1.5)
        end
    end)
end)

MainTab:AddToggle("Auto Skill C", false, function(v)
    _G.skillC = v
    spawn(function()
        while _G.skillC do
            VIM:SendKeyEvent(true, "C", false, game)
            wait(0.1)
            VIM:SendKeyEvent(false, "C", false, game)
            wait(1.5)
        end
    end)
end)

MainTab:AddToggle("Auto Skill V", false, function(v)
    _G.skillV = v
    spawn(function()
        while _G.skillV do
            VIM:SendKeyEvent(true, "V", false, game)
            wait(0.1)
            VIM:SendKeyEvent(false, "V", false, game)
            wait(1.5)
        end
    end)
end)

-- Teleport Tab
local TeleportTab = Window:AddTab("Teleport")
TeleportTab:AddButton("Jungle", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(300, 50, -1400)
end)
TeleportTab:AddButton("Marine", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(-2600, 20, 2000)
end)
TeleportTab:AddButton("Snow", function()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(1300, 100, -1200)
end)

-- Fruit Tab
local FruitTab = Window:AddTab("Fruit")
FruitTab:AddButton("ESP Fruits", function()
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v:IsA("Tool") then
            local esp = Instance.new("BillboardGui", v)
            esp.Size = UDim2.new(0,100,0,40)
            esp.AlwaysOnTop = true
            local txt = Instance.new("TextLabel", esp)
            txt.Text = "DEVIL FRUIT"
            txt.Size = UDim2.new(1,0,1,0)
            txt.TextColor3 = Color3.new(1,0,1)
            txt.BackgroundTransparency = 1
        end
    end
end)

FruitTab:AddToggle("Auto Grab Fruit", false, function(v)
    _G.autoFruit = v
    while _G.autoFruit and wait(1) do
        for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                firetouchinterest(plr.Character.HumanoidRootPart, v.Handle, 0)
                wait()
                firetouchinterest(plr.Character.HumanoidRootPart, v.Handle, 1)
            end
        end
    end
end)

-- Misc Tab
local MiscTab = Window:AddTab("Misc")
MiscTab:AddButton("Anti AFK", function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VIM:SendKeyEvent(true, "Space", false, game)
        wait(1)
        VIM:SendKeyEvent(false, "Space", false, game)
    end)
end)

MiscTab:AddButton("No Clip", function()
    _G.clip = true
    game:GetService("RunService").Stepped:Connect(function()
        if _G.clip then
            for _,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)

MiscTab:AddButton("Fly", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Hp4vH1bw"))()
end)

MiscTab:AddButton("Destroy GUI", function()
    game.CoreGui:FindFirstChild("Rix GUI"):Destroy()
end)
