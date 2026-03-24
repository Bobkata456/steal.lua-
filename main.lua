--[[
    SOLAR & XENO VISUAL MOCKUP
    Mode: UI/UX Testing (Non-Functional)
    Status: Safe / Visual Only
]]

local p = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = p:WaitForChild("PlayerGui") end)
ScreenGui.Name = "RobloxAppVisual"
ScreenGui.ResetOnSpawn = false

-- Главна рамка
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 480)
Main.Position = UDim2.new(0.5, -190, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(25, 27, 31)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Позволява местенето на панела

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 4)

local Title = Instance.new("TextLabel", Main)
Title.Text = "Add account"
Title.Size = UDim2.new(1, 0, 0, 80)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.BackgroundTransparency = 1

--- Сегмент за полетата (Направени само за гледане) ---

local function CreateVisualBox(placeholder, text, pos, isPass)
    local Box = Instance.new("TextBox", Main)
    Box.PlaceholderText = placeholder
    Box.Text = text
    Box.Size = UDim2.new(0.85, 0, 0, 45)
    Box.Position = pos
    Box.BackgroundColor3 = Color3.fromRGB(35, 37, 41)
    Box.TextColor3 = Color3.fromRGB(150, 150, 150) -- По-блед цвят
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 16
    Box.TextEditable = false -- Забранява писането
    Box.ClearTextOnFocus = false
    
    if isPass then Box.TextPassword = true end
    
    local UserCorner = Instance.new("UICorner", Box)
    UserCorner.CornerRadius = UDim.new(0, 6)
    return Box
end

local UserDisplay = CreateVisualBox("Username/Email/Phone", p.Name, UDim2.new(0.075, 0, 0.18, 0), false)
local PassDisplay = CreateVisualBox("Password", "********", UDim2.new(0.075, 0, 0.3, 0), true)

-- Log In Button (Визуален)
local Submit = Instance.new("TextButton", Main)
Submit.Text = "Log In"
Submit.Size = UDim2.new(0.85, 0, 0, 42)
Submit.Position = UDim2.new(0.075, 0, 0.42, 0)
Submit.BackgroundColor3 = Color3.fromRGB(35, 37, 41)
Submit.TextColor3 = Color3.fromRGB(100, 100, 100)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 16
Submit.AutoButtonColor = false -- Спира кликането

local SubmitCorner = Instance.new("UICorner", Submit)
SubmitCorner.CornerRadius = UDim.new(0, 6)
local Stroke = Instance.new("UIStroke", Submit)
Stroke.Color = Color3.fromRGB(80, 80, 80)
Stroke.Thickness = 1

-- Декоративни линкове
local function CreateStaticLink(text, pos, hasBg)
    local l = Instance.new("TextLabel", Main) -- Променено на Label за безопасност
    l.Text = text
    l.Size = UDim2.new(0.85, 0, 0, 30)
    l.Position = pos
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 15
    l.BackgroundTransparency = hasBg and 0 or 1
    if hasBg then
        l.BackgroundColor3 = Color3.fromRGB(45, 47, 51)
        Instance.new("UICorner", l).CornerRadius = UDim.new(0, 6)
    end
    return l
end

CreateStaticLink("Forgot Password or Username?", UDim2.new(0.075, 0, 0.52, 0), false)
CreateStaticLink("Email Me a One-Time Code", UDim2.new(0.075, 0, 0.65, 0), true)
CreateStaticLink("Quick Sign-in", UDim2.new(0.075, 0, 0.75, 0), true)
CreateStaticLink("Create A New Account", UDim2.new(0.075, 0, 0.88, 0), false)

print("Visual UI loaded. Note: Interactions are disabled for security.")
