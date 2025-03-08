local UniverseID = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://apis.roblox.com/universes/v1/places/"..game.PlaceId.."/universe")).universeId
print("LL")

if game.PlaceId == 116495829188952 then -- deadtrain 
    print("Loading script for deadtrain")
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mytai20100/Meozhub/refs/heads/main/Deadtrain.lua"))()
    end)
    if not success then print("Failed to load Deadtrain script: " .. err) end
elseif game.GameId == 2753915549 or game.GameId == 7449423635 then
    print("Loading script for Boxfruit:")
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mytai20100/Meozhub/refs/heads/main/Boxfruit.lua"))()
    end)
    if not success then print("Failed to load Boxfruit script: " .. err) end
elseif game.GameId == nil then
    print("Loading script for PlaceId: nil")
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Mytai20100/Meozhub/refs/heads/main/source.lua"))()
    end)
    if not success then print("Failed to load source script: " .. err) end
else
    print("Fail: Game ID not supported")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Mytai20100/Meozhub/refs/heads/main/source.lua"))()
end
