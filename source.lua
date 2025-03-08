local Meozlib = {}
Meozlib.__index = Meozlib
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Themes = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        Bar = Color3.fromRGB(0, 170, 255),
        Blur = Color3.fromRGB(50, 50, 50),
        Shadow = Color3.fromRGB(20, 20, 20)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 245),
        Text = Color3.fromRGB(0, 0, 0),
        Bar = Color3.fromRGB(0, 120, 255),
        Blur = Color3.fromRGB(200, 200, 200),
        Shadow = Color3.fromRGB(150, 150, 150)
    },
    Pink = {
        Background = Color3.fromRGB(240, 150, 200),
        Text = Color3.fromRGB(255, 255, 255),
        Bar = Color3.fromRGB(255, 100, 150),
        Blur = Color3.fromRGB(220, 130, 180),
        Shadow = Color3.fromRGB(200, 100, 150)
    }
}
local UIVersion = "1.2.0"
function Meozlib.new()
    local self = setmetatable({}, Meozlib)
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "MeozlibUI"
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.Blur = Instance.new("BlurEffect")
    self.Blur.Size = 0
    self.Blur.Parent = game.Lighting
    self.Blur.Enabled = true
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 300, 0, 180)
    self.MainFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    self.MainFrame.BackgroundColor3 = Themes.Dark.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.BackgroundTransparency = 0
    self.MainFrame.Parent = self.ScreenGui
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = self.MainFrame
    self.Shadow = Instance.new("ImageLabel")
    self.Shadow.Name = "Shadow"
    self.Shadow.BackgroundTransparency = 1
    self.Shadow.Image = "rbxassetid://1316045217"
    self.Shadow.ImageColor3 = Themes.Dark.Shadow
    self.Shadow.ImageTransparency = 0.6
    self.Shadow.Size = UDim2.new(1, 40, 1, 40)
    self.Shadow.Position = UDim2.new(0, -20, 0, -20)
    self.Shadow.ZIndex = -1
    self.Shadow.Parent = self.MainFrame
    self.Title = Instance.new("TextLabel")
    self.Title.Size = UDim2.new(0.7, 0, 0, 40)
    self.Title.Position = UDim2.new(0.15, 0, 0, 10)
    self.Title.BackgroundTransparency = 1
    self.Title.Text = "Meozhub"
    self.Title.TextColor3 = Themes.Dark.Text
    self.Title.TextSize = 24
    self.Title.Font = Enum.Font.GothamBold
    self.Title.TextXAlignment = Enum.TextXAlignment.Center
    self.Title.Parent = self.MainFrame
    self.VersionText = Instance.new("TextLabel")
    self.VersionText.Size = UDim2.new(0.3, 0, 0, 20)
    self.VersionText.Position = UDim2.new(0.7, 0, 0, 20)
    self.VersionText.BackgroundTransparency = 1
    self.VersionText.Text = "v" .. UIVersion
    self.VersionText.TextColor3 = Themes.Dark.Text
    self.VersionText.TextSize = 14
    self.VersionText.Font = Enum.Font.Gotham
    self.VersionText.TextXAlignment = Enum.TextXAlignment.Right
    self.VersionText.Visible = false
    self.VersionText.Parent = self.MainFrame
    self.ProgressBar = Instance.new("Frame")
    self.ProgressBar.Size = UDim2.new(0.9, 0, 0, 10)
    self.ProgressBar.Position = UDim2.new(0.05, 0, 0.5, 0)
    self.ProgressBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    self.ProgressBar.Parent = self.MainFrame
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = self.ProgressBar
    self.ProgressFill = Instance.new("Frame")
    self.ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    self.ProgressFill.BackgroundColor3 = Themes.Dark.Bar
    self.ProgressFill.BorderSizePixel = 0
    self.ProgressFill.Parent = self.ProgressBar
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = self.ProgressFill
    self.LoadingText = Instance.new("TextLabel")
    self.LoadingText.Size = UDim2.new(1, 0, 0, 30)
    self.LoadingText.Position = UDim2.new(0, 0, 0.65, 0)
    self.LoadingText.BackgroundTransparency = 1
    self.LoadingText.Text = "Loading..."
    self.LoadingText.TextColor3 = Themes.Dark.Text
    self.LoadingText.TextSize = 16
    self.LoadingText.Font = Enum.Font.Gotham
    self.LoadingText.TextXAlignment = Enum.TextXAlignment.Center
    self.LoadingText.Parent = self.MainFrame
    self.CountryText = Instance.new("TextLabel")
    self.CountryText.Size = UDim2.new(1, 0, 0, 20)
    self.CountryText.Position = UDim2.new(0, 0, 0.85, 0)
    self.CountryText.BackgroundTransparency = 1
    self.CountryText.Text = ""
    self.CountryText.TextColor3 = Themes.Dark.Text
    self.CountryText.TextSize = 14
    self.CountryText.Font = Enum.Font.Gotham
    self.CountryText.TextXAlignment = Enum.TextXAlignment.Center
    self.CountryText.Visible = false
    self.CountryText.Parent = self.MainFrame
    self.CurrentTheme = "Dark"
    self.Messages = {}
    return self
end
function Meozlib:SetTitle(titleText)
    self.Title.Text = titleText or "Meozhub"
end
function Meozlib:ToggleTransparency(enabled)
    local tweenInfo = TweenInfo.new(0.3)
    local goal = enabled and {BackgroundTransparency = 0.5} or {BackgroundTransparency = 0}
    TweenService:Create(self.MainFrame, tweenInfo, goal):Play()
end
function Meozlib:ToggleBlur(enabled)
    local tweenInfo = TweenInfo.new(0.5)
    local goal = enabled and {Size = 15} or {Size = 0}
    TweenService:Create(self.Blur, tweenInfo, goal):Play()
end
function Meozlib:SetTheme(themeName)
    local theme = Themes[themeName] or Themes.Dark
    self.CurrentTheme = themeName
    self.MainFrame.BackgroundColor3 = theme.Background
    self.Title.TextColor3 = theme.Text
    self.VersionText.TextColor3 = theme.Text
    self.LoadingText.TextColor3 = theme.Text
    self.CountryText.TextColor3 = theme.Text
    self.ProgressFill.BackgroundColor3 = theme.Bar
    self.Shadow.ImageColor3 = theme.Shadow
    if self.ColorCorrection then
        self.ColorCorrection.TintColor = theme.Blur
    else
        self.ColorCorrection = Instance.new("ColorCorrectionEffect")
        self.ColorCorrection.TintColor = theme.Blur
        self.ColorCorrection.Parent = game.Lighting
    end
end
function Meozlib:ToggleVersion(enabled)
    self.VersionText.Visible = enabled
end
function Meozlib:ToggleCountry(enabled)
    if enabled then
        local success, result = pcall(function()
            local ip = game:HttpGet("https://api.ipify.org")
            local country = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/" .. ip)).country
            self.CountryText.Text = "Country: " .. country
            self.CountryText.Visible = true
        end)
        if not success then
            self.CountryText.Text = "Country: Unavailable"
            self.CountryText.Visible = true
        end
    else
        self.CountryText.Visible = false
    end
end
function Meozlib:StartLoading(messages, durationPerMessage)
    self.Messages = messages or {}
    durationPerMessage = durationPerMessage or 2
    local totalDuration = #self.Messages > 0 and (#self.Messages * durationPerMessage) or 3
    
    local tweenInfo = TweenInfo.new(totalDuration)
    local tween = TweenService:Create(self.ProgressFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    self.MainFrame.BackgroundTransparency = 1
    self.MainFrame:TweenSizeAndPosition(
        UDim2.new(0, 350, 0, 200),
        UDim2.new(0.5, -175, 0.5, -100),
        "Out",
        "Quad",
        0.3,
        true
    )
    TweenService:Create(self.MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    spawn(function()
        if #self.Messages > 0 then
            for i, msg in ipairs(self.Messages) do
                self.LoadingText.Text = msg
                wait(durationPerMessage)
            end
        end
        local dots = 0
        while wait(0.3) do
            dots = (dots + 1) % 4
            self.LoadingText.Text = "Loading" .. string.rep(".", dots)
            if self.ProgressFill.Size.X.Scale >= 1 then
                break
            end
        end
    end)
    tween:Play()
end
function Meozlib:Destroy()
    self:ToggleBlur(false)
    TweenService:Create(self.MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    self.MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.3, true, function()
        self.ScreenGui:Destroy()
        self.Blur:Destroy()
        if self.ColorCorrection then
            self.ColorCorrection:Destroy()
        end
    end)
end
local loader = Meozlib.new()
loader:SetTitle("Meozhub | By mytai")
loader:ToggleTransparency(true)
loader:ToggleBlur(true)
loader:SetTheme("Pink")
loader:ToggleVersion(true)
loader:ToggleCountry(true)

local messages = {"Checking files...", "Verifying assets...", "Loading resources..."}
loader:StartLoading(messages, 2)

wait(8)
loader:Destroy()
wait(9)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo cửa sổ chính
local Window = Rayfield:CreateWindow({
    Name = "Meozhub",
    Icon = 11575879600,
    LoadingTitle = "Meozhub loading",
    LoadingSubtitle = "by Mytai",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Meozhub",
        FileName = "MeozhubConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "your_discord_invite_code", -- Thay bằng mã mời Discord thật
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Meozhub | Keys",
        Subtitle = "link in zalo",
        Note = "Get key from our Zalo group!",
        FileName = "MeozhubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"skibidi"}
    }
})

-- Tạo các tab
local MainTab = Window:CreateTab("Main", "rewind")
local AttackTab = Window:CreateTab("Attack", "rewind")
local MiscTab = Window:CreateTab("Misc", "rewind")
local MusicTab = Window:CreateTab("Music", "rewind")
local AboutTab = Window:CreateTab("About", "rewind")

-- Dịch vụ và biến toàn cục
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- Biến trạng thái
local pushEnabled, infJumpEnabled, autoGrabEnabled, espEnabled = false, false, false, false
local aimbotEnabled, aimheadEnabled, autoDamageEnabled, noclipEnabled = false, false, false, false
local flyEnabled, autoFlyToPlayerEnabled, autoKillEntitiesEnabled = false, false, false
local espColor = Color3.fromRGB(255, 0, 0)
local pushDistance, grabRange, grabSpeed = 10, 15, 2
local damageRange, attackSpeed, entityKillRange = 10, 0.5, 50
local flySpeed = 50
local espTags = {}
local disconnectJump, disconnectBounce, flyDisable, musicSound

-- Biến lưu tham chiếu cho các phần tử UI
local walkSpeedSlider, jumpPowerSlider, teleportDropdown, musicDropdown

-- Hàm thông báo chung
local function notify(title, content, image)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 6.5,
        Image = image
    })
end

-- Hàm gửi Webhook
local function sendWebhook(message)
    local webhookUrl = "https://discord.com/api/webhooks/your_webhook_id/your_webhook_token" -- Thay bằng URL webhook thật
    local data = {
        ["content"] = message,
        ["username"] = "Meozhub Bot",
        ["avatar_url"] = "https://www.roblox.com/asset-thumbnail/image?assetId=11575879600"
    }
    local success, err = pcall(function()
        game:HttpPost(webhookUrl, HttpService:JSONEncode(data), "application/json")
    end)
    if not success then warn("[ERROR] Webhook failed: " .. err) end
end

-- Thông báo khi load với tên executor và gửi webhook
local executorName = identifyexecutor and identifyexecutor() or "Unknown Executor"
notify("Meozhub Loaded", "Script loaded successfully on " .. executorName .. "!", 4483362458)
sendWebhook("Player " .. player.Name .. " loaded Meozhub on " .. executorName .. " at " .. os.date("%X"))

-- Xử lý tái sinh nhân vật
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    if infJumpEnabled then
        humanoid.JumpPower = 0
        disconnectJump = setupInfiniteJump()
        disconnectBounce = setupBounceEffect()
    end
    if flyEnabled then flyDisable = enableFly() end
    if autoDamageEnabled then damageLoop = task.spawn(autoDamageLoop) end
    if noclipEnabled then enableNoclip() end
    if autoKillEntitiesEnabled then entityKillLoop = task.spawn(autoKillEntities) end
end)

-- === Tính năng Push ===
local function pushObject(object)
    if not object:IsA("BasePart") or object.Anchored then return end
    local distance = (object.Position - humanoidRootPart.Position).Magnitude
    if distance <= pushDistance then
        local direction = (object.Position - humanoidRootPart.Position).Unit
        object.Position = humanoidRootPart.Position + direction * pushDistance
    end
end

local function pushLoopFunc()
    while pushEnabled do
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then pushObject(plr.Character:FindFirstChild("HumanoidRootPart")) end
        end
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("BasePart") and not obj.Parent:FindFirstChildOfClass("Humanoid") then pushObject(obj) end
        end
        task.wait(0.1)
    end
end

MainTab:CreateToggle({
    Name = "Enable Push",
    CurrentValue = false,
    Flag = "PushToggle",
    Callback = function(Value)
        pushEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Push " .. status)
        if pushEnabled then
            pushLoop = task.spawn(pushLoopFunc)
            notify("Push Enabled", "Push activated!", 4483362458)
        else
            notify("Push Disabled", "Push deactivated!", 4463096168)
        end
    end
})

MainTab:CreateSlider({
    Name = "Push Distance",
    Range = {5, 100},
    Increment = 5,
    Suffix = "Studs",
    CurrentValue = 10,
    Flag = "PushDistanceSlider",
    Callback = function(Value)
        pushDistance = Value
        warn("[INFO] Push Distance: " .. Value .. " studs")
    end
})

-- === Tính năng Infinite Jump ===
local function createJumpEffect()
    local particle = Instance.new("ParticleEmitter")
    particle.Texture = "rbxassetid://243664672"
    particle.Lifetime = NumberRange.new(0.5, 1)
    particle.Rate = 100
    particle.Speed = NumberRange.new(5, 10)
    particle.Parent = humanoidRootPart
    task.delay(0.3, particle.Destroy, particle)
end

local function setupInfiniteJump()
    local connection = UserInputService.JumpRequest:Connect(function()
        if infJumpEnabled then
            humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 100, humanoidRootPart.Velocity.Z)
            createJumpEffect()
        end
    end)
    return function() connection:Disconnect() end
end

local function setupBounceEffect()
    local stateConnection = humanoid.StateChanged:Connect(function(_, newState)
        if infJumpEnabled and newState == Enum.HumanoidStateType.Freefall then
            humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 20, humanoidRootPart.Velocity.Z)
            createJumpEffect()
        end
    end)
    return function() stateConnection:Disconnect() end
end

MiscTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        infJumpEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Infinite Jump " .. status)
        if infJumpEnabled then
            humanoid.JumpPower = 0
            disconnectJump = setupInfiniteJump()
            disconnectBounce = setupBounceEffect()
            notify("Infinite Jump Enabled", "Infinite jump activated!", 4483362458)
        else
            if disconnectJump then disconnectJump() end
            if disconnectBounce then disconnectBounce() end
            humanoid.JumpPower = 50
            humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z)
            notify("Infinite Jump Disabled", "Infinite jump turned off!", 4463096168)
        end
    end
})

-- === Tính năng Auto Grab ===
local function grabObject(object)
    if not object:IsA("BasePart") or object.Anchored then return end
    local distance = (object.Position - humanoidRootPart.Position).Magnitude
    if distance <= grabRange then
        local goal = { Position = humanoidRootPart.Position + Vector3.new(0, 2, 0) }
        local tweenInfo = TweenInfo.new(grabSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(object, tweenInfo, goal)
        tween:Play()
        local clickDetector = object:FindFirstChildOfClass("ClickDetector")
        if clickDetector then
            tween.Completed:Connect(function()
                if (object.Position - humanoidRootPart.Position).Magnitude <= 2 then fireclickdetector(clickDetector) end
            end)
        end
    end
end

local function autoGrabLoop()
    while autoGrabEnabled do
        for _, object in pairs(workspace:GetChildren()) do
            if object:IsA("BasePart") and not object.Anchored and not object.Parent:FindFirstChildOfClass("Humanoid") then
                grabObject(object)
            end
        end
        task.wait(0.5)
    end
end

MainTab:CreateToggle({
    Name = "Auto Grab Items",
    CurrentValue = false,
    Flag = "GrabToggle",
    Callback = function(Value)
        autoGrabEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Auto Grab " .. status)
        if autoGrabEnabled then
            grabLoop = task.spawn(autoGrabLoop)
            notify("Auto Grab Enabled", "Auto grab activated!", 4483362458)
        else
            notify("Auto Grab Disabled", "Auto grab turned off!", 4463096168)
        end
    end
})

-- === Tính năng ESP (Đã sửa lỗi) ===
local function createOrUpdateESP(target, text, offset)
    if not target or not target:IsA("BasePart") then return end
    local billboard = espTags[target]
    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Tag"
        billboard.Adornee = target
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = offset
        billboard.AlwaysOnTop = true
        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextColor3 = espColor
        billboard.Parent = target
        espTags[target] = billboard
    end
    local textLabel = billboard:FindFirstChildOfClass("TextLabel")
    if textLabel then textLabel.Text = text end
end

local function clearESP(target)
    local billboard = espTags[target]
    if billboard then
        billboard:Destroy()
        espTags[target] = nil
    end
end

local function updateESP()
    if not espEnabled or not character or not humanoidRootPart then return end
    local successes, errors = 0, 0
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if root and humanoid and humanoid.Health > 0 then
                local success, err = pcall(function()
                    local distance = (root.Position - humanoidRootPart.Position).Magnitude
                    if distance <= espRadius then
                        createOrUpdateESP(root, plr.Name .. " | HP: " .. math.floor(humanoid.Health), Vector3.new(0, 3, 0))
                    else
                        clearESP(root)
                    end
                end)
                if success then
                    successes = successes + 1
                else
                    errors = errors + 1
                    warn("[ESP ERROR] Failed to update for " .. plr.Name .. ": " .. err)
                end
            end
        end
    end
    if errors > 0 then
        notify("ESP Update Warning", "Failed to update " .. errors .. " entities!", 88315346204643)
    end
end

MainTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        espEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] ESP " .. status)
        if espEnabled then
            espLoop = task.spawn(function()
                while espEnabled do
                    updateESP()
                    task.wait(0.5)
                end
            end)
            notify("ESP Enabled", "ESP activated successfully!", 4483362458)
        else
            for target, _ in pairs(espTags) do clearESP(target) end
            notify("ESP Disabled", "ESP turned off!", 4463096168)
        end
    end
})

MainTab:CreateColorPicker({
    Name = "ESP Color",
    Color = espColor,
    Flag = "ESPColorPicker",
    Callback = function(Value)
        espColor = Value
        for _, billboard in pairs(espTags) do
            local textLabel = billboard:FindFirstChildOfClass("TextLabel")
            if textLabel then textLabel.TextColor3 = espColor end
        end
    end
})

-- === Tính năng Aimbot và Aimhead ===
local function findNearestEnemy()
    if not character or not humanoidRootPart then return nil end
    local nearestEnemy, shortestDistance = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and (not plr.Team or plr.Team ~= player.Team) and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if root and humanoid and humanoid.Health > 0 then
                local distance = (root.Position - humanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEnemy = plr
                end
            end
        end
    end
    return nearestEnemy
end

local function aimbot()
    while aimbotEnabled do
        if not camera or not humanoidRootPart then
            notify("Aimbot Error", "Camera or character not loaded!", 88315346204643)
            task.wait(1)
        else
            local target = findNearestEnemy()
            if target and target.Character then
                local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
                end
            end
        end
        task.wait(0.01)
    end
end

local function aimhead()
    while aimheadEnabled do
        if not camera or not humanoidRootPart then
            notify("Aimhead Error", "Camera or character not loaded!", 88315346204643)
            task.wait(1)
        else
            local target = findNearestEnemy()
            if target and target.Character then
                local targetHead = target.Character:FindFirstChild("Head")
                if targetHead then
                    local direction = (targetHead.Position - camera.CFrame.Position).Unit
                    local newLook = camera.CFrame.LookVector:Lerp(direction, 0.1)
                    camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + newLook)
                end
            end
        end
        task.wait(0.01)
    end
end

AttackTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        aimbotEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Aimbot " .. status)
        if aimbotEnabled then
            aimbotLoop = task.spawn(aimbot)
            notify("Aimbot Enabled", "Aimbot activated!", 4483362458)
        else
            notify("Aimbot Disabled", "Aimbot turned off!", 4463096168)
        end
    end
})

AttackTab:CreateToggle({
    Name = "Aimhead",
    CurrentValue = false,
    Flag = "AimheadToggle",
    Callback = function(Value)
        aimheadEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Aimhead " .. status)
        if aimheadEnabled then
            aimheadLoop = task.spawn(aimhead)
            notify("Aimhead Enabled", "Aimhead activated!", 4483362458)
        else
            notify("Aimhead Disabled", "Aimhead turned off!", 4463096168)
        end
    end
})

-- === Tính năng Auto Damage ===
local function getDamageTool()
    if not character then return nil end
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then return tool end
    end
    return nil
end

local function damageTarget(target)
    local tool = getDamageTool()
    local targetHumanoid = target:FindFirstChildOfClass("Humanoid")
    if targetHumanoid and targetHumanoid.Health > 0 then
        if tool then
            local handle = tool:FindFirstChild("Handle")
            if handle then
                firetouchinterest(handle, target:FindFirstChild("HumanoidRootPart") or target, 1)
                task.wait(0.01)
                firetouchinterest(handle, target:FindFirstChild("HumanoidRootPart") or target, 0)
            end
        else
            targetHumanoid:TakeDamage(10)
        end
    end
end

local function autoDamageLoop()
    while autoDamageEnabled do
        if not humanoidRootPart then
            notify("Auto Damage Error", "Character not loaded!", 88315346204643)
            task.wait(1)
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                local targetRoot = obj:FindFirstChild("HumanoidRootPart") or (obj:IsA("BasePart") and obj)
                if humanoid and humanoid.Health > 0 and targetRoot and targetRoot ~= humanoidRootPart then
                    local distance = (targetRoot.Position - humanoidRootPart.Position).Magnitude
                    if distance <= damageRange then
                        damageTarget(obj)
                    end
                end
            end
        end
        task.wait(attackSpeed)
    end
end

AttackTab:CreateToggle({
    Name = "Auto Damage",
    CurrentValue = false,
    Flag = "AutoDamageToggle",
    Callback = function(Value)
        autoDamageEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Auto Damage " .. status)
        if autoDamageEnabled then
            if not getDamageTool() then
                notify("Auto Damage Warning", "No tool equipped, using direct damage!", 4483362458)
            end
            damageLoop = task.spawn(autoDamageLoop)
            notify("Auto Damage Enabled", "Auto damage activated!", 4483362458)
        else
            notify("Auto Damage Disabled", "Auto damage turned off!", 4463096168)
        end
    end
})

AttackTab:CreateSlider({
    Name = "Damage Range",
    Range = {5, 100},
    Increment = 5,
    Suffix = "Studs",
    CurrentValue = 10,
    Flag = "DamageRangeSlider",
    Callback = function(Value)
        damageRange = Value
        warn("[INFO] Damage Range: " .. Value .. " studs")
    end
})

AttackTab:CreateSlider({
    Name = "Attack Speed",
    Range = {0.1, 2},
    Increment = 0.1,
    Suffix = "Seconds",
    CurrentValue = 0.5,
    Flag = "AttackSpeedSlider",
    Callback = function(Value)
        attackSpeed = Value
        warn("[INFO] Attack Speed: " .. Value .. " seconds")
    end
})

-- === Tính năng Auto Kill Entities ===
local function autoKillEntities()
    while autoKillEntitiesEnabled do
        if not humanoidRootPart then
            notify("Auto Kill Error", "Character not loaded!", 88315346204643)
            task.wait(1)
        else
            for _, obj in pairs(workspace:GetDescendants()) do
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                local targetRoot = obj:FindFirstChild("HumanoidRootPart") or (obj:IsA("BasePart") and obj)
                if humanoid and humanoid.Health > 0 and targetRoot and targetRoot ~= humanoidRootPart then
                    local distance = (targetRoot.Position - humanoidRootPart.Position).Magnitude
                    if distance <= entityKillRange then
                        humanoid:TakeDamage(1000) -- Sát thương cực lớn
                        warn("[INFO] Auto Killed: " .. (obj.Name or "Unnamed Entity"))
                    end
                end
            end
        end
        task.wait(2) -- Tốc độ cố định 2 giây
    end
end

AttackTab:CreateToggle({
    Name = "Auto Kill Entities",
    CurrentValue = false,
    Flag = "AutoKillEntitiesToggle",
    Callback = function(Value)
        autoKillEntitiesEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Auto Kill Entities " .. status)
        if autoKillEntitiesEnabled then
            entityKillLoop = task.spawn(autoKillEntities)
            notify("Auto Kill Entities Enabled", "Killing all entities in range!", 4483362458)
        else
            notify("Auto Kill Entities Disabled", "Auto kill turned off!", 4463096168)
        end
    end
})

AttackTab:CreateSlider({
    Name = "Kill Range",
    Range = {5, 200},
    Increment = 5,
    Suffix = "Studs",
    CurrentValue = 50,
    Flag = "EntityKillRangeSlider",
    Callback = function(Value)
        entityKillRange = Value
        warn("[INFO] Entity Kill Range: " .. Value .. " studs")
    end
})

-- === Tính năng Fly ===
local function enableFly()
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = humanoidRootPart

    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 10000
    bg.Parent = humanoidRootPart

    humanoid.PlatformStand = true

    local noclipConnection = RunService.Stepped:Connect(function()
        if flyEnabled then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)

    local function updateFly()
        if not flyEnabled then
            bv.Velocity = Vector3.new(0, 0, 0)
            return
        end
        local direction = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction -= camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction -= camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then direction += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then direction -= Vector3.new(0, 1, 0) end

        if direction.Magnitude > 0 then
            bv.Velocity = direction.Unit * flySpeed
        else
            bv.Velocity = Vector3.new(0, 0, 0)
        end
        bg.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + camera.CFrame.LookVector)
    end

    local flyConnection = RunService.RenderStepped:Connect(updateFly)
    return function()
        flyConnection:Disconnect()
        noclipConnection:Disconnect()
        bv:Destroy()
        bg:Destroy()
        humanoid.PlatformStand = false
        humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

MiscTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        flyEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Fly " .. status)
        if flyEnabled then
            flyDisable = enableFly()
            notify("Fly Enabled", "Fly with noclip activated!", 4483362458)
        else
            if flyDisable then flyDisable() end
            notify("Fly Disabled", "Fly turned off!", 4463096168)
        end
    end
})

local flySpeedSlider = MiscTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 10,
    Suffix = "Studs/s",
    CurrentValue = 50,
    Flag = "FlySpeedSlider",
    Callback = function(Value)
        flySpeed = Value
        warn("[INFO] Fly Speed: " .. Value .. " studs/s")
    end
})

-- === Tính năng Noclip ===
local function enableNoclip()
    local noclipConnection = RunService.Stepped:Connect(function()
        if noclipEnabled then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
    return function() noclipConnection:Disconnect() end
end

MiscTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        noclipEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Noclip " .. status)
        if noclipEnabled then
            noclipDisable = enableNoclip()
            notify("Noclip Enabled", "Noclip activated!", 4483362458)
        else
            if noclipDisable then
                noclipDisable()
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
            notify("Noclip Disabled", "Noclip turned off!", 4463096168)
        end
    end
})

-- === Tính năng Teleport ===
local teleportTargets = {}
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player then table.insert(teleportTargets, plr.Name) end
end

teleportDropdown = MiscTab:CreateDropdown({
    Name = "Select Player to Teleport",
    Options = teleportTargets,
    CurrentOption = "",
    Flag = "TeleportDropdown",
    Callback = function(Value)
        warn("[INFO] Selected player to teleport: " .. Value)
    end
})

MiscTab:CreateButton({
    Name = "Teleport",
    Callback = function()
        local targetName = teleportDropdown.CurrentOption
        if targetName then
            local target = Players:FindFirstChild(targetName)
            if target and target.Character then
                local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    humanoidRootPart.CFrame = targetRoot.CFrame
                    warn("[INFO] Teleported to " .. targetName)
                    notify("Teleport Success", "Teleported to " .. targetName, 4483362458)
                else
                    notify("Teleport Error", "Target has no HumanoidRootPart!", 88315346204643)
                end
            else
                notify("Teleport Error", "Target not found or offline!", 88315346204643)
            end
        else
            notify("Teleport Error", "Please select a player first!", 88315346204643)
        end
    end
})

-- === Tính năng Auto Fly to Player ===
local function autoFlyToPlayerLoop()
    while autoFlyToPlayerEnabled do
        local targetName = teleportDropdown.CurrentOption
        local target = Players:FindFirstChild(targetName)
        if target and target.Character then
            local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local direction = (targetRoot.Position - humanoidRootPart.Position).Unit
                humanoidRootPart.Velocity = direction * flySpeed
            end
        end
        task.wait(0.1)
    end
end

MiscTab:CreateToggle({
    Name = "Auto Fly to Player",
    CurrentValue = false,
    Flag = "AutoFlyToggle",
    Callback = function(Value)
        autoFlyToPlayerEnabled = Value
        local status = Value and "Đã Bật" or "Đã Tắt"
        warn("[INFO] Auto Fly to Player " .. status)
        if autoFlyToPlayerEnabled then
            if not teleportDropdown.CurrentOption then
                notify("Auto Fly Error", "Please select a player from dropdown!", 88315346204643)
                autoFlyToPlayerEnabled = false
            else
                autoFlyLoop = task.spawn(autoFlyToPlayerLoop)
                notify("Auto Fly Enabled", "Flying to selected player!", 4483362458)
            end
        else
            notify("Auto Fly Disabled", "Auto fly turned off!", 4463096168)
        end
    end
})

-- === Tính năng Walkspeed và Jump Power ===
local function updateSpeedAndJump()
    RunService.Heartbeat:Connect(function()
        if humanoid then
            humanoid.WalkSpeed = walkSpeedSlider and walkSpeedSlider.CurrentValue or 16
            humanoid.JumpPower = jumpPowerSlider and jumpPowerSlider.CurrentValue or 50
        end
    end)
end
updateSpeedAndJump()

-- === Tính năng Music ===
local musicList = {
    ["Rick Roll"] = "rbxassetid://1838457617",
    ["Epic Sax Guy"] = "rbxassetid://130775431",
    ["Darude Sandstorm"] = "rbxassetid://142295087"
}

musicDropdown = MusicTab:CreateDropdown({
    Name = "Select Song",
    Options = {"Rick Roll", "Epic Sax Guy", "Darude Sandstorm"},
    CurrentOption = "",
    Flag = "MusicDropdown",
    Callback = function(Value)
        if musicSound then
            musicSound:Stop()
            musicSound:Destroy()
            musicSound = nil
        end
        warn("[INFO] Selected song: " .. Value)
    end
})

MusicTab:CreateButton({
    Name = "Play Song",
    Callback = function()
        local songName = musicDropdown.CurrentOption
        if songName and musicList[songName] then
            if musicSound then
                musicSound:Stop()
                musicSound:Destroy()
            end
            musicSound = Instance.new("Sound")
            musicSound.SoundId = musicList[songName]
            musicSound.Parent = player.Character and player.Character:FindFirstChild("Head") or game.Workspace
            musicSound:Play()
            notify("Music Playing", "Now playing: " .. songName, 4483362458)
        else
            notify("Music Error", "Please select a song first!", 88315346204643)
        end
    end
})

-- === About Tab ===
AboutTab:CreateLabel("Code by Mytai")
AboutTab:CreateLabel("UI by Sirius")

-- Tải cấu hình
Rayfield:LoadConfiguration()
